# Direnv with nix-direnv: `use flake` in a project's .envrc swaps in its own
# toolchain (node, terraform, ...) on cd, cached across shells. Silent so the
# prompt stays clean.
{ ... }:
{
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    silent = true;
  };
}
