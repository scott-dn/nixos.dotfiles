# KDE Plasma via plasma-manager: dark theme, wallpaper, keyboard layout/repeat, touchpad, shortcuts, panel (digital clock with calendar popup).
{ ... }:
{
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "BreezeDark";
      # Content-addressed path: ../wallpaper.jpg would resolve into the flake source,
      # whose hash changes on every edit and makes plasma-manager re-run (and wipe) all desktop scripts.
      wallpaper = builtins.path {
        path = ../wallpaper.jpg;
        name = "wallpaper.jpg";
      };
    };

    input.keyboard = {
      layouts = [ { layout = "us"; } ];
      options = [
        "ctrl:swap_lalt_lctl_lwin"
        "ctrl:nocaps"
      ];
      repeatDelay = 200;
      repeatRate = 50;
    };

    # Shared settings are merged into each device; add new machines' touchpads to the list (see /proc/bus/input/devices).
    input.touchpads =
      map
        (
          d:
          {
            pointerSpeed = 0.03;
            naturalScroll = true;
            tapAndDrag = false;
          }
          // d
        )
        [
          {
            name = "SNSL0028:00 2C2F:0028 Touchpad";
            vendorId = "2c2f";
            productId = "0028";
          }
          {
            name = "ELAN0676:00 04F3:3195 Touchpad";
            vendorId = "04f3";
            productId = "3195";
          }
        ];

    hotkeys.commands = {
      "launch-alacritty" = {
        name = "Launch Alacritty";
        key = "Ctrl+Alt+T";
        command = "alacritty";
      };
      "launch-google-chrome" = {
        name = "Launch Google Chrome";
        key = "Ctrl+Alt+C";
        command = "google-chrome";
      };
    };

    shortcuts = {
      kwin = {
        "Overview" = [ "Meta+K" ];
        "Walk Through Windows" = "Ctrl+Tab";
        "Walk Through Windows (Reverse)" = "Ctrl+Shift+Tab";
        "Walk Through Windows of Current Application" = "Ctrl+`";
        "Walk Through Windows of Current Application (Reverse)" = "Ctrl+~";
        "Window Close" = [
          "Alt+F4"
          "Ctrl+Q"
        ];
      };
      "org.kde.krunner.desktop"._launch = [
        "Ctrl+Space"
        "Search"
      ];
    };

    configFile.kdeglobals.KDE.AnimationDurationFactor = 0;
    configFile.kwinrc.ElectricBorders.BottomLeft = "ShowDesktop";

    # KWin launches fcitx5 (System Settings > Virtual Keyboard)
    configFile.kwinrc.Wayland.InputMethod = "/run/current-system/sw/share/applications/org.fcitx.Fcitx5.desktop";

    panels = [
      {
        screen = 0;
        location = "bottom";
        height = 46;
        lengthMode = "fit";
        hiding = "autohide";
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.pager"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          {
            digitalClock = {
              date = {
                enable = true;
                format = "isoDate";
                position = "belowTime";
              };
              calendar.showWeekNumbers = true;
            };
          }
          "org.kde.plasma.showdesktop"
        ];
      }
    ];
  };
}
