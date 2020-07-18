curl -LO https://github.com/sbingner/llvm-project/releases/download/v10.0.0-1/linux-ios-arm64e-clang-toolchain.tar.lzma
TMP=$(mktemp -d)
tar --lzma -xvf linux-ios-arm64e-clang-toolchain.tar.lzma -C $TMP
pushd $TMP/ios-arm64e-clang-toolchain/bin
find * ! -name clang-10 -and ! -name ldid -and ! -name ld64 -exec mv {} arm64-apple-darwin14-{} \;
find * -xtype l -exec sh -c "readlink {} | xargs -I{LINK} ln -f -s arm64-apple-darwin14-{LINK} {}" \;
popd
sudo mkdir -p $THEOS/toolchain/linux/iphone
mv $TMP/ios-arm64e-clang-toolchain/* $THEOS/toolchain/linux/iphone/
rm -rf $TMP linux-ios-arm64e-clang-toolchain.tar.lzma
