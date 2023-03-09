VERSION=$1

sudo apt-get install -y \
    pkg-config \
    git \
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
python3 ./tools/dev/v8gen.py arm.release -vv -- '
target_os = "android"
target_cpu = "arm"
v8_target_cpu = "arm"
is_component_build = false
use_custom_libcxx = false
v8_enable_i18n_support = false
v8_use_external_startup_data = false
v8_symbol_level = 0
v8_static_library = true
v8_monolithic = true
'
ninja -C out.gn/arm.release -t clean
ninja -C out.gn/arm.release v8_monolith
cp ./third_party/android_ndk/sources/cxx-stl/llvm-libc++/libs/armeabi-v7a/libc++_shared.so ./out.gn/arm.release