{pkgs, ...}: {
  # Enable the GNOME Desktop Environment.
  services.displayManager.defaultSession = "gnome";
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment = {
    systemPackages = with pkgs; [
      wayland
      wl-clipboard
      wlr-randr
    ];
    sessionVariables = {
      GBM_BACKEND = "nvidia-drm";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      WLR_DRM_NO_ATOMIC = "1";
      XDG_SESSION_TYPE = "wayland";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      GDK_BACKEND = "wayland";
      WLR_NO_HARDWARE_CURSORS = "1";
      MOZ_ENABLE_WAYLAND = "1";
      WLR_BACKEND = "vulkan";
      WLR_RENDERER = "vulkan";
      XCURSOR_SIZE = "16";
      NIXOS_OZONE_WL = "1";
    };
  };
}
