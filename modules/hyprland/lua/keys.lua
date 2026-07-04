local browser = "vivaldi --enable-features=UseOzonePlatform --ozone-platform=wayland"
local editor = "code --disable-gpu"
local term = "kitty"
local fileManager = term .. " --class \"tuiFileManager\" -e yazi"
local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"))

hl.bind(mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.group.toggle())
hl.bind("ALT + return", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + backspace", hl.dsp.exit())
hl.bind(mainMod .. " + delete", hl.dsp.exec_cmd("systemctl reboot"))

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))

hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd(term .. " -e 'btop'"))
hl.bind(mainMod .. " + CTRL + C", hl.dsp.exec_cmd("hyprpicker --autocopy --format=hex"))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("launcher games"))

hl.bind(mainMod .. " + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.bring_to_top())
end)

hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + ALT + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + ALT + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + ALT + down", hl.dsp.window.move({ direction = "d" }))


hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 100, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }), { repeating = true })

hl.bind(mainMod .. " + CTRL + Z", hl.dsp.window.move({ workspace = "special", follow = false }))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mainMod .. " + Z", hl.dsp.workspace.toggle_special(""))

for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + CTRL + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag())
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind("xf86Sleep", hl.dsp.exec_cmd("systemctl suspend"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pamixer --default-source -t"))
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pamixer -t"))
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind("xf86AudioNext", hl.dsp.exec_cmd("playerctl next"))
hl.bind("xf86AudioPrev", hl.dsp.exec_cmd("playerctl previous"))
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 2%-"), { repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +2%"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("pamixer -d 2"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("pamixer -i 2"), { repeating = true })

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace",
})

hl.config({
    binds = {
        workspace_back_and_forth = 0,
    },
})