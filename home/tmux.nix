# tmux: truecolor passthrough, mouse, arrow-key pane navigation, top status bar.
{ pkgs, ... }:
let
  # Metric scripts are called directly rather than via the plugins' #{...}
  # placeholders: those are substituted into status-right when the plugin loads,
  # and home-manager loads plugins before extraConfig runs.
  cpu = "${pkgs.tmuxPlugins.cpu}/share/tmux-plugins/cpu/scripts";
  battery = "${pkgs.tmuxPlugins.battery}/share/tmux-plugins/battery/scripts";
in
{
  programs.tmux = {
    enable = true;

    # Default is "screen", which has no 256-colour or italics support.
    terminal = "tmux-256color";

    shell = "${pkgs.zsh}/bin/zsh";

    mouse = true;
    escapeTime = 10; # ms; low so <Esc> in nvim is not read as a sequence
    focusEvents = true; # lets nvim see FocusGained/FocusLost (autoread, autosave)

    extraConfig = ''
      # Tell tmux the outer terminal does 24-bit colour, otherwise themes get
      # quantised to 256 colours. terminal-features is the tmux 3.2+ spelling.
      set -as terminal-features ",*:RGB"

      # Pane navigation without the vi keys.
      bind-key Up    select-pane -U
      bind-key Down  select-pane -D
      bind-key Left  select-pane -L
      bind-key Right select-pane -R

      # Status bar at the top, window list centred, metrics on the right.
      set -g status-position top
      set -g status-interval 5
      set -g status-justify centre

      # Left: pane index.
      set -g status-left-length 90
      set -g status-left "#[fg=black,bg=white,bold]  #P  "

      # Middle: window list.
      setw -g window-status-current-format "#[fg=black,bg=green,bold]  #I #W  "

      # Right: date, time, cpu, mem, disk, battery.
      set -g status-right-length 120
      set -g status-right "#[fg=black,bg=white,bold] 📅 %-d %b %Y - %H:%M │ CPU(🧠) #(${cpu}/cpu_percentage.sh) │ Mem(📝) #(${cpu}/ram_percentage.sh) │ Disk(💾) #(df -h / | awk 'NR==2{print $5}') │ 🔋 #(${battery}/battery_percentage.sh) "
    '';
  };
}
