VERSION=$1

sudo apt-get install -y \
    pkg-config \
    git \
    tree \
    subversion \
    curl \
    wget \
    build-essential \
    xz-utils \
    zip

git config --global user.name "V8 Android Builder"
git config --global user.email "v8.android.builder@localhost"
git config --global core.autocrlf false
git config --global core.filemode false
git config --global color.ui true


cd ~
echo "=====[ Getting Depot Tools ]====="	
git clone -q https://chromium.googlesource.com/chromium/tools/depot_tools.git
export PATH=$(pwd)/depot_tools:$PATH
gclient


mkdir v8
cd v8

echo "=====[ Fetching V8 ]====="
fetch v8
echo "target_os = ['android']" >> .gclient
cd v8
./build/install-build-deps-android.sh
git checkout $VERSION
gclient sync


echo "=====[ Building V8 ]====="
python3 ./tools/dev/v8gen.py x64.release -vv -- '
target_os = "android"
target_cpu = "x64"
v8_target_cpu = "x64"
is_component_build = false
use_custom_libcxx = false
v8_enable_i18n_support = false
v8_use_external_startup_data = false
symbol_level = 1
v8_static_library = true
v8_monolithic = true
'
ninja -C out.gn/x64.release -t clean
ninja -C out.gn/x64.release
tree -L 4
cp ./third_party/android_ndk/sources/cxx-stl/llvm-libc++/libs/x86_64/libc++_shared.so ./out.gn/x64.release