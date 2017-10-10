@echo off
rem Sample script to launch External Simulation Process
rem
rem This script will start femap application
rem
rem File Name: CAE_ESP_Sample_Startup_Script_FEMAP_ML_NoParamFile.bat
rem
rem The application will send the following argument
rem
rem Input file fully qualified path              %1
rem Working directory fully qualified path       %2
rem Input Item ID                                %3
rem Input Revision ID                            %4
rem Input Dataset                                %5
rem Tool input arguments, concatenated with "?"  %6
rem Input Item Key				 %7
rem Parse these tool input arguments with "?"
@echo off

set input_file=%1
set working_dir=%2
set item_id=%3
set rev_id=%4
set dataset=%5
set tool_input_args=%6
set itemKeys_string_quotes_string=%7


set tool_input_args=%tool_input_args:?= %

echo.--------- PRINT INPUT ARGUMENTS LIST FILE---------

echo.input_file_name           : %input_file%
echo.working_dir               : %working_dir%
echo.item_id                   : %item_id%
echo.rev_id                    : %rev_id%
echo.dataset                   : %dataset%
echo.tool_input_args           : %tool_input_args%
echo.itemKeys_string_quotes    : %itemKeys_string_quotes%


echo.--------- CREATE LOG FILES---------
@echo %DATE%%TIME%: echo start interface dealings...>log.txt

echo.--------- PRINT INPUT ARGUMENTS LIST FILE INTO LOG---------

echo.%DATE%%TIME%: input_file_name           : %input_file%>>log.txt
echo.%DATE%%TIME%: working_dir               : %working_dir%>>log.txt
echo.%DATE%%TIME%: item_id                   : %item_id%>>log.txt
echo.%DATE%%TIME%: rev_id                    : %rev_id%>>log.txt
echo.%DATE%%TIME%: dataset                   : %dataset%>>log.txt
echo.%DATE%%TIME%: tool_input_args           : %tool_input_args%>>log.txt
echo.%DATE%%TIME%: itemKeys_string_quotes    : %itemKeys_string_quotes%>>log.txt



set tc_root=D:\Siemens\Teamcenter10
set tc_data=D:\Siemens\tcdata



if %input_file%=="noValue" (goto LAUNCHWOINPUT) else (goto LAUNCHWITHINPUT)

:LAUNCHWOINPUT
echo.%DATE%%TIME%: Lauched the interface without inputfiles,program quit...
echo.%DATE%%TIME%: Lauched the interface without inputfiles,program quit...>>log.txt
call "D:\HyperWorks13\hm\bin\win64\hmopengl.exe" %input_file% %tool_input_args%
goto RUN

:LAUNCHWITHINPUT
if %tool_input_args%=="noValue" (goto LAUNCHWOPARAM) else (goto LAUNCHWITHPARAM)


:LAUNCHWITHPARAM
@echo. The interface invoke with PARAM
@echo. The interface invoke with PARAM>>log.txt
rem Remove the quotes of the input arguments
@echo.%DATE%%TIME%: Remove the quotes of the input arguments
@echo.%DATE%%TIME%: Remove the quotes of the input arguments>>log.txt
set tool_input_args=%tool_input_args:"= %

@echo.%DATE%%TIME%: Removed results:tool_input_args=%tool_input_args%
@echo.%DATE%%TIME%: Removed results:tool_input_args=%tool_input_args%>>log.txt

@echo.%DATE%%TIME%: CALL HyperMesh WITH ARGUMENTS
@echo.%DATE%%TIME%: CALL %HyperMesh_EXCUTE_FILE%  %input_file% %tool_input_args%
@echo.%DATE%%TIME%: CALL HyperMesh WITH ARGUMENTS>>log.txt
@echo.%DATE%%TIME%: CALL %HyperMesh_EXCUTE_FILE%  %input_file% %tool_input_args%log.txt
goto HM



:LAUNCHWOPARAM
@echo.%DATE%%TIME%: CALL HyperMesh WITHOUT ARGUMENTS
@echo.%DATE%%TIME%: CALL %HyperMesh_EXCUTE_FILE%  %input_file%
@echo.%DATE%%TIME%: CALL HyperMesh WITHOUT ARGUMENTS>>log.txt
@echo.%DATE%%TIME%: CALL %HyperMesh_EXCUTE_FILE%  %input_file%>>log.txt
goto HM



