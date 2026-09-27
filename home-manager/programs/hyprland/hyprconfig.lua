local config = require("hyprextra")

---@param offset number
---@return nil
local function zoom(offset)
	local MAX_ZOOM = 4
	local MIN_ZOOM = 1
	local ZOOM_TOGGLE_FACTOR = 1.2

	local current = hl.get_config("cursor.zoom_factor")
	if offset ~= nil then
		current = current + offset
	elseif current ~= MIN_ZOOM then
		current = MIN_ZOOM
	else
		current = ZOOM_TOGGLE_FACTOR
	end
	current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
	hl.config({ cursor = { zoom_factor = current } })
end

----------------------
--   Monitors and such
----------------------

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@120",
	position = "0x0",
	scale = 1,
})
hl.monitor({
	output = "eDP-1",
	mode = "2880x1800@120",
	position = "1920x0",
	scale = 2,
})

----------------------
--   Keybinds and Input
----------------------

hl.config({
	input = {
		kb_layout = "us",
		follow_mouse = 1,
		force_no_accel = true,
		natural_scroll = false,
		touchpad = {
			natural_scroll = true,
		},
	},

	binds = {
		-- For zoom in/out
		scroll_event_delay = 1,
	},
})
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.bind("SUPER + Space", hl.dsp.exec_cmd("pkill rofi || rofi -show drun"))
hl.bind("SUPER + T", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("librewolf"))
hl.bind("SUPER + F", hl.dsp.exec_cmd("nemo"))
hl.bind("SUPER + C", hl.dsp.exec_cmd("hyprpicker -a")) -- colorpicker
hl.bind("Print", hl.dsp.exec_cmd('grimblast copysave area ~/Pictures/screenshots/$(date +"%Y%m%d_%H%M%S").png'))

hl.bind("SUPER + D", hl.dsp.exec_cmd("wayscriber --active")) -- TODO: use systemd mode. how to auto-enable?
hl.bind("SUPER + mouse_up", function()
	zoom(0.5)
end)
hl.bind("SUPER + mouse_down", function()
	zoom(-0.5)
end)

hl.bind("SUPER + W", hl.dsp.window.close())
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + Escape", hl.dsp.workspace.swap_monitors({ monitor1 = 0, monitor2 = 1 }))
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + A", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + E", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + I", hl.dsp.focus({ direction = "right" }))

for i = 1, 10 do
	local key = i % 10 -- 10 maps to 0
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
-- TODO: currently broken
-- hyprctl dispatch execr "brightnessctl s 10 2> /home/dooshii/hello"
-- has "Failed to set brightness: Invalid request descriptor"
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("rmpc next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("rmpc togglepause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("rmpc togglepause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("rmpc prev"), { locked = true })

----------------------
--   Appearance
----------------------

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 8,
		border_size = 2,
		col = {
			active_border = config.border_active_opacity,
			inactive_border = config.border_inactive_opacity,
		},
		layout = "dwindle",
	},
	decoration = {
		rounding = config.radius,
		active_opacity = 1,
		inactive_opacity = config.inactive_opacity,
		fullscreen_opacity = 1,
		shadow = {
			enabled = true,
			range = 12,
			render_power = 3,
			offset = { 0, 2 },
			color = "rgba(00000099)",
		},
		blur = {
			enabled = true,
			size = 8,
			passes = 2,
			vibrancy = 0.1696,
		},
	},

	dwindle = {
		preserve_split = true,
	},

	misc = {
		force_default_wallpaper = 1,
		disable_hyprland_logo = true,
	},
})

----------------------
--   Animations
----------------------

hl.config({
	animations = {
		enabled = true,
	},
})

hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.05, 1.1 }, { 0.2, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "quick", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "quick", style = "slide" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "quick" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "quick" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "linear" })

----------------------
--   Environment
----------------------

-- TODO: Script to switch between the two monitors
-- hyprctl -r -- keyword device[wdht1f01:00-2575:092e-stylus]:output HDMI-A-1
-- hyprctl -r -- keyword device[wdht1f01:00-2575:092e-stylus]:output eDP-1
-- Unfortunately, https://github.com/hyprwm/Hyprland/issues/5724
hl.device({
	name = "wdht1f01:00-2575:092e-stylus",
	output = "eDP-1",
})

hl.config({
	debug = {
		disable_logs = false,
		disable_time = false,
		enable_stdout_logs = true,
	},
})

hl.on("hyprland.start", function()
	---@param command string
	---@param workspace number
	local function auto_open(command, workspace)
		local monitor = "eDP-1"
		if workspace == 2 then
			monitor = "HDMI-A-1"
		end

		hl.exec_cmd(command, {
			workspace = workspace .. " silent",
			-- shorthand { monitor } doesnt work unlike other languages,
			-- because lua thinks its an array item at index 1.
			-- this was weird to troubleshoot
			monitor = monitor,
		})
	end

	hl.exec_cmd("sudo systemctl start docker.service")

	auto_open("librewolf", 1)
	auto_open("kitty", 2)
	auto_open("vesktop", 3)
	auto_open("signal-desktop", 3)
	auto_open("Telegram", 3)
	auto_open("slack", 4)
	auto_open("thunderbird", 4)
	auto_open("karere", 4)
end)

hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "20")

----------------------
--   Windows
----------------------

hl.window_rule({
	name = "float-minecraft",
	match = {
		class = "Minecraft.*",
		float = true,
	},
})
hl.window_rule({
	name = "float-bevy",
	match = {
		class = "shortlike",
		float = true,
	},
})

-- https://github.com/hyprwm/Hyprland/blob/7ebf13abb3c391604c60c9f627c7a403bcec8d17/example/hyprland.lua#L326-L339
hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})
