{
  config,
  pkgs,
  inputs,
  ...
}: let
  mimeTypes = [
    "application/json"
    "text/plain"
  ];
in {
  programs.vscode = {
    enable = true;

    # If I run nix build often enough... Also they're annoying.
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

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
      # orta.vscode-jest # Annoying
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
      # TODO: Local theme
    ];

    userSettings = {
      "workbench.startupEditor" = "none";
      "redhat.telemetry.enabled" = false;
      "workbench.iconTheme" = "material-icon-theme";
      "security.workspace.trust.untrustedFiles" = "open";
      "git.ignoreMissingGitWarning" = true;
      "explorer.confirmDragAndDrop" = false;
      "explorer.confirmDelete" = false;
      "prettier.tabWidth" = 4;
      "editor.rulers" = [
        80
        120
        200
      ];
      "javascript.format.semicolons" = "insert";
      "material-icon-theme.opacity" = 0.8;
      "indentRainbow.colors" = [
        "rgba(242,167,92,0.05)"
        "rgba(242,239,92,0.05)"
        "rgba(159,242,92,0.05)"
        "rgba(92,242,160,0.05)"
        "rgba(92,242,242,0.05)"
        "rgba(92,154,242,0.05)"
        "rgba(129,92,242,0.05)"
        "rgba(232,92,242,0.05)"
      ];
      "prettier.trailingComma" = "none";
      "[html]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[javascript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "javascript.updateImportsOnFileMove.enabled" = "always";
      "[json]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "php.suggest.basic" = false;
      "php.validate.executablePath" = "/usr/bin/php";
      "search.exclude" = {
        "**/*.anim" = true;
        "**/bower_components" = true;
        "**/node_modules" = true;
        "**/target" = true;
        "build/" = true;
        "library/" = true;
        "package-lock.json" = true;
        "temp/" = true;
      };
      "files.exclude" = {
        "**/.git" = true;
        "**/.DS_Store" = true;
        "**/*.meta" = true;
        "library/" = true;
        "local/" = true;
        "temp/" = true;
      };
      "files.associations" = {
        "*.json" = "jsonc";
        "*.html" = "html";
        "*.txt" = "plaintext";
        "*.sqlite" = "sqlite";
        "*.toml" = "toml";
        "*.denit" = "plaintext";
      };
      "terminal.integrated.commandsToSkipShell" = ["language-julia.interrupt"];
      "python.globalModuleInstallation" = true;
      "editor.suggestSelection" = "first";
      "python.languageServer" = "Pylance";
      "workbench.editorAssociations" = {
        "*.ipynb" = "jupyter-notebook";
        "*.ogg" = "default";
      };
      "indentRainbow.errorColor" = "rgba(242,121,92,0.04)";
      "auto-rename-tag.activationOnLanguage" = [
        "html"
        "xml"
        "vue"
      ];
      "indentRainbow.excludedLanguages" = [];
      "extensions.ignoreRecommendations" = true;
      "notebook.cellToolbarLocation" = {
        "default" = "right";
        "jupyter-notebook" = "left";
      };
      "git.enableSmartCommit" = true;
      "typescript.format.semicolons" = "insert";
      "typescript.implementationsCodeLens.enabled" = true;
      "editor.cursorBlinking" = "smooth";
      "editor.cursorSmoothCaretAnimation" = "on";
      "editor.cursorSurroundingLines" = 3;
      "jsonColorToken.cssLanguages" = [
        "css"
        "less"
        "sass"
        "scss"
      ];
      "jsonColorToken.colorTokenCasing" = "Lowercase";
      "jsonColorToken.languages" = [
        "bat"
        "blade"
        "c"
        "css"
        "csharp"
        "cpp"
        "csv"
        "dart"
        "dialog"
        "env"
        "go"
        "hlsl"
        "html"
        "handlebars"
        "ini"
        "json"
        "jsonc"
        "java"
        "javascript"
        "javascriptreact"
        "julia"
        "lua"
        "makefile"
        "markdown"
        "objective-c"
        "objective-cpp"
        "php"
        "perl"
        "perl6"
        "plaintext"
        "powershell"
        "properties"
        "jade"
        "python"
        "r"
        "razor"
        "ruby"
        "rust"
        "spwn"
        "shaderlab"
        "shellscript"
        "svelte"
        "swift"
        "toml"
        "typescript"
        "typescriptreact"
        "vue"
        "xml"
        "yaml"
      ];
      "sqltools.autoOpenSessionFiles" = false;
      "docker.containers.description" = ["Status"];
      "docker.containers.label" = "ContainerName";
      "php.validate.enable" = false;
      "git.autofetch" = true;
      "tailwindCSS.includeLanguages" = {
        "typescript" = "javascript";
        "ts" = "js";
        "blade" = "html";
      };
      "tailwindCSS.emmetCompletions" = true;
      "tailwindCSS.classAttributes" = [
        "class"
        "className"
        "ngClass"
        "classes"
        "enter"
        "leave"
        "enterTo"
        "enterFrom"
        "leaveTo"
        "leaveFrom"
        "style"
        "wrapperStyle"
        "innerStyle"
        "$"
      ];
      "typescript.updateImportsOnFileMove.enabled" = "always";
      "editor.formatOnSave" = true;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.inlineSuggest.enabled" = true;
      "editor.minimap.enabled" = false;
      "editor.fontFamily" = "'DankMono Nerd Font', Consolas, 'Courier New', monospace";
      "editor.fontLigatures" = true;
      "editor.linkedEditing" = true;
      "terminal.integrated.defaultProfile.linux" = "fish";
      "[dart]" = {
        "editor.formatOnSave" = true;
        "editor.defaultFormatter" = "Dart-Code.dart-code";
      };
      "terminal.integrated.enableMultiLinePasteWarning" = false;
      "editor.guides.indentation" = false;
      "editor.bracketPairColorization.enabled" = false;
      "[rust]" = {
        "editor.defaultFormatter" = "rust-lang.rust-analyzer";
      };
      "[svelte]" = {
        "editor.defaultFormatter" = "svelte.svelte-vscode";
      };
      "[typescriptreact]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[prisma]" = {
        "editor.defaultFormatter" = "Prisma.prisma";
      };
      "css.lint.unknownAtRules" = "ignore";
      "svelte.enable-ts-plugin" = true;
      "jsonColorToken.maxNumberOfColorTokens" = 10000;
      "json.schemas" = [
        {
          "fileMatch" = ["/deno.json"];
          "url" = "https://deno.land/x/deno/cli/schemas/config-file.v1.json";
        }
      ];
      "python.analysis.inlayHints.functionReturnTypes" = true;
      "python.analysis.inlayHints.variableTypes" = true;
      "python.analysis.typeCheckingMode" = "basic";
      "rust-analyzer.inlayHints.typeHints.hideClosureInitialization" = true;
      "rust-analyzer.inlayHints.typeHints.hideNamedConstructor" = true;
      "rust-analyzer.inlayHints.lifetimeElisionHints.useParameterNames" = true;
      "rust-analyzer.inlayHints.bindingModeHints.enable" = true;
      "workbench.colorTheme" = "DooshTheme";
      "github.copilot.enable" = {
        "*" = true;
        "plaintext" = true;
        "markdown" = true;
        "scminput" = false;
        "yaml" = true;
        "php" = true;
        "typescriptreact" = true;
        "rust" = false;
        "typescript" = true;
        "dart" = false;
      };
      "tailwindCSS.experimental.classRegex" = ["tailwind\\('([^']*)'\\)"];
      "typescript.inlayHints.enumMemberValues.enabled" = true;
      "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;
      "typescript.inlayHints.parameterNames.enabled" = "literals";
      "typescript.inlayHints.parameterTypes.enabled" = true;
      "typescript.inlayHints.propertyDeclarationTypes.enabled" = true;
      "typescript.inlayHints.variableTypes.enabled" = true;
      "editor.inlayHints.fontSize" = 11;
      "[yuck]" = {
        "editor.defaultFormatter" = "eww-yuck.yuck";
      };
      "[python]" = {
        "editor.formatOnType" = true;
        "editor.defaultFormatter" = "ms-python.black-formatter";
      };
      "git.openRepositoryInParentFolders" = "never";
      "update.showReleaseNotes" = false;
      "editor.inlayHints.padding" = true;
      "editor.inlayHints.enabled" = "offUnlessPressed";
      "editor.guides.bracketPairs" = "active";
      "editor.guides.highlightActiveBracketPair" = true;
      # Set the color of the bracket pairs to white
      "workbench.colorCustomizations" = {
        "editorBracketPairGuide.activeBackground1" = "#ffffff40";
        "editorBracketPairGuide.activeBackground2" = "#ffffff40";
        "editorBracketPairGuide.activeBackground3" = "#ffffff40";
        "editorBracketPairGuide.activeBackground4" = "#ffffff40";
        "editorBracketPairGuide.activeBackground5" = "#ffffff40";
        "editorBracketPairGuide.activeBackground6" = "#ffffff40";
      };
      "[typescript]" = {
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
      };
      "[jsonc]" = {
        "editor.defaultFormatter" = "rvest.vs-code-prettier-eslint";
      };
      "[nix]" = {
        "editor.tabSize" = 2;
      };
      "rust-analyzer.check.command" = "clippy";
      "vs-code-prettier-eslint.prettierLast" = true;
      "sqltools.useNodeRuntime" = true;
      "eslint.format.enable" = true;
      "sqltools.disableNodeDetectNotifications" = true;
      "eslint.probe" = [
        "javascript"
        "javascriptreact"
        "typescript"
        "typescriptreact"
        "html"
        "vue"
        "markdown"
        "svelte"
      ];
      "eslint.validate" = [
        "javascript"
        "javascriptreact"
        "typescript"
        "typescriptreact"
        "svelte"
      ];
      "workbench.editor.empty.hint" = "hidden";
      "javascript.inlayHints.enumMemberValues.enabled" = true;
      "javascript.inlayHints.functionLikeReturnTypes.enabled" = true;
      "javascript.inlayHints.parameterNames.enabled" = "all";
      "javascript.inlayHints.parameterTypes.enabled" = true;
      "javascript.inlayHints.propertyDeclarationTypes.enabled" = true;
      "todohighlight.isCaseSensitive" = false;
      "todohighlight.keywords" = [
        {
          "text" = "TODO:";
          "color" = "#6b571b";
          "backgroundColor" = "#f2c341";
          "overviewRulerColor" = "grey";
          "fontWeight" = "bold";
        }
        {
          "text" = "FIXME:";
          "color" = "#33090d";
          "backgroundColor" = "#e85160";
          "overviewRulerColor" = "grey";
          "fontWeight" = "bold";
        }
        {
          "text" = "NOTE:";
          "color" = "#0b3244";
          "backgroundColor" = "#90cfed";
          "overviewRulerColor" = "grey";
          "fontWeight" = "bold";
        }
      ];
      "terminal.integrated.scrollback" = 5000;
      "terminal.integrated.mouseWheelScrollSensitivity" = 0.3;
      "html.autoCreateQuotes" = false;
      "cmake.configureOnOpen" = true;
      "cmake.showOptionsMovedNotification" = false;
      "diffEditor.ignoreTrimWhitespace" = false;
      "editor.stickyScroll.enabled" = false;
      "[cpp]" = {
        "editor.defaultFormatter" = "ms-vscode.cpptools";
      };
      "dart.debugExternalPackageLibraries" = false;
      "dart.debugSdkLibraries" = false;
      "extensions.autoUpdate" = false;
    };

    keybindings = [
      {
        "key" = "alt+`";
        "command" = "workbench.action.terminal.toggleTerminal";
      }
      {
        "key" = "ctrl+`";
        "command" = "-workbench.action.terminal.toggleTerminal";
      }
      {
        "key" = "f1";
        "command" = "-workbench.action.showCommands";
      }
      {
        "key" = "f1";
        "command" = "extension.peepAll";
      }
      {
        "key" = "ctrl+r";
        "command" = "workbench.action.reloadWindow";
      }
      {
        "key" = "ctrl+r";
        "command" = "-workbench.action.reloadWindow";
        "when" = "isDevelopment";
      }
      {
        "key" = "ctrl+shift+i";
        "command" = "workbench.action.toggleDevTools";
      }
      {
        "key" = "ctrl+shift+i";
        "command" = "-workbench.action.toggleDevTools";
        "when" = "isDevelopment";
      }
      {
        "key" = "ctrl+shift+alt+i";
        "command" = "editor.action.inspectTMScopes";
      }
      {
        "key" = "ctrl+alt+t";
        "command" = "workbench.action.tasks.runTask";
      }
      {
        "key" = "alt+l";
        "command" = "-toggleFindInSelection";
        "when" = "editorFocus";
      }
      {
        "key" = "alt+l";
        "command" = "-toggleSearchEditorContextLines";
        "when" = "inSearchEditor";
      }
      {
        "key" = "alt+l l";
        "command" = "lövelauncher.launch";
      }
      {
        "key" = "alt+l";
        "command" = "-lövelauncher.launch";
      }
      {
        "key" = "ctrl+shift+`";
        "command" = "workbench.action.terminal.new";
        "when" = "terminalProcessSupported || terminalWebExtensionContributedProfile";
      }
      {
        "key" = "ctrl+shift+`";
        "command" = "-workbench.action.terminal.new";
        "when" = "terminalProcessSupported || terminalWebExtensionContributedProfile";
      }
      {
        "key" = "ctrl+c";
        "command" = "workbench.action.terminal.copySelection";
        "when" = "terminalFocus && terminalHasBeenCreated && terminalTextSelected || terminalFocus && terminalProcessSupported && terminalTextSelected";
      }
      {
        "key" = "ctrl+shift+c";
        "command" = "-workbench.action.terminal.copySelection";
        "when" = "terminalFocus && terminalHasBeenCreated && terminalTextSelected || terminalFocus && terminalProcessSupported && terminalTextSelected";
      }
      {
        "key" = "ctrl+v";
        "command" = "workbench.action.terminal.paste";
        "when" = "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported";
      }
      {
        "key" = "ctrl+shift+v";
        "command" = "-workbench.action.terminal.paste";
        "when" = "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported";
      }
      {
        "key" = "shift+alt+up";
        "command" = "editor.action.copyLinesUpAction";
        "when" = "editorTextFocus && !editorReadonly";
      }
      {
        "key" = "ctrl+shift+alt+up";
        "command" = "-editor.action.copyLinesUpAction";
        "when" = "editorTextFocus && !editorReadonly";
      }
      {
        "key" = "shift+alt+down";
        "command" = "editor.action.copyLinesDownAction";
        "when" = "editorTextFocus && !editorReadonly";
      }
      {
        "key" = "ctrl+shift+alt+down";
        "command" = "-editor.action.copyLinesDownAction";
        "when" = "editorTextFocus && !editorReadonly";
      }
      {
        "key" = "shift+alt+up";
        "command" = "-editor.action.insertCursorAbove";
        "when" = "editorTextFocus";
      }
      {
        "key" = "shift+alt+down";
        "command" = "-editor.action.insertCursorBelow";
        "when" = "editorTextFocus";
      }
      {
        "key" = "ctrl+shift+up";
        "command" = "editor.action.insertCursorAbove";
        "when" = "editorTextFocus";
      }
      {
        "key" = "ctrl+shift+up";
        "command" = "-editor.action.insertCursorAbove";
        "when" = "editorTextFocus";
      }
      {
        "key" = "ctrl+shift+down";
        "command" = "editor.action.insertCursorBelow";
        "when" = "editorTextFocus";
      }
      {
        "key" = "ctrl+shift+down";
        "command" = "-editor.action.insertCursorBelow";
        "when" = "editorTextFocus";
      }
      {
        "key" = "shift+enter";
        "command" = "-python.execSelectionInTerminal";
        "when" = "editorTextFocus && !findInputFocussed && !jupyter.ownsSelection && !notebookEditorFocused && !replaceInputFocussed && editorLangId == 'python'";
      }
      {
        "key" = "ctrl+shift+alt+t";
        "command" = "workbench.action.tasks.configureDefaultTestTask";
      }
    ];
  };

  xdg.mimeApps.defaultApplications = builtins.listToAttrs (map (mimeType: {
      name = mimeType;
      value = ["code.desktop"];
    })
    mimeTypes);
}