:HM
@rem Define the CAD Full Path Directory
set full_path=%~2
set file_path=%1
@rem Define the File Name without Extension
set file_name=%~nx1
@echo.%DATE%%TIME%: 定义输入文件: gemotry_file=%full_path:\=/%/%file_name%>> log.txt 
set gemotry_file=%full_path:\=/%/%file_name%
@rem Define the HM TCL File
set hm_tcl_file=hm_tcl_%file_name%
@echo.%DATE%%TIME%: 导出文件全路径名为: %full_path%>> log.txt
@echo.%DATE%%TIME%: 将输入文件转换为UNIX路径: hm_tcl_file=hm_tcl_%~n1>> log.txt
@rem Change the CAD Full Path Directory to UNIX-like pattern - from \ to /
set file_path_unix=%full_path%
set "file_path_unix=%file_path_unix:\=/%"
echo UNIX_FULL_PATH: %file_path_unix%
@echo.%DATE%%TIME%: 创建TCL文件: hm_tcl_file=hm_tcl_%~n1>> log.txt
@rem Define the HM TCL File
rem set hm_tcl_file=hm_tcl_%file_name%
set hm_tcl_file=hm_tcl_%~n1
@echo.%DATE%%TIME%: 检查导出的文件中是否有hm文件: %hm_count%>> log.txt
@rem Check the # of HM file in the CAD Full Path Directory
cd /d %full_path%
dir /b /a-d *.hm |find /c "hm" > %full_path%\hm_count.txt
for /f %%i in (%full_path%\hm_count.txt) do set hm_count=%%i
echo HM_COUNT: %hm_count%
@echo.%DATE%%TIME%:List all the HM Files less the newly created HM Files and saved it in a new File hm_part.txt>> %working_dir%\log.txt
@rem List all the HM Files less the newly created HM Files and saved it in a new File hm_part.txt
cd /d %full_path%
dir /b /a-d *.hm |find /v "%file_name%" > %full_path%\hm_parts.txt
@echo.%DATE%%TIME%: 将输入对象信息写入TCL 文件: %full_path%\%hm_tcl_file%.tcl>> %working_dir%\log.txt
echo wm attributes . -topmost 1 >> %full_path%\%hm_tcl_file%.tcl
echo wm attributes . -topmost 0 >> %full_path%\%hm_tcl_file%.tcl
rem echo set ::HM_Framework::Settings::Export::FE_singleFile {%gemotry_file%}>> %full_path%\%hm_tcl_file%.tcl
rem echo set ::HM_Framework::Settings::Export::FE_singleFile {gemotry_file}
rem echo *feinputwithdata2 "#Detect" "%gemotry_file%" 1 0 -0.01 0 0 1 0 1 0 >> %full_path%\%hm_tcl_file%.tcl
rem echo *feinputwithdata2 "#Detect" "%gemotry_file%" 1 0 -0.01 0 0 1 0 1 0
@echo.%DATE%%TIME%: 检查并自动创建hm文件: if hm_count=1（hm_file=%~2\%~3_%~4_assy.hm）else (hm_file=%~2\%~3_%~4.hm）>> %working_dir%\log.txt
if %hm_count% GTR 1 (
echo HM Count Greater than 1
set hm_file=%~2\%~3_%~4_assy.hm
@rem if we found that there are more than 1 HM files, we need to create a new HM file. We do it by creating it from template file. 
@rem The template file template.hm is located in d:\ugs\tc_program
copy /Y D:\20170712\20170712.hm %hm_file%
) else (
set hm_file=%~2\%~3_%~4.hm
rem echo *feinputwithdata2("#Detect","%gemotry_file%",1,0,-0.01,0,0,1,0,1,0) >> %full_path%\%hm_tcl_file%.tcl
echo set ::HM_Framework::Settings::Export::FE_singleFile {%gemotry_file%}>> %full_path%\%hm_tcl_file%.tcl
echo set ::HM_Framework::Settings::Export::FE_singleFile {%gemotry_file%}
echo *feinputwithdata2 "#Detect" "%gemotry_file%" 1 0 -0.01 0 0 1 0 1 0 >> %full_path%\%hm_tcl_file%.tcl
echo *feinputwithdata2 "#Detect" "%gemotry_file%" 1 0 -0.01 0 0 1 0 1 0
)
@echo.%DATE%%TIME%: 将hm文件改为UNIX路径: "hm_file=%hm_file:\=/%">> %working_dir%\log.txt
set "hm_file=%hm_file:\=/%"
echo *writefile "%hm_file%" 1 >> %full_path%\%hm_tcl_file%.tcl
echo *readfile "%hm_file%" >> %full_path%\%hm_tcl_file%.tcl
for /f "delims= tokens=*" %%i in (%full_path%\hm_parts.txt) do echo *mergefile "%file_path_unix%/%%i" 1 1 >> %full_path%\%hm_tcl_file%.tcl
@echo.%DATE%%TIME%: 调用HyperMesh: call "D:\HyperWorks13\hm\bin\win64\hmopengl.exe"   -tcl %file_path_unix%/%hm_tcl_file%.tcl>> %working_dir%\log.txt
call "D:\HyperWorks13\hm\bin\win64\hmopengl.exe"   -tcl %file_path_unix%/%hm_tcl_file%.tcl
set /A progress=1
goto RUN


:RUN
echo. %DATE%%TIME%: finished computing,now exit programe...>>%working_dir%\log.txt
ping -n 30 127.1>nul
if not errorlevel 1 (goto SUCCESS) else (goto EOF)

:SUCCESS
@echo.%DATE%%TIME% EXIT 0
@echo.%DATE%%TIME% EXIT 0>>%working_dir%\log.txt
@echo.%DATE%%TIME% 开始转JT>>%working_dir%\log.txt
@echo.%DATE%%TIME% call "D:\Siemens\TC4S_Script\solver2jt.bat" %full_path%\%~3_%~4.inp>>%working_dir%\log.txt
call "D:\Siemens\TC4S_Script\solver2jt.bat" %full_path%\%~3_%~4.inp
EXIT 0

:EOF
@echo.%DATE%%TIME% EXIT 1
@echo.%DATE%%TIME% EXIT 1>>%working_dir%\log.txt

EXIT -1




