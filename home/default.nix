# Home-manager entry point for scott-dang: imports per-tool modules and holds shared packages.
{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./git.nix
    ./lazygit.nix
    ./neovim.nix
    ./plasma.nix
    ./ssh.nix
    ./starship.nix
    ./tmux.nix
    ./zsh.nix
  ];

  # Release this home-manager config was first created on; do not change.
  home.stateVersion = "26.05";

  # User packages with no module of their own (CLI tools, fonts, apps).
  home.packages = with pkgs; [
    wget
    curl
    ripgrep
    fd
    fzf
    lsd
    bat
    diff-so-fancy
    less
    unzip
    wl-clipboard

    nerd-fonts.jetbrains-mono

    nodejs_26
    pnpm_12

    terraform
    claude-code
    google-chrome
    slack
    goldendict-ng

    discord
    proton-vpn
    steam
    vlc
    qbittorrent
  ];
}
