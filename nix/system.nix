{
  pkgs,
  config,
  ...
}:
{
  ####################
  #   BOOTLOADER
  ####################

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 5;

    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "nowatchdog"
    ];
    initrd = {
      availableKernelModules = [
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      kernelModules = [ ];
    };

    # extraModprobeConfig = ''
    #   options nvidia_modeset vblank_sem_control=0
    # '';
  };

  ####################
  #   NETWORKING
  ####################

  networking.hostName = "dooshii"; # Define your hostname.
  systemd.network.wait-online.enable = false;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  # To configure wifi, use `nmtui`
  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [
    "1.1.1.1"
    "8.8.8.8"
    "9.9.9.9"
  ];
  networking.firewall.enable = false;
  # Routes *.test websites to localhost. among other things
  services.dnsmasq = {
    enable = true;
    settings = {
      address = [
        "/test/127.0.0.1"
      ];
    };
  };

  ####################
  #   LOCALIZATION / TIME
  ####################

  # https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  time.timeZone = "Pacific/Auckland";
  # time.timeZone = "Australia/Melbourne";
  # time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_NZ.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_NZ.UTF-8";
    LC_IDENTIFICATION = "en_NZ.UTF-8";
    LC_MEASUREMENT = "en_NZ.UTF-8";
    LC_MONETARY = "en_NZ.UTF-8";
    LC_NAME = "en_NZ.UTF-8";
    LC_NUMERIC = "en_NZ.UTF-8";
    LC_PAPER = "en_NZ.UTF-8";
    LC_TELEPHONE = "en_NZ.UTF-8";
    LC_TIME = "en_NZ.UTF-8";
  };

  ####################
  #   DISPLAY
  ####################

  # # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "nz";
    variant = "";
  };

  ####################
  #   SLEEP / SUSPEND
  ####################

  powerManagement.enable = true;

  ####################
  #   PRINTING
  ####################

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  ####################
  #   AUDIO
  ####################

  # Enable sound with pipewire.
  # sound.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  ####################
  #   KEYBOARD AND CONTROLLERS
  ####################
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"
    KERNEL=="uinput", GROUP="input", MODE="0660", OPTIONS+="static_node=uinput"
  '';
  users.groups.plugdev = { };
  users.users.dooshii.extraGroups = [
    "plugdev"
    "input"
  ];
  services.udev.packages = with pkgs; [
    game-devices-udev-rules
  ];
  hardware.uinput.enable = true;

  console = {
    earlySetup = true;
    colors = builtins.map config.lib.theme.withoutHash (
      with config.lib.theme.colors;
      [
        base00 # black [background]
        base08 # red
        base0B # green
        base09 # orange
        base0D # blue
        base0E # purple
        base0C # cyan
        base04 # light fg [light grey]
        # Bright
        base02 # bright black [bg highlight]
        base12 # pink
        base14 # lime
        base0A # yellow
        base16 # bright blue
        base17 # bright magenta
        base15 # bright cyan
        base06 # white [fg raised]
      ]
    );
  };
}
