# Firefox web browser
# https://github.com/nix-community/home-manager/blob/master/modules/programs/firefox.nix
{ pkgs, ... }:
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
      # userChrome = '''';
      # userContent = '''';
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # Enable customChrome.cs
        "svg.context-properties.content.enabled" = true; # Allows for theming specific icons
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
