# OpenSSH client: github.com uses ~/.ssh/git as its only key and loads it into the agent.
{ ... }:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    settings."github.com" = {
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/git";
      identitiesOnly = true;
      addKeysToAgent = "yes";
    };
  };
}
