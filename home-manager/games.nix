# https://github.com/TophC7/play.nix/blob/main/modules/home/gamescoperun.nix
{ pkgs, lib, ... }:
let
  mainMonitor = {
    name = "HDMI-A-1";
    width = 1920;
    height = 1080;
    refreshRate = 120;
    hdr = false;
    vrr = false;
  };
  # Wayland Surface Interface
  wsi = true;
  inherit (pkgs) gamescope;
  gamescope-wsi = pkgs.gamescope-wsi or null;

  baseOptions = {
    backend = "sdl";
    fade-out-duration = 200;
    fullscreen = true;
    immediate-flips = true;
    nested-refresh = mainMonitor.refreshRate;
    output-height = mainMonitor.height;
    output-width = mainMonitor.width;
    rt = true;
  }
  // lib.optionalAttrs mainMonitor.vrr {
    adaptive-sync = true;
  };

  environment = {
    AMD_VULKAN_ICD = "RADV";
    DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1 = 1;
    DISABLE_LAYER_NV_OPTIMUS_1 = 1;
    GAMESCOPE_WAYLAND_DISPLAY = "gamescope-0";
    PROTON_ADD_CONFIG = "sdlinput,wayland";
    PROTON_ENABLE_WAYLAND = 1;
    RADV_PERFTEST = "aco";
    SDL_VIDEODRIVER = "wayland";
  }
  // lib.optionalAttrs wsi {
    ENABLE_GAMESCOPE_WSI = 1;
  }
  // lib.optionalAttrs mainMonitor.hdr {
    DXVK_HDR = 1;
    ENABLE_HDR_WSI = 1;
    PROTON_ENABLE_HDR = 1;
  };
  allEnvVars = lib.unique (
    lib.attrNames environment
    ++ [
      # Add wrapper communication variables
      "GAMESCOPE_USE_HDR"
      "GAMESCOPE_USE_WSI"
      "GAMESCOPE_USE_SYSTEMD"
      "GAMESCOPE_WRAPPER_ENV"
    ]
  );

  # Helper to convert Nix attrs to gamescope command-line arguments
  toCliArgs =
    attrs:
    let
      argToString =
        name: value:
        if builtins.isBool value then if value then "--${name}" else "" else "--${name} ${toString value}";

      # Filter out empty strings to avoid extra spaces
      nonEmptyArgs = lib.filter (s: s != "") (lib.mapAttrsToList argToString attrs);
    in
    lib.concatStringsSep " " nonEmptyArgs;

  #
  gamescoperun = pkgs.writeScriptBin "gamescoperun" ''
    #!${lib.getExe pkgs.fish}

    # Smart environment display function - dynamically discovers all relevant variables
    function show_environment
        echo -e "\033[1;36m[gamescoperun]\033[0m Environment:"
        
        # Dynamically check all configured environment variables
        for var in ${lib.concatStringsSep " " allEnvVars}
            if set -q $var
                set -l value (eval echo \$$var)
                if test -n "$value"
                    echo -e "    \033[1;33m$var\033[0m=\033[0;35m$value\033[0m"
                else
                    echo -e "    \033[1;33m$var\033[0m=\033[0;31m(empty/disabled)\033[0m"
                end
            end
        end
        
        # Show any additional environment variables that might be set by wrappers
        # but not in our known list (discovery mode)
        for var in (env | grep -E '^(GAMESCOPE_|ENABLE_|DXVK_|PROTON_|RADV_|AMD_|SDL_)' | cut -d= -f1 | sort -u)
            set -l already_shown false
            for known_var in ${lib.concatStringsSep " " allEnvVars}
                if test "$var" = "$known_var"
                    set already_shown true
                    break
                end
            end
            
            if not $already_shown
                if set -q $var
                    set -l value (eval echo \$$var)
                    echo -e "    \033[1;33m$var\033[0m=\033[0;35m$value\033[0m \033[0;90m(discovered)\033[0m"
                end
            end
        end
    end

    # Parse arguments early to handle -x flag properly
    argparse -i 'x/extra-args=' -- $argv
    if test $status -ne 0
        exit 1
    end

    # Early exit for nested gamescope sessions
    if set -q GAMESCOPE_WAYLAND_DISPLAY
        echo -e "\033[1;33m[gamescoperun]\033[0m Already inside Gamescope session ($GAMESCOPE_WAYLAND_DISPLAY), running command directly..."
        exec $argv
    end

    # Validate we have a command to run
    if test (count $argv) -eq 0
        echo "Usage: gamescoperun [-x|--extra-args \"<options>\"] <command> [args...]"
        echo ""
        echo "Examples:"
        echo "  gamescoperun heroic"
        echo "  gamescoperun -x \"--fsr-upscaling-sharpness 5\" steam"
        echo ""
        echo "Note: GAMESCOPE_EXTRA_OPTS is legacy - prefer using -x/--extra-args"
        exit 1
    end

    # Set base environment from Nix configuration
    ${lib.concatStringsSep "\n" (
      lib.mapAttrsToList (
        name: value: "set -gx ${name} ${lib.escapeShellArg (toString value)}"
      ) environment
    )}

    # Process wrapper-specific environment overrides
    if set -q GAMESCOPE_WRAPPER_ENV
        for pair in (string split ';' -- "$GAMESCOPE_WRAPPER_ENV")
            if test -n "$pair"
                set parts (string split -m 1 '=' -- "$pair")
                if test (count $parts) -eq 2
                    set -gx $parts[1] "$parts[2]"
                end
            end
        end
    end

    function apply_wrapper_override
        set -l var_name $argv[1]
        set -l true_action $argv[2]
        set -l false_action $argv[3]
        
        if set -q $var_name
            set -l value (eval echo \$$var_name)
            switch "$value"
                case "true" "1"
                    eval $true_action
                case "false" "0"
                    eval $false_action
            end
        end
    end

    # HDR overrides
    apply_wrapper_override GAMESCOPE_USE_HDR \
        'set -gx ENABLE_HDR_WSI 1; set -gx DXVK_HDR 1; set -gx PROTON_ENABLE_HDR 1' \
        'set -gx ENABLE_HDR_WSI ""; set -gx DXVK_HDR ""; set -gx PROTON_ENABLE_HDR ""'

    # WSI overrides
    apply_wrapper_override GAMESCOPE_USE_WSI \
        'set -gx ENABLE_GAMESCOPE_WSI 1' \
        'set -gx ENABLE_GAMESCOPE_WSI ""'

    # Build gamescope arguments with proper precedence
    set -l final_args ${toCliArgs baseOptions}

    # Add HDR args based on wrapper preference or global default
    set -l add_hdr_flags false
    if set -q GAMESCOPE_USE_HDR
        if test "$GAMESCOPE_USE_HDR" = "true"
            set add_hdr_flags true
        end
        # If GAMESCOPE_USE_HDR is "false", add_hdr_flags stays false
    else if test "${if mainMonitor.hdr then "true" else "false"}" = "true"
        set add_hdr_flags true
    end

    if test "$add_hdr_flags" = "true"
        set -a final_args --hdr-enabled --hdr-debug-force-output --hdr-debug-force-support
    end

    # Track WSI status for workaround detection
    set -l wsi_enabled false
    if set -q GAMESCOPE_USE_WSI
        if test "$GAMESCOPE_USE_WSI" = "true" -o "$GAMESCOPE_USE_WSI" = "1"
            set wsi_enabled true
        end
    else if test "${if wsi then "true" else "false"}" = "true"
        set wsi_enabled true
    end

    # Wayland backend + WSI + HDR workaround
    # When all three are active, the child process needs DISABLE_HDR_WSI=1
    # to trick gamescope into properly enabling HDR
    set -l needs_hdr_workaround false
    set -l current_backend "${baseOptions.backend or "sdl"}"
    if test "$current_backend" = "wayland" -a "$wsi_enabled" = "true" -a "$add_hdr_flags" = "true"
        set needs_hdr_workaround true
    end

    # Add user-provided extra arguments (primary method)
    if set -q _flag_extra_args
        set -a final_args (string split ' ' -- $_flag_extra_args)
    end

    # Support legacy GAMESCOPE_EXTRA_OPTS (discouraged but functional)
    if set -q GAMESCOPE_EXTRA_OPTS
        echo -e "\033[1;33m[gamescoperun]\033[0m Warning: GAMESCOPE_EXTRA_OPTS is legacy, prefer -x/--extra-args"
        set -a final_args (string split ' ' -- $GAMESCOPE_EXTRA_OPTS)
    end

    # Determine systemd usage
    set -l use_systemd false
    if set -q GAMESCOPE_USE_SYSTEMD
        switch "$GAMESCOPE_USE_SYSTEMD"
            case "1" "true"
                set use_systemd true
            case "0" "false"
                set use_systemd false
        end
    else if test "false" = "true"
        set use_systemd true
    end

    # Display final environment state for debugging
    show_environment

    # Execute gamescope with assembled configuration
    set -l gamescope_cmd ${lib.getExe gamescope}

    # Build child command, applying HDR workaround if needed
    set -l child_cmd $argv
    if test "$needs_hdr_workaround" = "true"
        echo -e "\033[1;35m[gamescoperun]\033[0m Applying wayland+WSI+HDR workaround (DISABLE_HDR_WSI=1 for child)"
        set child_cmd env DISABLE_HDR_WSI=1 $argv
    end

    if test "$use_systemd" = "true"
        echo -e "\033[1;36m[gamescoperun]\033[0m Running: \033[1;34msystemd-run --user --quiet --same-dir --service-type=exec --setenv=DISPLAY --setenv=WAYLAND_DISPLAY\033[0m $gamescope_cmd $final_args \033[1;32m--\033[0m $child_cmd"
        exec systemd-run --user --quiet --same-dir --service-type=exec --setenv=DISPLAY --setenv=WAYLAND_DISPLAY $gamescope_cmd $final_args -- $child_cmd
    else
        echo -e "\033[1;36m[gamescoperun]\033[0m Running: \033[1;34m$gamescope_cmd\033[0m $final_args \033[1;32m--\033[0m $child_cmd"
        exec $gamescope_cmd $final_args -- $child_cmd
    end
  '';
in
{
  home.packages = [
    gamescoperun
  ]
  ++ [ gamescope ]
  ++ lib.optionals (gamescope-wsi != null) [ gamescope-wsi ];
}
