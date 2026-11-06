# Neovim via nix4nvchad: NvChad wrapper with LSP servers and formatters on its own PATH.
# Note: programs.neovim must stay disabled, the module asserts on it (colliding nvim binary).
{ pkgs, ... }:
{
  programs.nvchad = {
    enable = true;

    # Don't keep a ~/.config/nvim_<timestamp>.bak per activation.
    backup = false;

    # Language servers and formatters, pinned by flake.lock. Visible to NvChad
    # only, not to the login shell. Register servers in lua/configs/lspconfig.lua.
    extraPackages = with pkgs; [
      # lua
      lua-language-server
      stylua

      # nix
      nixd
      nixfmt

      # ts, js, html, css, yml, markdown, json
      typescript-language-server
      vscode-langservers-extracted # html, css, json, eslint
      prettierd
      yaml-language-server
      marksman

      # bash/shell
      bash-language-server
      shfmt

      # toml
      taplo

      # rust
      rust-analyzer
      rustfmt

      # c++
      clang-tools # clangd + clang-format

      # go
      gopls
      gofumpt
      goimports-reviser
      golines

      # protobuf (pbls is not in nixpkgs; protols is the maintained alternative)
      protols
      buf

      # docker
      docker-compose-language-service
      dockerfile-language-server

      # postgres
      postgres-language-server
      pgformatter # pg_format

      # godot
      gdscript-formatter

      # python
      pyrefly
      ruff

      # terraform
      terraform-ls
    ];
  };
}
