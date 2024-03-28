{
  lib,
  PROJECT_ROOT,
  ...
}:
with lib.hm.gvariant; {
  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        gtk-enable-primary-paste = false;
      };
      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 10;
        resize-with-right-button = true;
      };

      "org/gnome/shell" = {
        "favorite-apps" = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
      };
      "org/gnome/shell/keybindings" = {
        "switch-to-application-1" = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        "switch-to-application-2" = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        "switch-to-application-3" = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        "switch-to-application-4" = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        "switch-to-application-5" = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        "switch-to-application-6" = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        "switch-to-application-7" = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        "switch-to-application-8" = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        "switch-to-application-9" = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        "switch-to-application-10" = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
      };

      "org/gnome/desktop/wm/keybindings" = {
        # Window commands
        close = ["<Super>w"];
        activate-window-menu = ["<Super>space"];

        # Z-order
        toggle-above = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        always-on-top = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        raise = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        lower = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        raise-or-lower = lib.gvariant.mkEmptyArray lib.gvariant.type.string;

        # Window size
        begin-resize = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        maximize = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        unmaximize = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        toggle-maximized = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        maximize-horizontally = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        maximize-vertically = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        minimize = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        toggle-fullscreen = lib.gvariant.mkEmptyArray lib.gvariant.type.string;

        # Window move
        begin-move = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-center = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-corner-ne = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-corner-nw = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-corner-se = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-corner-sw = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-monitor-up = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-monitor-down = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-monitor-left = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-monitor-right = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-side-n = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-side-s = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-side-e = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-side-w = lib.gvariant.mkEmptyArray lib.gvariant.type.string;

        # Misc?
        panel-main-menu = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        panel-run-dialog = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        set-spew-mark = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        show-desktop = lib.gvariant.mkEmptyArray lib.gvariant.type.string;

        # Workspace commands
        switch-to-workspace-1 = ["<Super>1"];
        switch-to-workspace-2 = ["<Super>2"];
        switch-to-workspace-3 = ["<Super>3"];
        switch-to-workspace-4 = ["<Super>4"];
        switch-to-workspace-5 = ["<Super>5"];
        switch-to-workspace-6 = ["<Super>6"];
        switch-to-workspace-7 = ["<Super>7"];
        switch-to-workspace-8 = ["<Super>8"];
        switch-to-workspace-9 = ["<Super>9"];
        switch-to-workspace-10 = ["<Super>0"];
        switch-to-workspace-down = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        switch-to-workspace-last = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        switch-to-workspace-left = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        switch-to-workspace-right = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        switch-to-workspace-up = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-workspace-1 = ["<Shift><Super>1"];
        move-to-workspace-2 = ["<Shift><Super>2"];
        move-to-workspace-3 = ["<Shift><Super>3"];
        move-to-workspace-4 = ["<Shift><Super>4"];
        move-to-workspace-5 = ["<Shift><Super>5"];
        move-to-workspace-6 = ["<Shift><Super>6"];
        move-to-workspace-7 = ["<Shift><Super>7"];
        move-to-workspace-8 = ["<Shift><Super>8"];
        move-to-workspace-9 = ["<Shift><Super>9"];
        move-to-workspace-10 = ["<Shift><Super>0"];
        move-to-workspace-down = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-workspace-last = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-workspace-left = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-workspace-right = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        move-to-workspace-up = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        toggle-on-all-workspaces = lib.gvariant.mkEmptyArray lib.gvariant.type.string;

        # Window switching
        switch-applications = ["<Super>Tab"];
        switch-applications-backward = ["<Shift><Super>Tab"];
        switch-group = ["<Super>Above_Tab"];
        switch-group-backward = ["<Shift><Super>Above_Tab"];
        switch-windows = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        switch-windows-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        switch-panels = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        switch-panels-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        cycle-group = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        cycle-group-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        cycle-panels = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        cycle-panels-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        cycle-windows = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        cycle-windows-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;

        # Accessibility
        switch-input-source = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
        switch-input-source-backward = lib.gvariant.mkEmptyArray lib.gvariant.type.string;
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        home = ["<Super>e"];
        # These keyboard commands should be sensibly defaulted.
        # Regardless, you can override them here.

        custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>t";
        command = "alacritty";
        name = "Open terminal";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        binding = "<Super>m";
        command = "${PROJECT_ROOT}/scripts/system/open-eww-overlay music-overlay";
        name = "Toggle EWW music overlay";
      };
    };
  };
}
