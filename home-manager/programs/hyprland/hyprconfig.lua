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

hl.bind("SUPER + T", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + B", hl.dsp.exec_cmd("librewolf"))

hl.bind("SUPER + Space", hl.dsp.exec_cmd("pkill rofi || rofi -show drun"))

hl.bind("SUPER + W", hl.dsp.window.close())
hl.bind("SUPER + V", hl.dsp.window.float({ action = "toggle" }))

hl.bind("SUPER + H", hl.dsp.focus({ direction = "left" }))
hl.bind("SUPER + A", hl.dsp.focus({ direction = "down" }))
hl.bind("SUPER + E", hl.dsp.focus({ direction = "up" }))
hl.bind("SUPER + I", hl.dsp.focus({ direction = "right" }))

for i = 1, 10 do
	local key = i % 10 -- 10 maps to 0
	hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
