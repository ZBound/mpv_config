## 修改自 [embyToLocalPlayer](https://github.com/kjtsune/embyToLocalPlayer)

修改内容:

1.将快速使用脚本(debug)汉化

2.添加自动写入mpv路径功能

3.添加可以调用上级目录的便携py包功能

4.将播放列表中url转换为文字标题，mpv.net不支持(Quz,Valentina)

5.预设部分 version_filter 参数(7nichi,Quz)


## 阅前提醒：此方案可向服务器回传进度，且不需要服务端支持，但播放时需要后台常驻运行一个 Python 脚本，且只有 Windows 系统可正常调用快捷脚本，其他平台请去 [原项目](https://github.com/kjtsune/embyToLocalPlayer) 查看教程。


(1) 如果你的系统中环境变量有 Python 包或使用 [MPV_lazy](https://github.com/hooke007/MPV_lazy)，请直接跳到第(2)步

    PS: MPV_lazy 观看 emby 闪退的话,请向 mpv.conf 中添加 msg-level=all=info 便可以解决

如果没有 [在此下载](https://www.python.org/downloads/windows/) 选择64位便携包，虽然对版本要求不高，但最好按照图中版本下载。

![图片](https://github.com/ZBound/mpv_config/assets/105804511/82f0adc6-2755-4124-9ba2-0c39640b3516)

下载完毕解压进 mpv 根文件夹，形如下图

![图片](https://github.com/ZBound/mpv_config/assets/105804511/91dae3ba-a45b-4196-8666-7c6b70fb1b5c)

(2) 下载修改版的 embyToLocalPlayer.7z，将 embyToLocalPlayer 文件夹解压进mpv根目录，请保证文件夹只有一层，不要嵌套多层，形如下图。

![图片](https://github.com/ZBound/mpv_config/assets/105804511/3f44e632-7ea1-459f-a976-8b7afc4a6e34)

(3) 双击运行 embyToLocalPlayer_debug.bat，输入 6 可自行写入 mpv 或 mpv.net 路径，并选中 mpv 或 mpv.net (仅限中文 Windows 系统)

运行完毕后，用任意文本编辑器打开 embyToLocalPlayer_config.ini 检查路径是否设置正确，你也可以手动输入路径

![图片](https://github.com/ZBound/mpv_config/assets/105804511/187140f7-340f-4f15-8d38-512348fa870d)

(4) 然后再次双击运行 embyToLocalPlayer_debug.bat，输入 1 尝试运行，如果报错窗口会输出错误信息。如果一切正常，窗口会输出类似下图的信息，此时不要关闭窗口。

![图片](https://github.com/ZBound/mpv_config/assets/105804511/3b489208-509c-4d7d-ad26-2991d9c9748d)

(5) 请在浏览器中使用 篡改猴 (Tampermonkey) 拓展或其它脚本管理器安装 [embyToLocalPlayer](https://greasyfork.org/zh-CN/scripts/448648) 脚本，安装完成后在网页中正常点击播放即可调用 MPV 播放器

![图片](https://github.com/ZBound/mpv_config/assets/105804511/1ea4d674-bd13-4eaf-876f-9b0b2fc8893f)

(6) 如果你想设置开机隐藏窗口自启动，可双击运行 embyToLocalPlayer_debug.bat ，然后输入 2 便可设置，有些杀毒软件可能会拦截此行为，请暂时关闭杀毒软件，所有代码均可审查，保证无毒无害。

双击运行 embyToLocalPlayer_debug.bat，输入 3 ，便可跳转到自启动vbs脚本所在的目录，可删除vbs取消自启动或审查代码


PS: embyToLocalPlayer_config.ini 中还有很多可设置项，比如http代理和连续播放优先级，具体看其中的中文注释


## 最后，感谢 [embyToLocalPlayer](https://github.com/kjtsune/embyToLocalPlayer) 和 [MPV](https://mpv.io/) 项目，及其相关的所有开发者


