-- 绑定快捷键播放时开关最小化自动暂停功能 --

local options = require 'mp.options'
local settings = {
    auto_pause = false,
    -- was_paused_before_minimize = false -- 
	-- 将上面一行注释去除便可实现最小化前暂停，最小化恢复后保持暂停状态，但与 embyToLocalPlayer 脚本冲突，无法正常使用 --
}
local config_file = "auto-pause-config.log"

function save_settings()
    local config_path = mp.command_native({"expand-path", "~~/files/" .. config_file})
    local file = io.open(config_path, "w+")
    if file then
        file:write(settings.auto_pause and "true" or "false")
        file:close()
    else
        mp.msg.error("Could not save settings to " .. config_path)
    end
end

function load_settings()
    local config_path = mp.command_native({"expand-path", "~~/files/" .. config_file})
    local file = io.open(config_path, "r")
    if file then
        local content = file:read("*all")
        settings.auto_pause = (content == "true")
        file:close()
    else
        mp.msg.warn("Could not load settings from " .. config_path .. "; using defaults.")
    end
end

function toggle_auto_pause()
    settings.auto_pause = not settings.auto_pause
    save_settings()
    mp.osd_message("最小化自动暂停: " .. (settings.auto_pause and "开启" or "关闭"))
end

function on_minimize(name, value)
    if settings.auto_pause and name == "window-minimized" and value then
        mp.set_property("pause", "yes")
    elseif settings.auto_pause and name == "window-minimized" and not value then
        mp.set_property("pause", "no")
    end
end

mp.register_event("start-file", function()
    load_settings()
    mp.observe_property("window-minimized", "bool", on_minimize)
end)

mp.add_key_binding("", "toggle_auto_pause", toggle_auto_pause)
