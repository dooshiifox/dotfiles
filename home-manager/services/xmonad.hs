import           Control.Monad                   ( join, when )
import           Data.Map                        ( Map )
import qualified Data.Map                        as Map
import           Data.Maybe                      ( maybeToList )
import           Graphics.X11.ExtraTypes.XF86
import           System.Exit                     ( exitSuccess )
import           XMonad
import           XMonad.Actions.CycleWS          ( toggleWS )
import           XMonad.Hooks.DynamicLog
import           XMonad.Hooks.EwmhDesktops
import           XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import           XMonad.Hooks.StatusBar
import           XMonad.Hooks.StatusBar.PP
import           XMonad.Layout.Fullscreen
    ( fullscreenEventHook, fullscreenFull, fullscreenManageHook, fullscreenSupport )
import           XMonad.Layout.Gaps
    ( Direction2D (D, L, R, U), GapMessage (DecGap, IncGap, ToggleGaps), gaps, setGaps )
import           XMonad.Layout.Grid
import           XMonad.Layout.NoBorders
import           XMonad.Layout.Spacing
import qualified XMonad.StackSet                 as W
import           XMonad.Util.ClickableWorkspaces
import           XMonad.Util.Loggers
import           XMonad.Util.NamedScratchpad
import           XMonad.Util.SpawnOnce
import XMonad.Layout.ThreeColumns
import qualified XMonad.Util.Hacks as Hacks


myKeys :: XConfig Layout -> Map (ButtonMask, KeySym) (X ())
myKeys conf@XConfig { XMonad.modMask = mod } = Map.fromList
    [
        -- launch a terminal
        ((mod, xK_t), spawn (XMonad.terminal conf)),
        -- close the current window
        ((mod, xK_w), kill),
        -- open file browser
        ((mod, xK_e), spawn "nautilus"),
        -- toggle floating
        ((mod, xK_g), withFocused toggleFloat),
        -- launch rofi
        ((mod, xK_space), spawn "rofi -show drun"),

        -- Audio keys
        ((0, xF86XK_AudioPlay), spawn "playerctl play-pause"),
        ((0, xF86XK_AudioPrev), spawn "playerctl previous"),
        ((0, xF86XK_AudioNext), spawn "playerctl next"),
        ((0, xF86XK_AudioStop), spawn "playerctl stop"),
        ((0, xF86XK_AudioRaiseVolume), spawn "pamixer -i 5"),
        ((0, xF86XK_AudioLowerVolume), spawn "pamixer -d 5"),
        ((0, xF86XK_AudioMute), spawn "pamixer -t"),

        -- Brightness keys
        ((0, xF86XK_MonBrightnessUp), spawn "brightnessctl s +5%"),
        ((0, xF86XK_MonBrightnessDown), spawn "brightnessctl s 5-%"),

        -- Screenshot
        ((0, xK_Print), spawn "maim -s | xclip -selection clipboard -t image/png && notify-send \"Screenshot\" \"Copied to Clipboard\" -i flameshot"),
        ((mod, xK_Print), spawn "maim -s --hidecursor ~/Desktop/$(date +%Y-%m-%d_%H-%M-%S).png && notify-send \"Screenshot\" \"Saved to Desktop\" -i flameshot"),

        ((mod .|. shiftMask, xK_q), liftIO exitSuccess),

        -- mod-[1..9], Switch to workspace N
        ((mod, xK_1), windows (W.greedyView "1")),
        ((mod, xK_2), windows (W.greedyView "2")),
        ((mod, xK_3), windows (W.greedyView "3")),
        ((mod, xK_4), windows (W.greedyView "4")),
        ((mod, xK_5), windows (W.greedyView "5")),
        ((mod, xK_6), windows (W.greedyView "6")),
        ((mod, xK_7), windows (W.greedyView "7")),
        ((mod, xK_8), windows (W.greedyView "8")),
        ((mod, xK_9), windows (W.greedyView "9")),

        -- mod-shift-[1..9], Move client to workspace N
        ((mod .|. shiftMask, xK_1), windows (W.shift "1")),
        ((mod .|. shiftMask, xK_2), windows (W.shift "2")),
        ((mod .|. shiftMask, xK_3), windows (W.shift "3")),
        ((mod .|. shiftMask, xK_4), windows (W.shift "4")),
        ((mod .|. shiftMask, xK_5), windows (W.shift "5")),
        ((mod .|. shiftMask, xK_6), windows (W.shift "6")),
        ((mod .|. shiftMask, xK_7), windows (W.shift "7")),
        ((mod .|. shiftMask, xK_8), windows (W.shift "8")),
        ((mod .|. shiftMask, xK_9), windows (W.shift "9")),

        -- Focus the master window
        ((mod, xK_Return), windows W.focusMaster),
        -- Move focus to the previous window
        ((mod, xK_Left), windows W.focusUp),
        ((mod, xK_Up), windows W.focusUp),
        -- Move focus to the next window
        ((mod, xK_Right), windows W.focusDown),
        ((mod, xK_Down), windows W.focusDown),

        -- Shrink the master area
        ((mod .|. controlMask, xK_Left), sendMessage Shrink),
        ((mod .|. controlMask, xK_Up), sendMessage Shrink),
        -- Expand the master area
        ((mod .|. controlMask, xK_Right), sendMessage Expand),
        ((mod .|. controlMask, xK_Down), sendMessage Expand),

        -- Swap focused window with master window
        ((mod .|. shiftMask, xK_Return), windows W.swapMaster),
        -- Swap the focused window with the previous window
        ((mod .|. shiftMask, xK_Left), windows W.swapUp),
        ((mod .|. shiftMask, xK_Up), windows W.swapUp),
        -- Swap the focused window with the next window
        ((mod .|. shiftMask, xK_Right), windows W.swapDown),
        ((mod .|. shiftMask, xK_Down), windows W.swapDown),

        -- Change the layout
        ((mod, xK_l), sendMessage NextLayout),
        -- Reset the layout
        ((mod .|. shiftMask, xK_l), setLayout $ XMonad.layoutHook conf)
    ]

