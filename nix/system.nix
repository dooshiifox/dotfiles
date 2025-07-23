{
  pkgs,
  config,
  ...
}:
{
  # https://support.system76.com/articles/system76-software/#nixos
  hardware.system76.enableAll = true;
  services.power-profiles-daemon.enable = false;

  ####################
  #   BOOTLOADER
  ####################

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.timeout = 5;

    kernelParams = [
      "systemd.mask=systemd-vconsole-setup.service"
      "systemd.mask=dev-tpmrm0.device" # this is to mask that stupid 1.5 mins systemd bug
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
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.insertNameservers = [
    "1.1.1.1"
    "8.8.8.8"
    "9.9.9.9"
  ];
  networking.firewall.enable = false;

  ####################
  #   LOCALIZATION / TIME
  ####################

  time.timeZone = "Pacific/Auckland";
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
  #   KEYBOARD
  ####################
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"
  '';
  users.users.dooshii.extraGroups = [ "plugdev" ];

  ####################
  #   CONTROLLER
  ####################
  # services.udev.extraRules = ''
  #   # Nintendo Switch Pro Controller over USB hidraw
  #   KERNEL=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="2009", MODE="0660", TAG+="uaccess"

  #   # Nintendo Switch Pro Controller over bluetooth hidraw
  #   KERNEL=="hidraw*", KERNELS=="*057E:2009*", MODE="0660", TAG+="uaccess"
  # '';
  services.udev.packages = with pkgs; [
    game-devices-udev-rules
  ];
  hardware.uinput.enable = true;

  ####################
  #   NVIDIA
  ####################

  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = [
      # Video acceleration & Video Decode And Presentation API for Unix
      pkgs.vaapiVdpau
      pkgs.libvdpau
      pkgs.libvdpau-va-gl
      pkgs.nvidia-vaapi-driver
      pkgs.vdpauinfo
      pkgs.libva
      pkgs.libva-utils
    ];
    # extraPackages32 = with pkgs.pkgsi686Linux; [libva];
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ]; # or "nvidiaLegacy470 etc.

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;
    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # nvidiaPersistenced = true;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    # Currently alpha-quality/buggy, so false is currently the recommended setting.
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
    # forceFullCompositionPipeline = true;

    prime = {
      # https://nixos.wiki/wiki/Nvidia
      # sync.enable = true;
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      nvidiaBusId = "PCI:1:0:0";
      intelBusId = "PCI:0:2:0";
    };
  };
}
