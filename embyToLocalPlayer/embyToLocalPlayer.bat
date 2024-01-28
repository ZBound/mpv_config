@echo off
setlocal

:: 定位到批处理文件所在的上级目录
set "BATCH_PATH=%~dp0"
cd /d "%BATCH_PATH%.."

if %ERRORLEVEL% neq 0 (
    echo 无法更改到批处理文件的上级目录。
    goto EndScript
)

:: 设置Python解释器的路径
set "PYTHON_EXE=%CD%\python.exe"

:: 检查Python解释器是否存在
if not exist "%PYTHON_EXE%" (
    echo 在 "%PYTHON_EXE%" 未找到Python主程序，尝试使用系统变量中的解释器。
    where python >nul 2>&1
    if %ERRORLEVEL% neq 0 (
        echo 在系统变量中也未找到Python主程序。
        goto EndScript
    ) else (
        set "PYTHON_EXE=python"
    )
)

:: 设置Python脚本的路径
set "PYTHON_SCRIPT=%CD%\embyToLocalPlayer\embyToLocalPlayer.py"

:: 检查Python脚本是否存在
if not exist "%PYTHON_SCRIPT%" (
    echo 在 "%PYTHON_SCRIPT%" 未找到Python脚本。
    goto EndScript
)

:: 运行Python脚本
"%PYTHON_EXE%" "%PYTHON_SCRIPT%"
if %ERRORLEVEL% neq 0 (
    echo 运行Python脚本失败。
) else (
    echo 成功运行Python脚本。
)

:EndScript
:: 在脚本结束前暂停，这样可以看到输出结果
pause
endlocal

exit /b
