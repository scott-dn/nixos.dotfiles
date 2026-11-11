# KDE Plasma via plasma-manager: dark theme, wallpaper, keyboard layout/repeat, touchpad, shortcuts, panel, desktop widgets.
{ pkgs, ... }:
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

    input.touchpads = [
      {
        name = "SNSL0028:00 2C2F:0028 Touchpad";
        vendorId = "2c2f";
        productId = "0028";

        pointerSpeed = 0.03;
        naturalScroll = true;
        tapAndDrag = false;
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

    desktop.widgets = [
      {
        name = "org.kde.plasma.calendar";
        position = {
          horizontal = 32;
          vertical = 32;
        };
        size = {
          width = 420;
          height = 290;
        };
      }
    ];
  };
}
