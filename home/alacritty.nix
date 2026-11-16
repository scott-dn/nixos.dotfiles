# Alacritty terminal: One Dark colors, JetBrainsMono Nerd Font, maximized undecorated window, zsh as shell.
{ ... }:
{
  programs.alacritty = {
    enable = true;

    settings = {
      general.live_config_reload = true;

      terminal.shell.program = "zsh";

      env.TERM = "xterm-256color";

      colors = {
        primary = {
          background = "0x1e2127";
          foreground = "0xabb2bf";
        };
        normal = {
          black = "0x1e2127";
          red = "0xe06c75";
          green = "0x98c379";
          yellow = "0xd19a66";
          blue = "0x61afef";
          magenta = "0xc678dd";
          cyan = "0x56b6c2";
          white = "0xabb2bf";
        };
        bright = {
          black = "0x5c6370";
          red = "0xe06c75";
          green = "0x98c379";
          yellow = "0xd19a66";
          blue = "0x61afef";
          magenta = "0xc678dd";
          cyan = "0x56b6c2";
          white = "0xffffff";
        };
      };

      cursor.style = {
        shape = "Block";
        blinking = "Always";
      };

      font = {
        size = 11.0;
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Italic";
        };
        bold_italic = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold Italic";
        };
        offset = {
          x = 0;
          y = 5;
        };
      };

      # builtins.fromJSON is needed because Nix strings have no \u escapes.
      keyboard.bindings = [
        # Shift+Enter: terminals send plain CR, so apps cannot tell it from Enter.
        #   ESC+CR is the sequence TUIs read as "insert a newline, do not submit".
        {
          key = "Return";
          mods = "Shift";
          chars = "${builtins.fromJSON ''"\u001b"''}\r";
        }

        # Ctrl+Backspace: send ESC+DEL (same as Alt+Backspace) so it deletes a word.
        {
          key = "Back";
          mods = "Control";
          chars = builtins.fromJSON ''"\u001b\u007f"'';
        }
      ];

      window = {
        decorations = "None";
        dynamic_title = true;
        startup_mode = "Maximized";
        option_as_alt = "OnlyLeft";
        dimensions = {
          columns = 150;
          lines = 35;
        };
        padding = {
          x = 15;
          y = 15;
        };
      };
    };
  };
}
