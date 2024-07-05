@echo off
setlocal enabledelayedexpansion

:: 递归搜索并删除所有的.import文件
for /r %%a in (*.import) do (
    echo Deleting %%a...
    del "%%a"
)

echo All .import files have been deleted.

endlocal
pause
