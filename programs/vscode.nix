{
  config,
  pkgs,
  inputs,
  ...
}: {
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-marketplace; [
      alexcvzz.vscode-sqlite
      alexisvt.flutter-snippets
      astro-build.astro-vscode
      bbenoist.nix
      bmalehorn.vscode-fish
      bradlc.vscode-tailwindcss
      burkeholland.simple-react-snippets
      chrisbibby.hide-node-modules
      christian-kohler.npm-intellisense
      ctcuff.font-preview
      dart-code.dart-code
      dart-code.flutter
      dbaeumer.vscode-eslint
      donjayamanne.githistory
      esbenp.prettier-vscode
      eww-yuck.yuck
      expo.vscode-expo-tools
      firefox-devtools.vscode-firefox-debug
      formulahendry.auto-rename-tag
      geodesdk.geode
      github.copilot
      github.copilot-chat
      ms-azuretools.vscode-docker
      ms-dotnettools.csdevkit
      ms-dotnettools.csharp
      ms-dotnettools.vscode-dotnet-runtime
      # ms-dotnettools.vscodeintellicode-csharp
      msjsdiag.vscode-react-native
      ms-python.black-formatter
      ms-python.debugpy
      ms-python.pylint
      ms-python.python
      ms-python.vscode-pylance
      # ms-vscode.cmake-tools # Crashes build pipeline?
      ms-vscode.cpptools
      ms-vscode.remote-explorer
      ms-vscode-remote.remote-containers
      ms-vscode-remote.remote-ssh
      ms-vscode-remote.remote-ssh-edit
      mtxr.sqltools
      mtxr.sqltools-driver-mysql
      mtxr.sqltools-driver-pg
      mtxr.sqltools-driver-sqlite
      oderwat.indent-rainbow
      orta.vscode-jest
      pixl.bevy-snippets
      pkief.material-icon-theme
      prisma.prisma
      redhat.vscode-yaml
      rust-lang.rust-analyzer
      rvest.vs-code-prettier-eslint
      serayuzgur.crates
      simonsiefke.svg-preview
      sukumo28.wav-preview
      svelte.svelte-vscode
      tamasfe.even-better-toml
      twxs.cmake
      # visualstudiotoolsforunity.vstuc # Also crashes build
      wayou.vscode-todo-highlight
      yechunan.json-color-token
      yoavbls.pretty-ts-errors
    ];
  };
  xdg.mimeApps.defaultApplications."text/plain" = "code.desktop";
}
