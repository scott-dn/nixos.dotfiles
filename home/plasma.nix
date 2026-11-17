# KDE Plasma via plasma-manager: dark theme, wallpaper, keyboard layout/repeat, touchpad, shortcuts, panel, desktop calendar.
{ ... }:
{
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "BreezeDark";
      wallpaper = ../wallpaper.jpg;
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
    configFile.kwinrc.Wayland.InputMethod = "/run/current-system/sw/share/applications/org.fcitx.Fcitx5.desktop"; # KWin launches fcitx5 (System Settings > Virtual Keyboard)

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
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
      }
    ];

    startup.desktopScript."calendar_widget" = {
      priority = 2; # same stage as the panels script (wallpaper runs at 3)
      runAlways = true; # idempotent, so safe to run at every login
      # Plasma scripting JS, run through plasmashell's evaluateScript at login.
      # On the main screen (screen 0) it adds the calendar only if none exists, and removes extra copies.
      text = ''
        desktops().forEach(function (d) {
          if (d.screen !== 0) return;
          var found = d.widgets("org.kde.plasma.calendar");
          if (found.length === 0) d.addWidget("org.kde.plasma.calendar", 32, 32, 420, 290);
          found.slice(1).forEach(function (x) { x.remove(); });
        });
      '';
    };
  };
}
