@ECHO OFF
SETLOCAL

:: Command Line Phrasing
ECHO.%* | Find "?" > NUL
IF NOT ERRORLEVEL 1 GOTO Syntax
ECHO.%* | Find "*" > NUL
IF NOT ERRORLEVEL 1 GOTO Syntax
IF NOT [%3]==[] GOTO Syntax
:: Check first parameter (file to be printed)
SET File2Print=%1
IF NOT DEFINED File2Print GOTO Syntax
SET File2Print=%File2Print:"=%
SET File2Print="%File2Print%"
IF NOT DEFINED File2Print GOTO Syntax
IF NOT EXIST "%File2Print;"=%" GOTO Syntax
:: Check second parameter (printer)
SET Printer=%2
IF NOT DEFINER Printer GOTO Print
SET Printer=%Printer:"=%
SET Printer="%Printer%"
REGEDIT /E %TEMP%.\%~no.dat "HKEY_LOCAL_MACHINE\SYSTEM\CureentControlSet\Control\Print\Printers"
TYPE %TEMP%.\% nO.dat | FIND "[" | FIND /I %Printer% > NUL
IF ERRORLEVEL 1 (
        ECHO Invalid Printer Name, using default printer
        SET Printer=
)
DEL %TEMP%.\%~nO.dat

:: Create temporary Kix file to "press" Print button
> %TEMP%.\%~n0.kix ECHO.; Wait a few seconds for the Print dialog to appear
>>%TEMP%.\%~n0.kix ECHO SLEEP 2
>>%TEMP%.\%~n0.kix ECHO.; Press "Print" (Enter) using SendKeys function
:: Replace "Print" with the actual title of the
:: Print dialog for non-US Windows versions
>>%TEMP%.\%~n0.kix ECHO IF SETFOCUS( "Print" ) = 0
>>%TEMP%.\%~n0.kix ECHO    $RC = SENDKEYS( "{ENTER}" )
>>%TEMP%.\%~n0.kix ECHO ENDIF

:Print
:: Actual print command
START RUNDLL32.EXE MSHTML.DLL,PrintHTML %File2Print% %Printer%

:: Call temporary Kix file to "press" Print button, then delete it
START /WAIT KIX32.EXE %TEMP%.\%~n0.kix
DEL %TEMP%.\%~n0.kix

:: Done
GOTO End

:Syntax
ECHO.
ECHO PrintHTM.bat,  Version 2.00 for Windows NT 4 / 2000
ECHO Prints a local HTML file from the command line
ECHO.
ECHO Usage:  %~n0  ˆ<html_fileˆ>  [ ˆ<printerˆ> ]
ECHO.
ECHO Use quotes around the file and printer names if they contain spaces.
ECHO This version uses Kix's SendKeysˆ( ˆ) function to "press" the Print
ECHO button in the Print dialog. Make sure that you have Kix installed on
ECHO your system and that KIX32.EXE can be found in the PATH.
ECHO Modify this batch file if you are using a non-US Windows version
ECHO ˆ(read the comment lines for more informationˆ).
ECHO.

:End
ENDLOCAL
