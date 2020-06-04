set VERSION=%1

git config --global user.name "V8 Windows Builder"
git config --global user.email "v8.windows.builder@localhost"
git config --global core.autocrlf false
git config --global core.filemode false
git config --global color.ui true


cd %HOMEPATH%
echo "=====[ Getting Depot Tools ]====="
powershell -command "Invoke-WebRequest https://storage.googleapis.com/chrome-infra/depot_tools.zip -O depot_tools.zip"
7z x depot_tools.zip -o*
setx PATH "%HOMEPATH%\depot_tools;%PATH%" /m
setx DEPOT_TOOLS_WIN_TOOLCHAIN 0 /m
gclient


mkdir v8
cd v8

echo "=====[ Fetching V8 ]====="
fetch v8
echo "target_os = ['win']" >> .gclient
cd %HOMEPATH%\v8\v8
git checkout %VERSION%
gclient sync


echo "=====[ Building V8 ]====="
python .\tools\dev\v8gen.py x64.release -vv -- '^
target_os = "win"^
is_component_build = true^
v8_enable_i18n_support = false^
symbol_level = 1^
'
ninja -C out.gn\x64.release -t clean
ninja -C out.gn\x64.release v8