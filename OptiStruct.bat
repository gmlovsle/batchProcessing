@echo off

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

D:\HyperWorks13\hwsolvers\common\tcl\tcl8.5.9\win64\bin\wish85t.exe "D:\HyperWorks13\hwsolvers\scripts\hwsolver.tcl" -solver OS -icon  %input_file%





