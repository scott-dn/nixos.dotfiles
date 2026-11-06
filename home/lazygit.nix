# Lazygit TUI: render diffs through diff-so-fancy.
{ ... }:
{
  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        diffRenderers = [
          {
            colorArg = "always";
            command = "diff-so-fancy";
          }
        ];
      };
    };
  };
}
