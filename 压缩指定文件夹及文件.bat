@echo off
%1 mshta vbscript:createobject("wscript.shell").run("""%~0"" rem",0)(window.close)&&exit
cd /d C:\Users\Administrator\Desktop
set rar=E:\บรัน\WinRAR.exe
set name=gan_test
(echo %name%_files
echo %name%*)>R.lst
"%rar%" a "%~dp0A" -ep1 -rr -av -ao -m5 @R.lst -ibck -xR.lst
del R.lst
exit