# Git
# https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix
{ has_secrets, lib, ... }:
{
  imports = lib.optional has_secrets ../../secrets/git.nix;

  programs.git = {
    enable = true;
    settings = {
      aliases = {
        lgb = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(normal)%s%C(reset) %C(dim white)- %an%C(reset)'";
      };

      init.defaultBranch = "main";

      fetch = {
        prune = true;
        all = true;
        parallel = 0;
      };
      push.autoSetupRemote = true;
      tag.forceSignAnnotated = true;

      # Most of these are taken from this talk
      # https://www.youtube.com/watch?v=aolI_Rz0ZqY

      # Save how merge conflicts were resolved in the past
      # and auto-reapply if found in the future.
      rerere.enabled = true;

      # Change how `git branch` works
      column.ui = "auto";
      branch.sort = "-committerdate";

      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      diff.colorMoved = "default";
      delta = {
        navigate = true; # use n and N to move between diff sections
        dark = true; # or light = true, or omit for auto-detection
        side-by-side = true;
        line-numbers = true;
      };

      merge.conflictStyle = "zdiff3";
    };
  };
}
