# Git: identity, GPG commit/tag signing, diff-so-fancy pager, nvim editor, colors and lg/lg1/lg2 log aliases.
{ ... }:
{
  programs.git = {
    enable = true;

    signing = {
      key = "E6128C3A4D1D9080";
      format = "openpgp";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Scott Dang";
        email = "scott.dn91@gmail.com";
      };
      pull.ff = "only";
      init.defaultBranch = "main";

      core = {
        pager = "diff-so-fancy | less --tabs=4 -RFX";
        editor = "nvim";
      };
      interactive.diffFilter = "diff-so-fancy --patch";

      color = {
        ui = true;
        diff = {
          meta = "11";
          frag = "magenta bold";
          func = "146 bold";
          commit = "yellow bold";
          old = "red bold";
          new = "green bold";
          whitespace = "red reverse";
        };
        diff-highlight = {
          oldNormal = "red bold";
          oldHighlight = "red bold 52";
          newNormal = "green bold";
          newHighlight = "green bold 22";
        };
      };

      alias = {
        lg1 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all";
        lg2 = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all";
        lg = "!git lg1";
      };
    };
  };
}
