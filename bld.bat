:: Configure
set CONF=Release
if "%ARCH%" == "32" (
  set SLN_PLAT=Win32
) else (
  set SLN_PLAT=x64
)

if "%VS_YEAR%" == "2015" (
  set TOOLSET=v140
  set SLN_FILE="visual_studio\matio.sln"
)
if "%VS_YEAR%" == "" (
  echo Unknown VS version
  exit 1
)

echo %LIBRARY_PREFIX%

:: Build
msbuild "%SLN_FILE%" ^
  /p:Configuration=Release ^
  /p:Platform=%SLN_PLAT% ^
  /p:PlatformToolset=%TOOLSET% ^
  /property:HDF5_DIR=%LIBRARY_PREFIX%
if errorlevel 1 exit 1

:: Install
copy %SRC_DIR%\visual_studio\%SLN_PLAT%\Release\libmatio.dll %LIBRARY_BIN%\
if errorlevel 1 exit 1
copy %SRC_DIR%\visual_studio\%SLN_PLAT%\Release\libmatio.lib %LIBRARY_LIB%\
if errorlevel 1 exit 1
copy %SRC_DIR%\src\matio.h %LIBRARY_INC%\
if errorlevel 1 exit 1
copy %SRC_DIR%\visual_studio\matio_pubconf.h %LIBRARY_INC%\
if errorlevel 1 exit 1

:: XX
lib /list %LIBRARY_LIB%\libmatio.lib