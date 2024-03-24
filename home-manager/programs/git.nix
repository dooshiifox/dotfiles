# Git
# https://github.com/nix-community/home-manager/blob/master/modules/programs/git.nix
{
  programs.git = {
    enable = true;
    aliases = {
      lgb = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold green)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(normal)%s%C(reset) %C(dim white)- %an%C(reset)'";
    };
    extraConfig = {
      init.defaultBranch = "main";

      # Most of these are taken from this talk
      # https://www.youtube.com/watch?v=aolI_Rz0ZqY

      # Save how merge conflicts were resolved in the past
      # and auto-reapply if found in the future.
      rerere.enabled = true;

      # Change how `git branch` works
      column.ui = "auto";
      branch.sort = "-committerdate";

      # Commit signing
      gpg.format = "ssh";
      # user.signingkey = "~/.ssh/id_rsa.pub";

      # COMMIT SIGNING
      #
      # Per project, run the following commands
      # git config commit.gpgSign true
      #
      # On personal projects
      # .git/config
      # ```
      # [user]
      # signingkey = ~/.ssh/id_ed25519_github_dooshii.pub
      # [remote "origin"]
      # url = git@personal.github.com:dooshiifox/....git
      # ```
      # Note the `git@personal.github.com` and not `git@github.com`
      # This means it will use the `personal.github.com` host in `~/.ssh/config`
      #
      # Similarly for work projects
      # .git/config
      # ```
      # [user]
      # signingkey = ~/.ssh/id_ed25519_<company>.pub
      # [remote "origin"]
      # url = git@<company>.github.com:<Company>/<git repo>.git
      # ```
      # Note the `<company>.github.com` host in `~/.ssh/config`
      #
      # If you ever need to add another host...
      # ```
      # ssh-keygen -C "<email>"
      # # save it as `/home/dooshii/.ssh/id_ed25519_<who>`
      # ssh-add ~/.ssh/id_ed25519_<who>
      # ```
      # and then add it to `~/.ssh/config`
      # ```
      # # ...
      #
      # Host <some-identifier>.github.com
      #     HostName github.com
      #     User <github-username>
      #     PreferredAuthentications publickey
      #     IdentityFile ~/.ssh/id_ed25519_<who>
      #     IdentitiesOnly yes
      # ```
      #
      # Remember to add your SSH authentication and signing keys to GitHub
      #
      # Thank you 10 year old Stack Overflow posts <3
      # https://stackoverflow.com/a/12438179
    };
  };
}
