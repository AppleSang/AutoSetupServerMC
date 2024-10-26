@echo off
REG ADD "HKCU\Console" /v "FaceName" /t REG_SZ /d "Consolas" /f >nul 2>&1
REG ADD "HKCU\Console" /v "FontSize" /t REG_DWORD /d "26" /f >nul 2>&1
REG ADD "HKCU\Console" /v "FontWeight" /t REG_DWORD /d "400" /f >nul 2>&1

reg add HKLM /F >nul 2>&1
if %errorlevel% neq 0 start "" /wait /I /min powershell -NoProfile -Command start -verb runas "'%~s0'" && exit /b
SETLOCAL EnableDelayedExpansion
mode 100,70
chcp 65001
title - Tool Auto Setup Server By AppleSang - 

if not exist %tmp%\AppleAsset (
         start powershell.exe -WindowStyle Hidden -Command "irm https://raw.githubusercontent.com/AppleSang/AutoSetupServerMC/refs/heads/master/StuffScript/Download_Asset.ps1|iex"
         goto A
) ELSE (goto Menu)



:A
cls
echo.
echo.
color 3
echo ============================================================
echo          Tool Auto Setup Server By AppleSang
echo ============================================================
:: echo     Neu Ban Khong The Thay Dong Chu O Phia Duoi
:: echo     Hay Chuot Phai Vao Title Bar(Command Prompt)	
:: echo     Chon Propertiees, vao tab Font Va Chon Consolas
echo.
echo.
echo     Và Nếu Bạn Sử Dụng Tool Này Thì Sẽ Đồng Ý ToS Chứ? 
echo           {insert ToS here}
echo       [1] Đồng Ý                         [2] Từ Chối
echo.
echo.
set /p tos="Bạn Có Đồng Ý ToS không? (1/2):  "
if "%tos%"=="1" goto java
if "%tos%"=="2" exit


:java
cls
echo.
echo.
color 6
echo ============================================================
echo          Tool Auto Setup Server By AppleSang
echo ============================================================
echo.
echo.
echo       Bạn Muốn Tool Cài Giúp Bạn Java 22 Không? 
echo       [1] Có được chứ!
echo       [2] Mình đã cài java cần thiết rùi.
echo.
echo.      
echo.
echo.
set /p choo="Hãy Chọn Mục Server Bạn Muốn Sử Dụng: "
if "%choo%"=="1" goto instjav
if "%choo%"=="2" goto Menu



:instjav
@echo off
setlocal

:: Define the URL for the JDK installer
set "jdk_url=https://cdn.azul.com/zulu/bin/zulu22.32.15-ca-jdk22.0.2-win_x64.msi"
set "jdk_installer=%TEMP%\AppleAsset\zulu22.32.15-ca-jdk22.0.2-win_x64.msi"

:: Check if Java is installed and get the version
for /f "tokens=2 delims=." %%i in ('java -version 2^>^&1 ^| findstr /i "java version"') do (
    set "java_version=%%i"
)

:: If Java is not installed, set java_version to 0
if not defined java_version (
    set "java_version=0"
)

:: Compare the version
if %java_version% LSS 22 (
    echo Java Dưới Phiên Bản 22. Đang Tự Động Cài...

    :: Delete the installer if it already exists in TEMP
    if exist "%jdk_installer%" (
        del "%jdk_installer%"
    )

    :: Download the JDK installer using BITS to TEMP
    echo Đang tải Java 22...
    start cmd /C powershell.exe -WindowStyle Hidden -Command "Start-BitsTransfer -Source '%jdk_url%' -Destination '%jdk_installer%'"
    timeout /t 10

    :: Check if the download was successful
    if exist "%jdk_installer%" (
        echo Đã Tải Thành Công. Đang Tự Động Cài Đặt...
        msiexec /i "%jdk_installer%" /quiet /norestart

        if %errorlevel% neq 0 (
            cls
            echo Cài Đặt Thất Bại
            goto instjav
        ) else (
            echo Đã Cài Đặt Hoàn Tất!
            :: Delete the installer after successful installation
            del "%jdk_installer%"
        )
    ) else (
        echo Tải Không Được Java 22 Rồi!
    )
) else (
    title Java hiện đang là %java_version%. Không Cần Cài
)

