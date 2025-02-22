#!/bin/bash

# Remove the local manifests directory if it exists (cleanup before repo initialization)
rm -rf .repo/local_manifests/

# remove device tree
rm -rf device/xiaomi/mojito
rm -rf device/xiaomi/sm6150-common
rm -rf kernel/xiaomi/mojito
rm -rf vendor/xiaomi/sm6150-common
rm -rf hardware/xiaomi

# Initialize ROM manifest
repo init -u https://github.com/The-Clover-Project/manifest.git -b 15-qpr1 --git-lfs

# Sync the repo with force to ensure a clean sync
/opt/crave/resync.sh

# remove frameworks/native
#rm -rf frameworks/native

# cloning device tree
git clone https://github.com/gioaprilino/device_xiaomi_mojito.git --depth 1 -b mojito-clover device/xiaomi/mojito
git clone https://github.com/gioaprilino/android_device_xiaomi_sm6150-common.git --depth 1 -b mojito-voyage device/xiaomi/sm6150-common

# cloning kernel tree
git clone https://github.com/gioaprilino/kernel_xiaomi_mojito.git --depth 1 -b inline-rom kernel/xiaomi/mojito

# cloning vendor tree
git clone https://gitlab.com/giosaja96/android_vendor_xiaomi_mojito.git --depth 1 -b 15 vendor/xiaomi/mojito
git clone https://gitlab.com/giosaja96/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 15 vendor/xiaomi/sm6150-common

# cloning hardware tree
https://github.com/gioaprilino/android_hardware_xiaomi_1.git --depth 1 -b mojito hardware/xiaomi

# add modify


# Export
export SELINUX_IGNORE_NEVERALLOWS=true

# Set up th build environment
. build/envsetup.sh

# generating keys
gk -s

# Choose the target device
lunch clover_mojito-ap4a-userdebug
mka clover
