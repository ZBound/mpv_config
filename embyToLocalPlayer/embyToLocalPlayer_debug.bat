@echo OFF

:BEGIN
cls

    echo 请输入数字
    echo 1: 进行首次试运行，开启窗口
    echo 2: 设置开机无窗口自启动
    echo 3: 打开自启动文件夹
    echo 4: 开启路径转换助手
    echo 5: 复制embyToLocalPlayer.py路径到剪贴板
    echo 6: 写入mpv路径到配置文件并选中mpv作为emby播放器
    choice /N /C:123456 /M "请输入数字"%1
    IF ERRORLEVEL ==6 GOTO SIX
    IF ERRORLEVEL ==5 GOTO FIVE
    IF ERRORLEVEL ==4 GOTO FOUR
    IF ERRORLEVEL ==3 GOTO THREE
    IF ERRORLEVEL ==2 GOTO TWO
    IF ERRORLEVEL ==1 GOTO ONE
    GOTO END
) else (
    GOTO END
)

:SIX
echo 你按下了 6
 emby_mpv_path.bat
GOTO END




:FIVE
echo 你按下了 5
set mainCmd=python "%cd%\embyToLocalPlayer.py"
echo %mainCmd%
echo 已复制，粘贴命令是 "Ctrl + V"
echo %mainCmd%|clip
GOTO END


:FOUR
echo 你按下了 4
python utils/conf_helper.py
GOTO END


:THREE
echo 你按下了 3
explorer shell:startup
GOTO END


:TWO
echo 你按下了 2
set "startupVbs=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\embyToLocalPlayer.vbs"
(echo CreateObject^("Wscript.Shell"^).Run chr^(34^) ^& "%cd%\embyToLocalPlayer.bat" ^& chr^(34^), 0, True) > "%startupVbs%"
echo 请手动关闭这个窗口
wscript.exe "%startupVbs%"
GOTO END



:ONE
echo 你按下了 1
 embyToLocalPlayer.bat
GOTO END


:END
echo 所有任务已完成。
pause
