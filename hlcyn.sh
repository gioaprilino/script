#!/bin/bash

rm -rf .repo/local_manifests/

# Rom source repo
repo init --depth=1 -u https://github.com/halcyonproject/manifest.git -b 14.3 --git-lfs
echo "=================="
echo "Repo init success"
echo "=================="

# Clone local_manifests repository
git clone -b hlcyn https://github.com/gioaprilino/local_manifest.git .repo/local_manifests
echo "============================"
echo "Local manifest clone success"
echo "============================"

# Sync the repositories
/opt/crave/resync.sh
echo "============================"

# Export
export BUILD_USERNAME=gioaprilino
export BUILD_HOSTNAME=crave
export ALLOW_MISSING_DEPENDENCIES=TRUE
echo "======= Export Done ======"

#build the rom
. build/envsetup.sh
lunch halcyon_mojito-RELEASE-userdebug
make carthage -j$(nproc --all)
