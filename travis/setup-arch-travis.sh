#!/bin/bash --

# $TRAVIS_BUILD_DIR
BUILD_DIR="${1}"

# /home/travis/build
cd ../../

# Arch Linux build environment
# https://github.com/mikkeloscar/arch-travis/
curl -s -O "https://raw.githubusercontent.com/mikkeloscar/arch-travis/master/arch-travis.sh"
bash arch-travis.sh

# Go back to build directory
cd "${BUILD_DIR}"/