endlocal



:Menu
start powershell.exe -WindowStyle Hidden -Command "irm https://github.com/AppleSang/AutoSetupServerMC/raw/refs/heads/master/StuffScript/FirstToast.ps1|iex"
cls
echo.
echo.
color A
echo ============================================================
echo          Tool Auto Setup Server By AppleSang
echo ============================================================
echo.
echo.
echo       [1] Cài Đặt Server 
echo       [2] Tối Ưu Server 
echo       [3] Mở Port
echo.
echo.
echo.
echo.
set /p choo="Hãy Chọn Mục Server Bạn Muốn Sử Dụng: "
if "%choo%"=="download" powershell.exe -WindowStyle Hidden -Command "Set-Variable -Name 'info' -Value 'Yeah Apple and Jar' ; irm https://raw.githubusercontent.com/AppleSang/AutoSetupServerMC/refs/heads/master/StuffScript/Download_Process.ps1|iex"
if "%choo%"=="2" powershell.exe -WindowStyle Hidden -Command "irm https://gist.githubusercontent.com/dend/5ae8a70678e3a35d02ecd39c12f99110/raw/0292160b8710d73a0a03996b785e4c79aa76d73b/toast.ps1|iex; Show-Notification -ToastTitle 'Yeah! Your Server Is Starting' 'This toast succes'"
if "%choo%"=="debug" goto A
if "%choo%"=="3" goto port
if "%choo%"=="1" goto Location

:Location
cls
echo.
echo.
color E
echo ============================================================
echo          Tool Auto Setup Server By AppleSang
echo ============================================================
echo.
echo.
echo       Bạn Muốn Lưu Server Ở Đâu?
echo       [1] Mặc định (Tại thư mục ServerMC-AppleTool)
echo       [2] Tự chọn đường dẫn
echo.
echo.
echo.
set /p loc="Hãy Chọn Vị Trí Lưu Server (1/2): "
if "%loc%"=="1" (
    set "SERVER_PATH=%~dp0ServerMC-AppleTool"
    if not exist "%SERVER_PATH%" mkdir "%SERVER_PATH%"
    goto MC
)
if "%loc%"=="2" (
    set /p SERVER_PATH="Nhập đường dẫn đầy đủ nơi bạn muốn lưu server: "
    if not exist "%SERVER_PATH%" mkdir "%SERVER_PATH%"
    goto MC
)
if "%loc%" GTR "2" (
    set "SERVER_PATH=%~dp0ServerMC-AppleTool"
    if not exist "%SERVER_PATH%" mkdir "%SERVER_PATH%"
    echo Đã tạo thư mục mặc định tại "%SERVER_PATH%"
    goto MC
goto Location


:MC
cls
echo.
echo.
color 6
echo ============================================================
echo          Tool Auto Setup Server By AppleSang
echo ============================================================
echo.
echo.
echo       [1] Paper 
echo       [2] Purpur
echo       [3] Folia
echo       [4] Fabric
echo       [5] Forge
echo.
echo.
echo.
echo.
set /p choo="Bạn Muốn Cài Máy Chủ Loại Nào? (Nhập Số) "
if "%choo%" == "1" goto Paper
if "%choo%" == "2" goto Purpur
if "%choo%" == "3" goto Folia
if "%choo%" == "4" goto Fabric
if "%choo%" == "5" goto Forge
if %choo% GEQ 6 goto MC


:Paper
start /wait powershell.exe -NoExit -Command "Set-Variable -Name 'selectedProject' -Value 'paper' ; irm https://raw.githubusercontent.com/AppleSang/AutoSetupServerMC/refs/heads/master/StuffScript/MC_Paper.ps1|iex"







