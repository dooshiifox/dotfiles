# https://github.com/nix-community/home-manager/blob/master/modules/programs/vscode.nix
{pkgs, ...}: let
  mimeTypes = [
    "application/json"
    "text/plain"
  ];
in {
  programs.vscode = {
    enable = true;

    package = pkgs.vscodium;

    profiles.default = {
      # If I run nix build often enough... Also they're annoying.
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      extensions = with pkgs.vscode-marketplace;
        [
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
          expo.vscode-expo-tools
          firefox-devtools.vscode-firefox-debug
          formulahendry.auto-rename-tag
          geodesdk.geode
          gruntfuggly.todo-tree
          haskell.haskell
          inlang.vs-code-extension
          # jnoortheen.nix-ide
          mkhl.direnv
          ms-azuretools.vscode-docker
          ms-dotnettools.csdevkit
          ms-dotnettools.csharp
          ms-dotnettools.vscode-dotnet-runtime
          msjsdiag.vscode-react-native
          ms-python.black-formatter
          ms-python.debugpy
          ms-python.pylint
          ms-python.python
          ms-python.vscode-pylance
          ms-vscode.remote-explorer
          ms-vscode-remote.remote-containers
          ms-vscode-remote.remote-ssh
          ms-vscode-remote.remote-ssh-edit
          mtxr.sqltools
          mtxr.sqltools-driver-mysql
          mtxr.sqltools-driver-pg
          mtxr.sqltools-driver-sqlite
          oderwat.indent-rainbow
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
          usernamehw.errorlens
          # wayou.vscode-todo-highlight
          xdebug.php-debug
          yechunan.json-color-token
          yoavbls.pretty-ts-errors
          zobo.php-intellisense
        ]
        ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "dooshtheme";
            publisher = "dooshii";
            version = "0.0.1";
            sha256 = "sha256-KFiugQc5aToYrpuOpxW2+igFBMHwZ+ZvwFxIdzH8Clo=";
          }
        ];

      userSettings = {
        # Interactions
        "workbench.startupEditor" = "none";
        "redhat.telemetry.enabled" = false;
        "security.workspace.trust.untrustedFiles" = "open";
        "explorer.confirmDragAndDrop" = false;
        "explorer.confirmDelete" = false;
        "editor.suggestSelection" = "first";
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
        "chat.commandCenter.enabled" = false; # copilot is the worst
        "extensions.ignoreRecommendations" = true;
        "extensions.autoUpdate" = false;
        "editor.formatOnSave" = true;
        "editor.inlineSuggest.enabled" = true;
        "editor.minimap.enabled" = false;
        "editor.linkedEditing" = true;
        "terminal.integrated.defaultProfile.linux" = "fish";
        "terminal.integrated.enableMultiLinePasteWarning" = false;
        "update.showReleaseNotes" = false;
        "editor.inlayHints.padding" = true;
        "editor.inlayHints.enabled" = "offUnlessPressed";
        "workbench.editor.empty.hint" = "hidden";
        "terminal.integrated.scrollback" = 5000;
        "terminal.integrated.mouseWheelScrollSensitivity" = 0.3;
        "diffEditor.ignoreTrimWhitespace" = false;

        # Custom file names
        "workbench.editor.customLabels.enabled" = true;
        "workbench.editor.customLabels.patterns" = {
          # For some reason it needs this `/src/` in there
          "**/src/routes/+page.svelte" = "[P] /";
          "**/src/routes/+page.ts" = "[P] /";
          "**/src/routes/+page.server.ts" = "[PS] /";
          "**/src/routes/+layout.svelte" = "[L] /";
          "**/src/routes/+layout.ts" = "[L] /";
          "**/src/routes/+layout.server.ts" = "[LS] /";
          "**/routes/*/+page.svelte" = "[P] /\${dirname}";
          "**/routes/*/+page.ts" = "[P] /\${dirname}";
          "**/routes/*/+page.server.ts" = "[PS] /\${dirname}";
          "**/routes/*/+layout.svelte" = "[L] /\${dirname}";
          "**/routes/*/+layout.ts" = "[L] /\${dirname}";
          "**/routes/*/+layout.server.ts" = "[LS] /\${dirname}";
          "**/routes/**/+page.svelte" = "[P] \${dirname(1)}/\${dirname}";
          "**/routes/**/+page.ts" = "[P] \${dirname(1)}/\${dirname}";
          "**/routes/**/+page.server.ts" = "[PS] \${dirname(1)}/\${dirname}";
          "**/routes/**/+layout.svelte" = "[L] \${dirname(1)}/\${dirname}";
          "**/routes/**/+layout.ts" = "[L] \${dirname(1)}/\${dirname}";
          "**/routes/**/+layout.server.ts" = "[LS] \${dirname(1)}/\${dirname}";
        };

        # File associations
        "workbench.editor.languageDetection" = false;
        "files.associations" = {
          "*.json" = "jsonc";
          "*.html" = "html";
          "*.txt" = "plaintext";
          "*.sqlite" = "sqlite";
          "*.toml" = "toml";
          "*.denit" = "plaintext";
        };
        "workbench.editorAssociations" = {
          "*.ipynb" = "jupyter-notebook";
          "*.ogg" = "default";
        };

        # Theme
        "workbench.colorTheme" = "DooshTheme";
        "window.customTitleBarVisibility" = "auto";
        "window.titleBarStyle" = "custom";
        "workbench.iconTheme" = "material-icon-theme";
        "material-icon-theme.opacity" = 0.8;
        "terminal.integrated.minimumContrastRatio" = 1;
        "editor.fontFamily" = "'DankMono Nerd Font', Consolas, 'Courier New', monospace";
        "editor.fontLigatures" = true;
        "editor.rulers" = [
          80
          120
          200
        ];
        "editor.guides.indentation" = false;
        "editor.bracketPairColorization.enabled" = false;
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
        "editor.cursorBlinking" = "smooth";
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.cursorSurroundingLines" = 3;
        "editor.inlayHints.fontSize" = 11;
        "editor.stickyScroll.enabled" = false;

        # Indent
        "indentRainbow.excludedLanguages" = [];
        "indentRainbow.errorColor" = "rgba(242,121,92,0.04)";
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

        # VSCode color picking
        "jsonColorToken.cssLanguages" = [
          "css"
          "less"
          "sass"
          "scss"
        ];
        "jsonColorToken.colorTokenCasing" = "Lowercase";
        "jsonColorToken.maxNumberOfColorTokens" = 10000;
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
          "nix"
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

        # Todo
        "todo-tree.general.tags" = [
          "todo!"
          "BUG"
          "HACK"
          "FIXME"
          "TODO"
          "XXX"
          "[ ]"
          "[x]"
        ];
        "todo-tree.regex.regex" = "\\s+($TAGS)";
        "todo-tree.regex.regexCaseSensitive" = false;

        # Language-specifics
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[typescript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[rust]" = {
          "editor.defaultFormatter" = "rust-lang.rust-analyzer";
        };
        "[svelte]" = {
          "editor.defaultFormatter" = "svelte.svelte-vscode";
        };
        "[typescriptreact]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[html]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[json]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "json.schemas" = [
          {
            "fileMatch" = ["/deno.json"];
            "url" = "https://deno.land/x/deno/cli/schemas/config-file.v1.json";
          }
        ];
        "[jsonc]" = {
          "editor.defaultFormatter" = "rvest.vs-code-prettier-eslint";
        };
        "[nix]" = {
          "editor.tabSize" = 2;
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
        };
        "[dart]" = {
          "editor.formatOnSave" = true;
          "editor.defaultFormatter" = "Dart-Code.dart-code";
        };
        "[python]" = {
          "editor.formatOnType" = true;
          "editor.defaultFormatter" = "ms-python.black-formatter";
        };
        "[prisma]" = {
          "editor.defaultFormatter" = "Prisma.prisma";
        };
        "[cpp]" = {
          "editor.defaultFormatter" = "ms-vscode.cpptools";
        };

        # Javascript / Typescript
        "javascript.format.semicolons" = "insert";
        "typescript.format.semicolons" = "insert";
        "javascript.updateImportsOnFileMove.enabled" = "always";
        "typescript.updateImportsOnFileMove.enabled" = "always";
        "javascript.inlayHints.enumMemberValues.enabled" = true;
        "typescript.inlayHints.enumMemberValues.enabled" = true;
        "javascript.inlayHints.functionLikeReturnTypes.enabled" = true;
        "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;
        "javascript.inlayHints.parameterNames.enabled" = "all";
        "typescript.inlayHints.parameterNames.enabled" = "literals";
        "typescript.inlayHints.parameterTypes.enabled" = true;
        "javascript.inlayHints.parameterTypes.enabled" = true;
        "typescript.inlayHints.variableTypes.enabled" = true;
        "javascript.inlayHints.propertyDeclarationTypes.enabled" = true;
        "typescript.inlayHints.propertyDeclarationTypes.enabled" = true;
        "typescript.implementationsCodeLens.enabled" = true;
        "svelte.enable-ts-plugin" = true;
        "sherlock.userId" = "b5d3e435-6a8f-44c1-898a-23402e01c950";

        # Formatting
        "prettier.tabWidth" = 4;
        "prettier.trailingComma" = "none";
        "eslint.format.enable" = true;
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
        "vs-code-prettier-eslint.prettierLast" = true;

        # Rust
        "rust-analyzer.inlayHints.typeHints.hideClosureInitialization" = true;
        "rust-analyzer.inlayHints.typeHints.hideNamedConstructor" = true;
        "rust-analyzer.inlayHints.lifetimeElisionHints.useParameterNames" = true;
        "rust-analyzer.inlayHints.bindingModeHints.enable" = true;
        "rust-analyzer.check.command" = "clippy";

        # Python
        "python.globalModuleInstallation" = true;
        "python.languageServer" = "Pylance";
        "python.analysis.inlayHints.functionReturnTypes" = true;
        "python.analysis.inlayHints.variableTypes" = true;
        "python.analysis.typeCheckingMode" = "basic";
        "notebook.cellToolbarLocation" = {
          "default" = "right";
          "jupyter-notebook" = "left";
        };

        # Nix
        "nix.enableLanguageServer" = true;
        "nix.serverSettings" = {
          "nil" = {
            "formatting" = {
              "command" = ["alejandra"];
            };
          };
        };

        # Git
        "git.ignoreMissingGitWarning" = true;
        "git.enableSmartCommit" = true;
        "git.autofetch" = true;
        "git.openRepositoryInParentFolders" = "never";

        # HTML-like & CSS
        "tailwindCSS.includeLanguages" = {
          "typescript" = "javascript";
          "ts" = "js";
          "blade" = "html";
        };
        "tailwindCSS.emmetCompletions" = true;
        "tailwindCSS.experimental.classRegex" = ["tailwind\\('([^']*)'\\)"];
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
        "auto-rename-tag.activationOnLanguage" = [
          "html"
          "xml"
          "vue"
        ];
        "html.autoCreateQuotes" = false;
        "css.lint.unknownAtRules" = "ignore";

        # SQL tools
        "sqltools.autoOpenSessionFiles" = false;
        "sqltools.useNodeRuntime" = true;
        "sqltools.disableNodeDetectNotifications" = true;

        # Docker
        "docker.containers.description" = ["Status"];
        "docker.containers.label" = "ContainerName";

        # Php
        "php.suggest.basic" = false;
        "php.validate.enable" = false;

        # Dart
        "dart.debugExternalPackageLibraries" = false;
        "dart.debugSdkLibraries" = false;

        # C/C++
        "cmake.configureOnOpen" = true;
        "cmake.showOptionsMovedNotification" = false;
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
  };

  xdg.mimeApps.defaultApplications = builtins.listToAttrs (map (mimeType: {
      name = mimeType;
      value = ["codium.desktop"];
    })
    mimeTypes);
}
