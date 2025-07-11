# Firefox web browser
# https://github.com/nix-community/home-manager/blob/master/modules/programs/firefox.nix
{ pkgs, config, ... }:
let
  mimeTypes = [
    "application/json"
    "application/pdf"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/x-extension-xhtml"
    "application/x-extension-xht"
    "application/xhtml+xml"
    "text/html"
    "text/xml"
    "x-scheme-handler/about"
    "x-scheme-handler/ftp"
    "x-scheme-handler/http"
    "x-scheme-handler/unknown"
    "x-scheme-handler/https"
  ];
  theme = config.lib.theme;
  colors = theme.colors;
in
{
  xdg.mimeApps.defaultApplications = builtins.listToAttrs (
    map (mimeType: {
      name = mimeType;
      value = [ "firefox-devedition.desktop" ];
    }) mimeTypes
  );

  programs.firefox = {
    enable = true;
    package = pkgs.firefox-devedition;

    policies = { };

    profiles.dooshii = {
      id = 0;
      isDefault = true;
      name = "dev-edition-default";
      userChrome = ''
        :root {
          --bg: ${colors.bg-opacity} !important;
          --toolbarseparator-color: ${colors.border-opacity} !important;
          --chrome-content-separator-color: transparent !important;
          --tab-selected-bgcolor: ${colors.bg-secondary-opacity} !important;
          --tab-selected-outline-color: ${colors.border-active-opacity} !important;
          /* Floating menus */
          --arrowpanel-background: ${colors.bg-secondary} !important;
          --arrowpanel-color: ${colors.fg} !important;
          --panel-background: ${colors.bg-secondary} !important;
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
        hbox#urlbar-background {
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
          background: ${colors.bg-secondary} !important;
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
            --newtab-background-color-secondary: ${colors.bg-secondary}80 !important;
            --newtab-text-primary-color: ${colors.fg} !important;
            --newtab-text-secondary-color: ${colors.bg-secondary} !important;
          }
        }
        @-moz-document domain("youtube.com") {
          html, html[dark], ytd-app, #full-bleed-container, #movie_player {
            background: transparent !important;
          }
        }
        @-moz-document domain("duckduckgo.com") {
          html, body, .site-wrapper, #header_wrapper, nav::before, nav::after, ul::before {
            background: transparent !important;
            border: none !important;
          }
          #header_wrapper {
            box-shadow: none !important;
          }
          #search_form {
            background-color: #1f2024d9 !important;
            border-color: #373b41d9 !important;
            box-shadow: none !important;
          }
        }
        @-moz-document domain("monkeytype.com") {
          body {
            background: transparent !important;
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
        "browser.contentblocking.category" = "strict";
        "browser.discovery.enabled" = false;
        "browser.eme.ui.firstContentShown" = true;
        "browser.engagement.ctrlTab.has-used" = true;
        "browser.engagement.downloads-button.has-used" = true;
        "browser.engagement.fxa-toolbar-menu-button.has-used" = true;
        "browser.engagement.sidebar-button.has-used" = true;
        "browser.firefox-view.feature-tour" =
          "{\"message\":\"FIREFOX_VIEW_FEATURE_TOUR\",\"screen\":\"\",\"complete\":true}";
        "browser.firefox-view.view-count" = 1;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.startup.page" = 3;
        "browser.tabs.hoverPreview.showThumbnails" = false;
        "browser.tabs.inTitlebar" = 0;
        "browser.theme.toolbar-theme" = 0;
        "browser.toolbarbuttons.introduced.sidebar-button" = true;
        "browser.translations.panelShown" = true;
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.shortcuts.bookmarks" = false;
        "browser.urlbar.shortcuts.history" = false;
        "browser.urlbar.shortcuts.quickactions" = false;
        "browser.urlbar.shortcuts.tabs" = false;
        "browser.urlbar.suggest.engines" = false;
        "browser.urlbar.suggest.quickactions" = false;
        "browser.urlbar.suggest.topsites" = false;
        "devtools.debugger.ui.editor-wrapping" = true;
        "devtools.dom.enabled" = true;
        "devtools.everOpened" = true;
        "devtools.inspector.activeSidebar" = "ruleview";
        "devtools.inspector.selectedSidebar" = "ruleview";
        "devtools.inspector.showUserAgentStyles" = true;
        "devtools.inspector.three-pane-enabled" = false;
        "devtools.webconsole.groupWarningMessages" = false;
        "devtools.webconsole.input.eagerEvaluation" = false;
        "devtools.webconsole.timestampMessages" = true;
        "devtools.webextensions.@react-devtools.enabled" = true;
        "extensions.recommendations.hideNotice" = true;
        "font.name.monospace.x-western" = theme.fonts.monospace.name;
        "font.name.sans-serif.x-western" = theme.fonts.sansSerif.name;
        "font.name.serif.x-western" = theme.fonts.serif.name;
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "sidebar.new-sidebar.has-used" = true;
        "sidebar.visibility" = "hide-sidebar";
        "ui.prefersReducedMotion" = true;
      };
      search = {
        default = "ddg";
        engines = {
          bing.metaData.hidden = true;
          google.metaData.hidden = true;
        };
      };
      extensions = {
        packages = with pkgs.firefox-addons; [
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
          enhancer-for-youtube
          betterttv
          firefox-color
          tampermonkey
          dashlane
          decentraleyes
          privacy-badger
          hoppscotch
          shinigami-eyes
          sponsorblock
          ublock-origin
          # twitch-chat-pronouns
          # youtube-disable-number-seek
        ];

        #settings = {
        #  "{7a7a4a92-a2a0-41d1-9fd7-1e92480d612d}".settings = {
        #    dbInChromeStorage = true; # required for Stylus
        #  };
        #};
      };
    };
  };
}
