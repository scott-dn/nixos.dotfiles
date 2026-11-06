# Home-manager entry point for scott-dang: imports per-tool modules and holds shared packages.
{ pkgs, ... }:
{
  imports = [
    ./alacritty.nix
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

  # User packages installed outside the program modules below (CLI tools, fonts, apps).
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

    terraform
    claude-code
    google-chrome
    slack

    discord
    proton-vpn
    steam
  ];
}
