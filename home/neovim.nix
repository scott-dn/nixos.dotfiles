# Neovim: installed with vi/vim aliases and set as default $EDITOR.
{ ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
  };
}
