# Terminal file explorer
# https://github.com/nix-community/home-manager/blob/master/modules/programs/yazi.nix
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
  };

  # nu -c "echo \$env.XDG_DATA_DIRS | split row ':' | where { (\$in | path type) == 'dir' } | each {cd \$in | glob **/*.desktop -l} | flatten | sort"
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "yazi.desktop";
    };
  };
}