myMouseBindings XConfig {XMonad.modMask = modm} = Map.fromList
    [
        -- mod-button1, Set the window to floating mode and move by dragging
        ((modm, button1), \w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster),

        -- mod-button2, Raise the window to the top of the stack
        ((modm, button2), \w -> focus w >> windows W.shiftMaster),

        -- mod-button3, Set the window to floating mode and resize by dragging
        ((modm, button3), \w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster)
    ]

-- Apply even spacing between all windows and the screen edges
-- https://wiki.archlinux.org/title/Xmonad#Equally_sized_gaps_between_windows
myMarginScreen = 8
myMarginWindow = 2
screenSpacing = spacingRaw False (Border myMarginScreen myMarginWindow myMarginScreen myMarginWindow) True (Border myMarginWindow myMarginScreen myMarginWindow myMarginScreen) True

-- Tall:  Default tiling algorithm partitions the screen into two panes
-- 1:     The default number of windows in the master pane
-- 3/100: Percent of screen to increment by when resizing panes
-- 2/3:   Default proportion of screen occupied by master pane
nmaster = 1
delta = 3/100
ratio = 2/3
tiled = Tall nmaster delta ratio


myStartupHook :: X ()
myStartupHook = do
    spawnOnce "xrandr --output eDP-1-1 --mode 1920x1080 --right-of HDMI-0 && feh --bg-fill --nofehbg ~/Pictures/wallpaper/xenia-dark.png"
    spawnOnce "cd ~/Documents/CodingProjects/mpd-rating/ && pnpm dev --host"
    spawnOnce "$NIX_SRC/scripts/music/rng"

myManageHook :: ManageHook
myManageHook = composeAll
    [ isDialog --> doFloat ]

toggleFloat :: Window -> X ()
toggleFloat w =
    windows
        ( \s ->
            if Map.member w (W.floating s)
            then W.sink w s
            else W.float w (W.RationalRect (1 / 3) (1 / 4) (1 / 2) (1 / 2)) s
        )

main = do
  xmonad (Hacks.javaHack (ewmhFullscreen (ewmh (def
    {
        -- (Left) Super key
        modMask = mod4Mask,
        terminal = "kitty",
        keys = myKeys,
        mouseBindings = myMouseBindings,
        -- Whether window focus follows the mouse pointer.
        focusFollowsMouse = True,
        workspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"],
        normalBorderColor = "#6f7789",
        focusedBorderColor = "#7498e8",
        borderWidth = 2,
        startupHook = myStartupHook,
        layoutHook = screenSpacing $ tiled ||| Mirror tiled ||| Full,
        manageHook = myManageHook,
        handleEventHook = {- Hacks.fixSteamFlicker <>  -}Hacks.windowedFullscreenFixEventHook
    }))))
