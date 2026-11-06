# Zsh: oh-my-zsh, completion, autosuggestions, syntax highlighting, and command aliases (g, ls=lsd, cat=bat, ...).
{ config, ... }:
{
  programs.zsh = {
    enable = true;
    dotDir = config.home.homeDirectory;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
    };

    shellAliases = {
      g = "git";
      cat = "bat";
      ls = "lsd";
      l = "ls -l";
      la = "ls -a";
      lla = "ls -la";
      lt = "ls --tree";
      lg = "lazygit";
      python = "python3";
      p = "pnpm";
      tf = "terraform";
      gd = "Godot";
    };
  };
}
