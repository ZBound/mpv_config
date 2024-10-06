---Screenshot the video and copy it to the clipboard
---@author ObserverOfTime
---@license 0BSD

---@class ClipshotOptions
---@field name string
---@field type string
local o = {
    name = 'mpv-screenshot.jpeg',
    type = '' -- defaults to jpeg
}
require('mp.options').read_options(o, 'clipshot')

local file, cmd

local platform = mp.get_property_native('platform')
if platform == 'windows' then
    file = os.getenv('TEMP')..'\\'..o.name
    cmd = {
        'powershell', '-NoProfile', '-Command', ([[& {
            Add-Type -Assembly System.Windows.Forms;
            Add-Type -Assembly System.Drawing;
            $shot = [Drawing.Image]::FromFile(%q);
            [Windows.Forms.Clipboard]::SetImage($shot);
        }]]):format(file)
    }
elseif platform == 'darwin' then
    file = os.getenv('TMPDIR')..'/'..o.name
    -- png: «class PNGf»
    local type = o.type ~= '' and o.type or 'JPEG picture'
    cmd = {
        'osascript', '-e', ([[
            set the clipboard to ( ¬
                read (POSIX file %q) as %s)
        ]]):format(file, type)
    }
else
    file = '/tmp/'..o.name
    if os.getenv('XDG_SESSION_TYPE') == 'wayland' then
        cmd = {'sh', '-c', ('wl-copy < %q'):format(file)}
    else
        local type = o.type ~= '' and o.type or 'image/jpeg'
        cmd = {'xclip', '-sel', 'c', '-t', type, '-i', file}
    end
end

---@param arg string
---@return fun()
local function clipshot(arg)
    return function()
        mp.commandv('screenshot-to-file', file, arg)
        mp.command_native_async({'run', unpack(cmd)}, function(suc, _, err)
            mp.osd_message(suc and '已将屏幕截图复制到剪贴板' or err, 1)
        end)
    end
end

mp.add_key_binding('',     'clipshot-subs',   clipshot('subtitles'))
mp.add_key_binding('',     'clipshot-video',  clipshot('video'))
mp.add_key_binding('', 'clipshot-window', clipshot('window'))
