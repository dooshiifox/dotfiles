{ config, ... }:
{
  xdg.configFile."vesktop/themes/theme.css".text = import ./css.nix { theme = config.lib.theme; };

  # Necessary one-time-only setup. Install Dorion and log in, then close.
  # nix run github:KaylorBen/nixcord#dorion
  programs.nixcord = {
    # https://kaylorben.github.io/nixcord/
    enable = true;
    vesktop.enable = true;
    dorion = {
      enable = true;
      useNativeTitlebar = false;
    };
    config = {
      frameless = true;
      transparent = true;
      enabledThemes = [ "theme.css" ];

      plugins = {
        betterNotesBox = {
          enable = true;
          noSpellCheck = true;
        };
        betterUploadButton.enable = true;
        callTimer.enable = true;
        clearURLs.enable = true;
        colorSighted.enable = true;
        copyFileContents.enable = true;
        crashHandler.enable = true;
        customRPC.enable = true;
        dearrow.enable = true;
        disableCallIdle.enable = true;
        experiments.enable = true;
        fakeNitro.enable = true;
        fixImagesQuality.enable = true;
        fixSpotifyEmbeds.enable = true;
        fixYoutubeEmbeds.enable = true;
        forceOwnerCrown.enable = true;
        friendsSince.enable = true;
        imageZoom.enable = true;
        memberCount.enable = true;
        messageLogger.enable = true;
        mutualGroupDMs.enable = true;
        noDevtoolsWarning.enable = true;
        noF1.enable = true;
        noMosaic.enable = true;
        noProfileThemes.enable = true;
        normalizeMessageLinks.enable = true;
        permissionsViewer.enable = true;
        reactErrorDecoder.enable = true;
        relationshipNotifier.enable = true;
        sendTimestamps.enable = true;
        serverInfo.enable = true;
        shikiCodeblocks.enable = true;
        spotifyCrack.enable = true;
        startupTimings.enable = true;
        themeAttributes.enable = true;
        typingIndicator.enable = true;
        typingTweaks.enable = true;
        userMessagesPronouns.enable = true;
        userVoiceShow.enable = true;
        validUser.enable = true;
        voiceChatDoubleClick.enable = true;
        volumeBooster.enable = true;
        webScreenShareFixes.enable = true;
        youtubeAdblock.enable = true;
      };
    };
    extraConfig = {
      spellCheckLanguages = [
        "en-NZ"
        "en-GB"
        "en"
      ];
      audio = {
        ignoreInputMedia = false;
        ignoreDevices = false;
        deviceSelect = true;
        onlyDefaultSpeakers = false;
        granularSelect = true;
        ignoreVirtual = false;
        onlySpeakers = false;
      };
      minimizeToTray = false;
      appBadge = false;
    };
  };
}
