# Librewolf web browser
{
  pkgs,
  config,
  lib,
  has_secrets,
  ...
}:
let
  theme = config.lib.theme;
  inherit (theme) colors;
in
{
  imports = lib.optional has_secrets ../../secrets/librewolf.nix;

  home.sessionVariables.BROWSER = "librewolf";

  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf-bin;

    policies = {
      AppAutoUpdate = false;
      BackgroundAppUpdate = false;
      DisableFirefoxStudies = true;
      DisableFirefoxAccounts = true;
      DisableProfileImport = true;
      DisableProfileRefresh = true;
      DisableSetDesktopBackground = true;
      DisablePocket = true;
      DisableTelemetry = true;
      OfferToSaveLogins = false;
      DontCheckDefaultBrowser = true;
    };

    profiles.dooshii = {
      id = 0;
      isDefault = true;

      # FIXING THIS IF NEEDED:
      # Open browser -> F12 -> 3 dots -> Settings
      #   - Enable browser chrome and add-on debugging toolboxes -> Tick
      #   - Enable remote debugging -> Tick
      # Shift + Ctrl + Alt + I -> "Ok" -> Edit in there then copy changes here.
      # No hot-reloading, need to restart the browser to test it. Remote
      # debugging will turn itself off every time you restart the browser.
      userChrome = ''
        :root {
          --bg: ${colors.bg-opacity} !important;
          --toolbarseparator-color: ${colors.border-opacity} !important;
          --chrome-content-separator-color: transparent !important;
          --tab-selected-bgcolor: ${colors.bg-raised-opacity} !important;
          --tab-selected-outline-color: ${colors.border-active-opacity} !important;
          --tabpanel-background-color: transparent !important;
          /* Floating menus */
          --arrowpanel-background: ${colors.bg-raised} !important;
          --arrowpanel-color: ${colors.fg} !important;
          --panel-background: ${colors.bg-raised} !important;
          --panel-color: ${colors.fg} !important;
          /* Background tab text */
          --lwt-text-color: ${colors.fg-secondary} !important;
        }

        :root,
        toolbar,
        #browser,
        #tabbrowser-tabpanels,
        #nav-bar,
        #navigator-toolbox,
        hbox#urlbar-background,
        body {
          background: transparent !important;
        }

        #nav-bar {
          border-top: none !important;
        }

        /* window transparencies */
        #main-window {
          background: var(--bg) !important;
        }

        #urlbar[open] #urlbar-background {
          inset: unset !important;
          left: 2px !important;
          right: 2px !important;
          top: 2px !important;
          height: 36px;
        }
        #urlbar[open] #urlbar-results {
          background: ${colors.bg-raised} !important;
          /* backdrop-filter: blur(12px); */
          border: 0.01px solid var(--arrowpanel-border-color);
          box-shadow: 0 2px 14px rgba(0, 0, 0, 0.13);
          border-radius: var(--toolbarbutton-border-radius);
          padding-top: 0 !important;
        }
        .urlbarView {
          overflow: unset !important;
          margin-top: 4px !important;
          border: unset !important;
        }
        .urlbarView-body-inner {
          border: unset !important;
        }
        menupopup {
          /* backdrop-filter: blur(12px); */
        }
      '';
      userContent = ''
        @-moz-document url("about:home"), url("about:newtab") {
          html {
            --newtab-background-color: transparent !important;
            --newtab-background-color-secondary: ${colors.bg-raised}80 !important;
            --newtab-text-primary-color: ${colors.fg} !important;
            --newtab-text-secondary-color: ${colors.bg-raised} !important;
          }
        }
        @-moz-document regexp(".*youtube\\.com.*") {
          html, html[dark], body, ytd-app, #full-bleed-container, #movie_player {
            background: transparent !important;
          }
        }
        @-moz-document regexp(".*duckduckgo\\.com.*") {
          html, body, .site-wrapper, #header_wrapper, nav::before, nav::after, ul::before {
            background: transparent !important;
            border: none !important;
          }
          #header_wrapper {
            box-shadow: none !important;
          }
        }
        @-moz-document regexp(".*monkeytype\\.com.*") {
          body, html {
            background: transparent !important;
          }
        }

        @-moz-document regexp("(?!.*(about:home|about:newtab|twitch.tv|cryptoswift.eu).*).*") {
          /* breaks on so many websites........ */
          /* :where(html) {
            background: white;
          } */
          :where(#__docusaurus) {
            background: white;
          }
        }
      '';
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Enable customChrome.css
        "svg.context-properties.content.enabled" = true; # Allows for theming specific icons
        "browser.tabs.allow_transparent_browser" = true;
        "browser.uidensity" = 0;
        "extensions.autoDisableScopes" = 0;
        "accessibility.typeaheadfind.flashBar" = 0;
        "app.normandy.first_run" = false;
        "app.normandy.migrationsApplied" = 12;
        "browser.aboutConfig.showWarning" = false;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.contentblocking.category" = "strict";
        "browser.discovery.enabled" = false;
        "browser.eme.ui.firstContentShown" = true;
        "browser.engagement.ctrlTab.has-used" = true;
        "browser.engagement.downloads-button.has-used" = true;
        "browser.engagement.fxa-toolbar-menu-button.has-used" = true;
        "browser.engagement.sidebar-button.has-used" = true;
        "browser.firefox-view.feature-tour" = builtins.toJSON {
          "message" = "FIREFOX_VIEW_FEATURE_TOUR";
          "screen" = "";
          "complete" = true;
        };
        "browser.firefox-view.view-count" = 1;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.startup.page" = 3;
        "browser.tabs.hoverPreview.showThumbnails" = false;
        "browser.tabs.inTitlebar" = 0;
        "browser.theme.toolbar-theme" = 0;
        "browser.toolbarbuttons.introduced.sidebar-button" = true;
        "browser.toolbars.bookmarks.visibility" = "newtab";
        "browser.translations.panelShown" = true;
        "browser.uiCustomization.state" = builtins.toJSON {
          "placements" = {
            "nav-bar" = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "customizableui-special-spring1"
              "vertical-spacer"
              "urlbar-container"
              "customizableui-special-spring2"
              "downloads-button"
              "fxa-toolbar-menu-button"
              "jid1-mnnxcxisbpnsxq_jetpack-browser-action"
              "ublock0_raymondhill_net-browser-action"
              "78272b6fa58f4a1abaac99321d503a20_proton_me-browser-action"
              # "jetpack-extension_dashlane_com-browser-action"
              "unified-extensions-button"
              "fxa-toolbar-menu-button"
              "reset-pbm-toolbar-button"
            ];
            "toolbar-menubar" = [
              "menubar-items"
            ];
            "TabsToolbar" = [
              "tabbrowser-tabs"
              "new-tab-button"
            ];
            "vertical-tabs" = [ ];
            "PersonalToolbar" = [
              "personal-bookmarks"
            ];
          };
          "dirtyAreaCache" = [
            "unified-extensions-area"
            "nav-bar"
            "toolbar-menubar"
            "TabsToolbar"
            "vertical-tabs"
            "PersonalToolbar"
          ];
          "currentVersion" = 23;
          "newElementCount" = 1;
        };
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.urlbar.shortcuts.quickactions" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.quickactions" = false;
        "browser.urlbar.suggest.topsites" = false;
        "clipboard.autocopy" = false; # middle-paste behaviour
        "devtools.debugger.ui.editor-wrapping" = true;
        "devtools.dom.enabled" = true;
        "devtools.everOpened" = true;
        "devtools.inspector.activeSidebar" = "ruleview";
        "devtools.inspector.selectedSidebar" = "ruleview";
        "devtools.inspector.showAllAnonymousContent" = true;
        "devtools.inspector.showUserAgentStyles" = true;
        "devtools.inspector.show_pseudo_elements" = true;
        "devtools.inspector.three-pane-enabled" = false;
        "devtools.toolbox.host" = "right";
        "devtools.webconsole.groupWarningMessages" = false;
        "devtools.webconsole.input.eagerEvaluation" = false;
        "devtools.webconsole.timestampMessages" = true;
        "devtools.webextensions.@react-devtools.enabled" = true;
        "extensions.recommendations.hideNotice" = true;
        "extensions.webextensions.ExtensionStorageIDB.enabled" = false;
        "font.name.monospace.x-western" = theme.fonts.monospace.en.name;
        "font.name.sans-serif.x-western" = theme.fonts.sansSerif.en.name;
        "font.name.serif.x-western" = theme.fonts.serif.en.name;
        "font.name.sans-serif.ja" = theme.fonts.sansSerif.jp.name;
        "font.name.serif.ja" = theme.fonts.serif.jp.name;
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false;
        "middlemouse.paste" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
        "privacy.clearOnShutdown_v2.formdata" = false;
        "network.cookie.lifetimePolicy" = 0;
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = false;
        "privacy.sanitize.sanitizeOnShutdown" = false;
        "privacy.trackingprotection.enabled" = true;
        "sidebar.new-sidebar.has-used" = true;
        "sidebar.visibility" = "hide-sidebar";
        "ui.prefersReducedMotion" = true;
        "signon.autofillForms" = false;
        "services.sync.prefs.sync.signon.autofillForms" = false;
        "webgl.disabled" = false;
      };
      search = {
        default = "ddg";
        engines = {
          bing.metaData.hidden = true;
          google.metaData.hidden = true;
        };
      };
      extensions = {
        # https://gitlab.com/rycee/nur-expressions/-/blob/master/pkgs/firefox-addons/addons.json
        packages =
          with pkgs.firefox-addons;
          let
            white-background-enforcer =
              let
                version = "1.4";
              in
              buildFirefoxXpiAddon {
                pname = "white-background-enforcer";
                inherit version;
                addonId = "wbge@nickesc.github.io"; # addons.mozilla.org/the-addon -> More information -> Copy add-on ID
                url = "https://github.com/nickesc/white-background-enforcer/releases/download/${version}/wbge-${version}.xpi";
                sha256 = "sha256-/svwBdw91uh6w8787myKI3iOpJjgvYaNiN4h2stV88I=";
                meta = { }; # required but not actually checked
              };
          in
          [
            augmented-steam
            pronoundb
            xkit-rewritten
            stylus
            bandcamp-player-volume-control
            return-youtube-dislikes
            indie-wiki-buddy
            web-archives
            dearrow
            greasemonkey
            tweaks-for-youtube
            betterttv
            firefox-color
            tampermonkey
            # dashlane
            proton-pass
            decentraleyes
            privacy-badger
            hoppscotch
            shinigami-eyes
            sponsorblock
            ublock-origin
            # twitch-chat-pronouns
            # youtube-disable-number-seek
            white-background-enforcer
          ];
      };
    };
  };
}
