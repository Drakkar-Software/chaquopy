#!/bin/bash
set -eu

# Build the package in-place
make -j $CPU_COUNT build prefix=$PREFIX

# The package_wheel function expects the package files to be in the prefix directory root.
# PREFIX is set to {build_dir}/prefix/chaquopy, but package_wheel uses {build_dir}/prefix.
# So we need to copy the built package to the parent of PREFIX (which is the prefix_dir).
PREFIX_DIR=$(dirname "$PREFIX")

# Copy the built package directory to the prefix directory
# The tulipy package should be at the root of prefix_dir for wheel pack to find it
# This includes all .py files, .so files (compiled extensions), and subdirectories
cp -r tulipy "$PREFIX_DIR/"

make clean
