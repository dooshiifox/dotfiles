{ theme }:
''
  :root {
    --font-primary: ${theme.fonts.sansSerif.name};
    --font-display: ${theme.fonts.sansSerif.name};
    --font-code: ${theme.fonts.monospace.name};
  }

  div[class^="bar"]:has(div[class^="trailing"]),
  [aria-label="Send a gift"],
  /* Nitro right-side chat icon */
  [class^="uploadInput"]~[class^="buttons"]>*:has([aria-label="Open Translate Modal"]),
  /* Translate right-side chat icon */
  [class^="uploadInput"]~[class^="buttons"]>*:has([aria-label="Open GIF picker"]),
  /* Gif right-side chat icon */
  [class^="uploadInput"]~[class^="buttons"]>*:has([aria-label="Open sticker picker"]),
  /* Stickers right-side chat icon */
  button[aria-label="Apps"],
  /* App launcher chat icon */
  a[href="https://support.discord.com"],
  /* Top-right (next to inbox) help button */
  div[aria-label="Start Video Call"],
  /* Start video call DMs button */
  ul[aria-label="Direct Messages"]> :has(a[href="/store"]),
  /* Nitro button beneath friends in sidebar */
  ul[aria-label="Direct Messages"]> :has(a[href="/shop"]),
  /* Shop button beneath friends in siderbar */
  div[data-tab-id="Discord Nitro"],
  /* Settings -> Payment Settings */
  div[data-tab-id="Nitro Server Boost"],
  /* Settings -> Payment Settings -> Server Boost */
  div[data-tab-id="Family Center"],
  /* Settings -> User Settings -> Family Center */
  #profile-customization-tab>[class^='container'],
  #profile-customization-tab>[class*=' container'],
  /* Settings -> Profiles -> Nitro advertisement */
  #profile-customization-tab [class^='sectionsContainer']> :nth-child(4),
  /* Settings -> Profiles -> Avatar Decoration */
  #profile-customization-tab [class^='sectionsContainer']> :nth-child(5),
  /* Settings -> Profiles -> Profile Effect */
  #profile-customization-tab>[class^='upsellContainer'],
  #profile-customization-tab>[class*=' upsellContainer'],
  /* Settings -> Profiles -> Nitro ad */
  #profile-customization-tab [class^='upsellOverlayContainer'],
  #profile-customization-tab [class*=' upsellOverlayContainer'],
  /* Settings -> Profiles -> Server Profiles -> Nitro ad */
  [class^='premiumFeatureBorder'],
  [class*=' premiumFeatureBorder'],
  /* Hide things with the nitro border, e.g. Settings -> Profiles -> Try out Nitro!, Settings -> Appearance -> Theme */
  #appearance-tab [class^='basicThemeSelectors']~section,
  #appearance-tab [class*=' basicThemeSelectors']~section,
  /* Settings -> Appearance -> Nitro Colours */
  #appearance-tab [class^='selectionGroup'],
  #appearance-tab [class*=' selectionGroup'],
  /* Settings -> Appearance -> In-app Icon */
  [data-tab-id="merchandise"],
  /* Settings -> Merchandise */
  [class^='avatarDecoration'],
  [class*=' avatarDecoration'],
  /* All avatar decorations */
  [class^="shinyButton"],
  /* 'Subscribe' buttons */
  [aria-label="Your message is too long..."] [data-text-variant="text-md/normal"]> :last-child,
  /* Message too long modal > 'Speak your mind with 2x longer messages' */
  [class^="upsell_"],
  [class*=" upsell_"],
  /* Send 2x longer messages with nitro */
  [data-list-id="guildsnav"] [class^="listItem"]:has([aria-label^="Discover"]),
  /* Discoverable servers (in server sidebar) */
  [data-list-id="guildsnav"] [class^="listItem"]:has([aria-label^="Download Apps"]),
  /* Download Apps (in server sidebar) */
  #guild-header-popout-premium-subscribe,
  /* 'Server Boost' in server menu dropdown */
  div:has(#guild-header-popout-premium-subscribe)> :nth-child(2),
  /* ^ but the seperator for */
  div[aria-label*="Buy Boosts to help"],
  /* Server boost progress */
  div[aria-label="This server has unlocked all Boosting perks!"],
  /* Similar to above */
  [class^="guildIconV2Container"],
  [class^="guildIconContainer"],
  /* Server boost/community server indicator next to server name */
  #overview-tab>div>[class^="children"]> :nth-child(6),
  /* Server settings custom invite background, custom background */
  [class^="profileEffects"],
  /* Profile effects */
  [class^="serverBoostTabItem"],
  /* Server settings server boost tab */
  [class^="serverBoostTabItem"]+div,
  /* ^ but the seperator for */
  div[data-tab-id="VANITY_URL"],
  /* Server settings custom invite link tab */
  div[data-tab-id="STICKERS"],
  /* Server settings stickers tab */
  #soundboard-tab [class^="banner"],
  #emoji-tab [class^="banner"],
  /* Server settings soundboard/emoji server boost ad */
  [class^="defaultColor"]:has([class^="toggleExpandIcon"]),
  /* Activity in members tab */
  div[aria-label="Members"] > h3:has([aria-expanded]),
  div[aria-label="Members"] > div:has(div > div > div[class*="infoSection"]),
    /* Disable nameplates */
  div[class*="nameplated"] > div[class*="container"]
  {
    display: none !important;
  }

  /* Add a bit of padding to the top of the guild scrollbar so the DMs button doesnt touch the top of the screen */
  ul[data-list-id="guildsnav"]>div[class^="itemsContainer"]>div[data-direction="vertical"] {
    padding-top: var(--space-xs);
  }

  /* Make guild icons circular unless selected */
  [data-list-item-id^="guildsnav"]>img,
  [data-list-item-id^="guildsnav"]>div,
  div[aria-label="Direct Messages"]>div,
  div[aria-label="Add a Server"] {
    border-radius: 50%;
    transition: border-radius cubic-bezier(0.075, 0.82, 0.165, 1) 0.2s;
  }

  [data-list-item-id^="guildsnav"]>div:has(div) {
    border-radius: 0%;
  }

  [class*="selected"] [data-list-item-id^="guildsnav"]>img,
  [class*="selected"] [data-list-item-id^="guildsnav"]>div,
  [class*="selected"] div[aria-label="Direct Messages"]>div {
    border-radius: 10%;
  }

  [class*="iconSizeMini"] {
    border-radius: 50% !important;
  }

  /* Increase the size of the guild icons */
  div[aria-label="Servers"]>div[class^="listItem"],
  div[aria-label="Servers"]>div[class^="folderGroup"],
  [data-list-id="guildsnav"] div[class^="tutorialContainer"]>div[class^="listItem"],
  [id^="folder-items"]>[class^="listItem"],
  [data-list-id="guildsnav"]>div[class^="itemsContainer"]>div>div[style*="height: 40px;"] {
    margin-top: 4px;
    margin-bottom: 4px;
  }

  div[aria-label="Servers"]>div[class^="listItem"]>div>div[data-dnd-name],
  div[class^="folderGroup"]>div[class^="listItem"]>div[data-dnd-name] svg,
  [data-list-id="guildsnav"] div[class^="listItem"]>div[class^="listItemWrapper"],
  [id^="folder-items"]>div[class^="listItem"]>div>div[data-dnd-name] {
    scale: calc(6 / 5);
  }

  [class^="folderIcon"]>svg {
    scale: 1.25;
  }
  [class^="folderGroupBackground"] {
    border: none !important;
  }
  [class^="sidebarResizeHandle"] {
    border-right: 1px solid var(--border-subtle);
  }

  /* .visual-refresh div[aria-label="Direct Messages"]>div {
    background-color: var(--neutral-63);
  } */

  [id^="folder-items"] {
    height: unset !important;
  }

  [class^="typing"] {
    top: -24px !important;
    background-color: var(--bg-overlay-chat,var(--background-base-lower));
    left: 0px !important;
    padding-left: var(--space-8);
  }

  [class^="typing"] strong>div {
    margin-top: 0px !important;
  }

  * {
    --custom-app-top-bar-height: 0px;
    --custom-guild-list-padding: 16px !important;
    --text-link: ${theme.colors.accent};
    /* --background-surface-high: color-mix(in oklab, var(--neutral-66) 100%, var(--theme-base-color, #000) 20%) !important;
    --background-surface-higher: color-mix(in oklab, var(--neutral-63) 100%, var(--theme-base-color, #000) 50%) !important;
    --background-surface-highest: color-mix(in oklab, var(--neutral-60) 100%, var(--theme-base-color, #000) 40%) !important;
    --background-floating: color-mix(in oklab, var(--neutral-60) 100%, var(--theme-base-color, #000) 20%) !important; */
    --custom-chat-input-margin-bottom: 8px;
    --custom-emoji-sprite-size: 24px !important;
  }

  /* Make the user area in line with the message box */
  section[aria-label="User area"]>div[class^="container"] {
    padding: calc(var(--space-xs) * 0.75) !important;
    margin-left: 0px;
  }
  section[aria-label="User area"]>div[class^="container"]>div[class^="avatarWrapper"]>div[class*="avatar"] {
    height: 40px !important;
    width: 40px !important;
  }
  section[aria-label="User area"]>div[class^="container"]>div[class^="avatarWrapper"]>div[class*="avatar"]>svg {
    height: 49px;
    width: 49px;
  }

  /* Consistency with mic icon */
  [aria-label="Enable Game Activity"][aria-checked="true"] {
    background-color: hsl(357.692 calc(1*67.826%) 54.902% /.1);
  }

  [aria-label="Enable Game Activity"][aria-checked="true"]:hover {
    background-color: hsl(357.692 calc(1*67.826%) 54.902% /.2) !important;
  }

  /* Add some spacing between the message box and the chat */
  [data-list-id="chat-messages"] {
    padding-bottom: 12px;
  }

  /* Change the contrast of the username and activity text in the members tab */
  [class*="activityText"] {
    color: var(--channels-default) !important;
  }

  div[class^="members"] > div[class^="member"] span[class*="username"] {
    color: ${theme.colors.fg-secondary};
  }

  /* Message too long modal > image */
  [aria-label="Your message is too long..."] [class^="artContainer"] {
    height: 50px;
    visibility: hidden;
  }

  [aria-label="Your message is too long..."] [class^="primaryActions"] [class^="secondaryAction"] {
    margin-right: 0px;
  }

  [aria-label="Your message is too long..."] [class^="contentContainer"] {
    align-items: center;
    justify-content: center;
  }
  html {
    padding: 2px;
    padding-top: 0px;
    width: calc(100% - 4px);
    height: calc(100% - 2px);
  }

  /* Copyright (c) 2025 Cole Schaefer

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE. */

  .theme-light,
  .theme-dark,
  .theme-darker,
  .theme-midnight,
  .visual-refresh {
    --activity-card-background: ${theme.colors.bg-secondary} !important;
    --background-accent: ${theme.colors.bg-secondary} !important;
    --background-floating: ${theme.colors.bg-secondary} !important;
    --background-mentioned-hover: ${theme.colors.orange}10 !important;
    --background-mentioned: ${theme.colors.orange}0b !important;
    --background-message-highlight: ${theme.colors.bg-secondary} !important;
    --background-message-hover: ${theme.colors.bg-secondary}80 !important;
    --background-modifier-accent: ${theme.colors.bg-secondary-opacity} !important;
    --background-modifier-active: ${theme.colors.bg-secondary-opacity} !important;
    --background-modifier-hover: ${theme.colors.bg-secondary-opacity} !important;
    --background-modifier-selected: ${theme.colors.bg-secondary-opacity} !important;
    --background-primary: ${theme.colors.bg} !important;
    --background-secondary-alt: ${theme.colors.bg-secondary} !important;
    --background-secondary: ${theme.colors.bg-secondary} !important;
    --background-surface-highest: ${theme.colors.bg-tertiary} !important;
    --background-surface-higher: ${theme.colors.bg-secondary} !important;
    --background-surface-high: ${theme.colors.bg-secondary} !important;
    --background-tertiary: ${theme.colors.bg-tertiary} !important;
    --background-base-low: ${theme.colors.bg-opacity} !important;
    --background-base-lower: ${theme.colors.bg-secondary-opacity} !important;
    --background-base-lowest: transparent !important;
    --background-base-tertiary: ${theme.colors.bg-tertiary} !important;
    --background-code: ${theme.colors.bg-tertiary} !important;
    --background-mod-subtle: ${theme.colors.bg-tertiary}80 !important;
    --background-mod-strong: ${theme.colors.bg-tertiary}40 !important;
    --bg-base-secondary: ${theme.colors.bg-secondary} !important;
    --bg-base-tertiary: ${theme.colors.bg-tertiary} !important;
    --bg-brand: ${theme.colors.accent}80 !important;
    --bg-mod-faint: ${theme.colors.bg-secondary} !important;
    --bg-overlay-2: transparent !important;
    --bg-overlay-3: ${theme.colors.bg-secondary} !important;
    --bg-overlay-color-inverse: ${theme.colors.bg-secondary} !important;
    --bg-surface-raised: ${theme.colors.bg-secondary} !important;
    --bg-surface-overlay: ${theme.colors.bg-secondary} !important;
    --black: ${theme.colors.black} !important;
    --blurple-50: ${theme.colors.accent} !important;
    --border-faint: ${theme.colors.border} !important;
    --brand-05a: ${theme.colors.accent} !important;
    --brand-10a: ${theme.colors.accent} !important;
    --brand-15a: ${theme.colors.accent} !important;
    --brand-260: ${theme.colors.accent} !important;
    --brand-360: ${theme.colors.accent} !important;
    --brand-500: ${theme.colors.accent} !important;
    --brand-560: ${theme.colors.accent} !important;
    --button-danger-background: ${theme.colors.dark-red} !important;
    --button-filled-brand-background: ${theme.colors.accent} !important;
    --button-filled-brand-background-hover: ${theme.colors.accent} !important;
    --button-filled-brand-text: ${theme.colors.accent-fg} !important;
    --button-filled-brand-text-hover: ${theme.colors.accent-fg} !important;
    --button-outline-positive-border: ${theme.colors.lime} !important;
    --button-outline-danger-background-hover: ${theme.colors.red} !important;
    --button-outline-danger-border-hover: ${theme.colors.dark-red} !important;
    --button-positive-background: ${theme.colors.green} !important;
    --button-positive-background-hover: ${theme.colors.lime} !important;
    --button-secondary-background: ${theme.colors.bg-secondary} !important;
    --button-secondary-background-hover: ${theme.colors.bg-secondary-opacity} !important;
    --card-primary-bg: ${theme.colors.bg-secondary} !important;
    --channel-icon: ${theme.colors.fg-secondary} !important;
    --channels-default: ${theme.colors.fg-secondary} !important;
    --channel-text-area-placeholder: ${theme.colors.fg-secondary} !important;
    --channeltextarea-background: ${theme.colors.bg-secondary} !important;
    --chat-background-default: ${theme.colors.bg-secondary-opacity} !important;
    --checkbox-background-checked: ${theme.colors.accent} !important;
    --checkbox-border-checked: ${theme.colors.accent} !important;
    --checkbox-background-default: ${theme.colors.bg-secondary} !important;
    --checkbox-border-default: ${theme.colors.bg-tertiary} !important;
    --control-brand-foreground-new: ${theme.colors.accent} !important;
    --control-brand-foreground: ${theme.colors.accent} !important;
    --custom-notice-text: ${theme.colors.bg-secondary} !important;
    --custom-channel-members-bg: transparent !important;
    --font-display: var(--font, "gg sans") !important;
    --font-headline: var(--font, "gg sans") !important;
    --font-primary: var(--font, "gg sans") !important;
    --green-330: ${theme.colors.lime} !important;
    --green-360: ${theme.colors.lime} !important;
    --header-primary: ${theme.colors.fg} !important;
    --header-secondary: ${theme.colors.fg-secondary} !important;
    --home-background: ${theme.colors.bg} !important;
    --info-warning-foreground: ${theme.colors.orange} !important;
    --input-background: ${theme.colors.bg-secondary-opacity} !important;
    --interactive-active: ${theme.colors.fg} !important;
    --interactive-hover: ${theme.colors.fg} !important;
    --interactive-muted: ${theme.colors.fg-secondary} !important;
    --interactive-normal: ${theme.colors.fg} !important;
    --mention-background: ${theme.colors.accent}40 !important;
    --mention-foreground: ${theme.colors.fg} !important;
    --menu-item-danger-active-bg: ${theme.colors.dark-red} !important;
    --menu-item-danger-hover-bg: ${theme.colors.red} !important;
    --menu-item-default-hover-bg: ${theme.colors.bg-tertiary} !important;
    --message-reacted-background: ${theme.colors.bg-secondary} !important;
    --message-reacted-text: ${theme.colors.fg-secondary} !important;
    --modal-background: ${theme.colors.bg-secondary} !important;
    --modal-footer-background: ${theme.colors.bg} !important;
    --notice-background-positive: ${theme.colors.green} !important;
    --notice-text-positive: ${theme.colors.fg} !important;
    --plum-23: ${theme.colors.dark-grey} !important;
    --primary-130: ${theme.colors.fg-secondary} !important;
    --primary-300: ${theme.colors.fg-secondary} !important;
    --primary-500: ${theme.colors.grey} !important;
    --primary-600: ${theme.colors.bg} !important;
    --primary-630: ${theme.colors.black} !important;
    --primary-660: ${theme.colors.bg} !important;
    --primary-800: ${theme.colors.bg} !important;
    --red-400: ${theme.colors.red} !important;
    --red-460: ${theme.colors.red} !important;
    --red-500: ${theme.colors.red} !important;
    --red-630: ${theme.colors.red} !important;
    --red: ${theme.colors.red} !important;
    --scrollbar-auto-thumb: ${theme.colors.bg-secondary-opacity} !important;
    --scrollbar-auto-track: transparent;
    --scrollbar-thin-thumb: ${theme.colors.bg-secondary-opacity} !important;
    --scrollbar-thin-track: transparent;
    --search-popout-option-fade: none;
    --search-popout-option-non-text-color: ${theme.colors.fg} !important;
    --status-danger-background: ${theme.colors.dark-red} !important;
    --status-danger: ${theme.colors.dark-red} !important;
    --status-negative: ${theme.colors.dark-red} !important;
    --status-positive-background: ${theme.colors.green} !important;
    --status-positive-text: ${theme.colors.fg} !important;
    --status-positive: ${theme.colors.lime} !important;
    --status-success: ${theme.colors.green} !important;
    --status-warning-background: ${theme.colors.bg} !important;
    --status-warning: ${theme.colors.orange} !important;
    --teal-430: ${theme.colors.cyan} !important;
    --text-brand: ${theme.colors.white} !important;
    --text-feedback-positive: ${theme.colors.green} !important;
    --text-feedback-negative: ${theme.colors.dark-red} !important;
    --text-feedback-warning: ${theme.colors.orange} !important;
    --text-feedback-success: ${theme.colors.green} !important;
    --text-link: ${theme.colors.accent} !important;
    --text-muted: ${theme.colors.fg-secondary} !important;
    --text-negative: ${theme.colors.dark-red} !important;
    --text-normal: ${theme.colors.fg-secondary} !important;
    --text-positive: ${theme.colors.green} !important;
    --text-primary: ${theme.colors.fg} !important;
    --text-secondary: ${theme.colors.fg-secondary} !important;
    --text-tertiary: ${theme.colors.light-grey} !important;
    --text-warning: ${theme.colors.orange} !important;
    --textbox-markdown-syntax: ${theme.colors.fg} !important;
    --theme-base-color: ${theme.colors.bg} !important;
    --white-100: ${theme.colors.fg} !important;
    --white-200: ${theme.colors.fg} !important;
    --white-500: ${theme.colors.fg} !important;
    --white: ${theme.colors.fg} !important;
    --yellow-360: ${theme.colors.yellow} !important;
    --yellow-300: ${theme.colors.yellow} !important;
    --__lottieIconColor: ${theme.colors.fg-secondary} !important;
  }

  /*--- Default Folder Color Recolor ---*/
  .default__459fb {
    background-color: ${theme.colors.white} !important;
  }

  /*--- Add Friend Button Text Recolor ---*/
  .addFriend__133bf {
    color: ${theme.colors.bg} !important;
  }

  /*--- Close Icon Path Recolor ---*/
  svg[class^="closeIcon__"] path {
    fill: ${theme.colors.bg-secondary} !important;
  }

  /*--- Listen Along Invite Recolor ---*/
  .invite__4d3fa {
    background: ${theme.colors.bg-secondary} !important;
    border-color: ${theme.colors.border} !important;
  }

  /*--- Activity Card Background Recolor ---*/
  .card__73069 {
    background-color: ${theme.colors.bg-secondary};
  }

  div[class^="bar__"] {
    background-color: ${theme.colors.bg-secondary} !important;
    border-color: ${theme.colors.border} !important;
  }
  /*--- Voice Bar Text Recolor ---*/
  .barText__7aaec {
    color: ${theme.colors.lime} !important;
  }
  .unreadIcon__7aaec {
    color: ${theme.colors.lime} !important;
  }

  /*--- Mentions Bar Text Recolor ---*/
  .mentionsBar__7aaec .barText__7aaec {
    color: ${theme.colors.fg-secondary} !important;
  }

  /*--- Forum Background Recolor ---*/
  .container_f369db {
    background-color: var(--bg-overlay-2);
  }

  /*--- Sidebar Icon Recolor ---*/
  .circleIconButton__5bc7e {
    color: ${theme.colors.fg-secondary};
  }

  /*--- Summaries Tag Icon Recolor ---*/
  .summariesBetaTag_cf58b5 {
    color: ${theme.colors.bg-tertiary};
  }

  .lottieIcon__5eb9b.lottieIconColors__5eb9b.buttonIcon_e131a9 {
    --__lottieIconColor: ${theme.colors.fg-secondary} !important;
  }
  div[class^="actionButtons"] [class^="button"][class*="buttonColor_"],
  div[class^="actionButtons"] [class^="button"] [class*="buttonColor_"] {
    background-color: ${theme.colors.bg-tertiary};
  }

  /* --- Checkbox Recolor (OFF) --- */
  .container__87bf1 {
    background-color: ${theme.colors.bg-tertiary} !important;
  }
  /* --- Checkbox Recolor (ON) --- */
  .checked__87bf1 {
    background-color: ${theme.colors.accent} !important;
  }
  path[fill^="rgba(35, 165, 90, 1)"] {
    fill: ${theme.colors.accent} !important;
  }

  /* --- Secure Lock Icon Recolor --- */
  .lockIcon__2666b {
    display: none;
  }

  /*--- Status Icon Recolor (DO NOT DISTURB) ---*/
  svg[fill^="#f23f43"],
  rect[fill^="#f23f43"] {
    fill: var(--status-danger) !important;
  }
  /*--- Status Icon Recolor (IDLE) ---*/
  svg[fill^="#f0b232"],
  rect[fill^="#f0b232"] {
    fill: var(--status-warning) !important;
  }
  /*--- Status Icon Recolor (ONLINE) ---*/
  path[fill^="#23a55a"],
  svg[fill^="#23a55a"],
  rect[fill^="#23a55a"] {
    fill: var(--status-positive) !important;
  }
  /*--- Status Icon Recolor (OFFLINE) ---*/
  svg[fill^="#80848e"],
  rect[fill^="#80848e"] {
    fill: ${theme.colors.grey} !important;
  }

  /*--- Default Color Swap ---*/
  path[fill^="currentColor"],
  svg[fill^="currentColor"],
  rect[fill^="currentColor"] {
    fill: ${theme.colors.fg} !important;
  }
  path[d^="M12 22a10 10 0 1"] {
    fill: ${theme.colors.fg-secondary} !important;
  }

  /*--- Voice Chat Icon Badge Recolor ---*/
  div[class^="iconBadge"] path[d^="M12 3a1 1 0 0 0-1-1h-.06"],
  div[class^="iconBadge"] path[d^="M15.16 16.51c-.57.28"] {
    fill: ${theme.colors.fg-secondary} !important;
  }

  /*--- Nitro Icon Recolor ---*/
  .premiumLabel_e681d1 svg path,
  svg.guildBoostBadge__5dba5 path {
    fill: ${theme.colors.magenta} !important;
  }

  /*--- Server Booster Icon Recolor ---*/
  .premiumIcon__5d473 {
    color: ${theme.colors.magenta};
  }

  /*--- Call Container Recolor ---*/
  .callContainer_cb9592 {
    background-color: ${theme.colors.bg};
  }
  .gradientContainer_bfe55a {
    background-image: ${theme.colors.bg};
  }

  /*--- Store Gradient Recolors ---*/
  .gradient_e9ef78 {
    background: ${theme.colors.bg-secondary} !important;
  }
  .bannerGradient__955a3 {
    background: ${theme.colors.bg} !important;
  }

  /*--- Increase Text Legibility ---*/
  * {
    text-rendering: optimizeLegibility !important;
  }

  /*--- Codeblock Syntax Highlighting Recolor ---*/
  .hljs-attr {
    color: ${theme.colors.orange} !important;
  }
  .hljs-attribute {
    color: ${theme.colors.orange} !important;
  }
  .hljs-number {
    color: ${theme.colors.orange} !important;
  }
  .hljs-selector-class {
    color: ${theme.colors.fg} !important;
  }
  .hljs-comment {
    color: ${theme.colors.grey} !important;
  }
  .hljs-subst {
    color: ${theme.colors.dark-blue} !important;
  }
  .hljs-selector-pseudo {
    color: ${theme.colors.green} !important;
  }
  .hljs-section {
    color: ${theme.colors.green} !important;
  }
  .hljs-keyword {
    color: ${theme.colors.magenta} !important;
  }
  .hljs-variable {
    color: ${theme.colors.light-blue} !important;
  }
  .hljs-meta {
    color: ${theme.colors.grey} !important;
  }
  .hljs-built_in {
    color: ${theme.colors.green} !important;
  }
  .hljs-string {
    color: ${theme.colors.lime} !important;
  }
  .hljs-title {
    color: ${theme.colors.magenta} !important;
  }

  /*--- Visual Refresh Recolor ---*/
  /*--- BIG WORK IN PROGRESS. DISCORD MADE SOME BIG CHANGES. ---*/
  .visual-refresh {
    div[class^="autocomplete__"] {
      background-color: ${theme.colors.bg-tertiary} !important;
    }
    path[fill^="rgba(88, 101, 242, 1)"] {
      fill: ${theme.colors.green} !important;
    }
    div[class^="topicsPillContainer"] {
      --bg-overlay-2: ${theme.colors.bg-tertiary-opacity} !important;
    }
    .bg__960e4 {
      background: transparent !important;
    }
    .wrapper_ef3116 {
      background-color: transparent !important;
    }
    .sidebar_c48ade {
      background-color: transparent !important;
    }
    [class*="sidebarListRounded"] {
      backdrop-filter: unset !important;
    }
    .searchBar__97492 {
      background-color: ${theme.colors.bg-secondary-opacity} !important;
    }
    .channelTextArea_f75fb0 {
      background: ${theme.colors.bg-tertiary-opacity} !important;
    }
    .chatContent_f75fb0 {
      background-color: transparent !important;
    }
    .members_c8ffbb,
    .member_c8ffbb {
      background: transparent !important;
    }
    .voiceBar__7aaec {
      background-color: ${theme.colors.bg-tertiary-opacity} !important;
    }
    button.button__67645.redGlow__67645,
    span.button__67645.redGlow__67645 {
      background-color: ${theme.colors.bg-tertiary-opacity} !important;
    }

    .chat_f75fb0 {
      background-color: transparent;
    }

    /*--- Status Icon Recolor (DO NOT DISTURB) ---*/
    svg[fill^="#d83a42"],
    rect[fill^="#d83a42"] {
      fill: var(--status-danger) !important;
    }
    /*--- Status Icon Recolor (IDLE) ---*/
    svg[fill^="#ca9654"],
    rect[fill^="#ca9654"] {
      fill: var(--status-warning) !important;
    }
    /*--- Status Icon Recolor (ONLINE) ---*/
    path[fill^="#43a25a"],
    svg[fill^="#43a25a"],
    rect[fill^="#43a25a"] {
      fill: var(--status-positive) !important;
    }
    /*--- Status Icon Recolor (OFFLINE) ---*/
    svg[fill^="#83838b"],
    rect[fill^="#83838b"] {
      fill: ${theme.colors.grey} !important;
    }
  }
  body, #app-mount, .app_a3002d, .app__160d8 {
    background-color: transparent !important;
  }
  html {
    background-color: ${theme.colors.bg-opacity};
  }
  [class*="fieldList"] {
    background-color: unset;
  }
''
