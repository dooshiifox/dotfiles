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
    };
  };
}
