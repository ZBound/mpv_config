@echo off
setlocal EnableDelayedExpansion

chcp 65001

:: 定位到脚本所在目录的父目录
set "BATCH_PATH=%~dp0"
cd /d "%BATCH_PATH%.."

set "configFile=%BATCH_PATH%embyToLocalPlayer_config.ini"
set "tempFile=%BATCH_PATH%temp.ini"
set /a "maxLines=25"
set /a "lineCount=0"

:: 将 UTF-8 编码的配置文件转换为 GB18030 编码
:: PowerShell -Command "Get-Content '%configFile%' -Encoding UTF8 | Out-File -FilePath '%tempFile%' -Encoding Default"
PowerShell -Command "Get-Content '%configFile%' -Encoding UTF8 | Out-File -FilePath '%tempFile%' -Encoding UTF8"

:: 用转换后的临时文件替换原始配置文件路径
move /y "%tempFile%" "%configFile%"

:: 检查父目录中是否存在 mpvnet.exe 或 mpv.exe
if exist "mpvnet.exe" (
    set "keyToFindMpve=mpve ="
    set "newValueMpve= %CD%\mpvnet.exe"
    set "keyToFindPlayer=player ="
    set "newValuePlayer= mpve"
) else if exist "mpv.exe" (
    set "keyToFindMpve=mpv ="
    set "newValueMpve= %CD%\mpv.exe"
    set "keyToFindPlayer=player ="
    set "newValuePlayer= mpv"
) else (
    echo 错误: 未找到 mpvnet.exe 或 mpv.exe。
    pause
    goto EndScript
)

:: 检查配置文件是否存在
if not exist "%configFile%" (
    echo 错误: 配置文件 "%configFile%" 未找到。
    goto EndScript
)

:: 创建新的临时文件
>"%tempFile%" (
    for /f "delims=" %%a in ('type "%configFile%"') do (
        set "line=%%a"
        set /a "lineCount+=1"
        
        :: 只处理前25行
        if !lineCount! leq !maxLines! (
            :: 检查行是否包含 keyToFindMpve
            echo !line! | findstr /b /c:"!keyToFindMpve!" >nul
            if !errorlevel! equ 0 (
                echo !keyToFindMpve!!newValueMpve!
            ) else (
                :: 如果不是 mpve，则检查是否是 player
                echo !line! | findstr /b /c:"!keyToFindPlayer!" >nul
                if !errorlevel! equ 0 (
                    echo !keyToFindPlayer!!newValuePlayer!
                ) else (
                    echo !line!
                )
            )
        ) else (
            echo !line!
        )
    )
)

:: 删除原始配置文件
del "%configFile%"
if not exist "%configFile%" (
    echo mpv路径写入成功。
) else (
    echo 错误: 写入mpv路径失败。
    goto EndScript
)

:: 将 GB18030 编码的临时文件转换回 UTF-8 编码
:: PowerShell -Command "Get-Content '%tempFile%' -Encoding Default | Out-File -FilePath '%configFile%' -Encoding UTF8"
PowerShell -Command "Get-Content '%tempFile%' -Encoding UTF8 | Out-File -FilePath '%configFile%' -Encoding UTF8"

:: 删除临时文件
del "%tempFile%"

:EndScript
endlocal
pause
