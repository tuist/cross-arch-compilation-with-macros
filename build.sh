#!/usr/bin/env bash

set -e

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TMP_DIR=/private$(mktemp -d)
trap "rm -rf $TMP_DIR" EXIT 
ARM64_TARGET=arm64-apple-macosx 
X86_64_TARGET=x86_64-apple-macosx
PRODUCT=cross-arch-compilation-with-macros

xcrun swift build \
    --configuration release \
    --disable-sandbox \
    --product $PRODUCT \
    --package-path $ROOT_DIR \
    --build-path $TMP_DIR/.build \
    --triple $ARM64_TARGET
    
xcrun swift build \
    --configuration release \
    --disable-sandbox \
    --product $PRODUCT \
    --package-path $ROOT_DIR \
    --build-path $TMP_DIR/.build \
    --triple $X86_64_TARGET

xcrun lipo -create -output $TMP_DIR/$PRODUCT $TMP_DIR/.build/$ARM64_TARGET/release/$PRODUCT  $TMP_DIR/.build/$X86_64_TARGET/release/$PRODUCT