set VERSION=%1

git config --global user.name "V8 Windows Builder"
git config --global user.email "v8.windows.builder@localhost"
git config --global core.autocrlf false
git config --global core.filemode false
git config --global color.ui true

cd %HOMEPATH%
echo =====[ Getting Depot Tools ]=====
powershell -command "Invoke-WebRequest https://storage.googleapis.com/chrome-infra/depot_tools.zip -O depot_tools.zip"
7z x depot_tools.zip -o*
set PATH=%CD%\depot_tools;%PATH%
set DEPOT_TOOLS_WIN_TOOLCHAIN=0
call gclient


mkdir v8
cd v8

echo =====[ Fetching V8 ]=====
call fetch v8
echo target_os = ['win'] >> .gclient
cd v8
call git checkout %VERSION%
call gclient sync


echo =====[ Building V8 ]=====
echo target_os = "win" > temp.txt
echo is_component_build = true >> temp.txt
echo v8_enable_i18n_support = false >> temp.txt
echo symbol_level=1 >> temp.txt
set /p SETTINGS=<temp.txt

call python .\tools\dev\v8gen.py x64.release -vv -- %SETTINGS%

call ninja -C out.gn\x64.release -t clean
call ninja -C out.gn\x64.release v8