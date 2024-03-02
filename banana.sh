#!/bin/bash

set -e

# Initialize repo with specified manifest
repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs

# Run inside foss.crave.io devspace, in the project folder
# Remove existing local_manifests
crave run --no-patch -- "rm -rf .repo/local_manifests && \
# Initialize repo with specified manifest
repo init -u https://github.com/bananadroid/android_manifest.git -b 14 --git-lfs && \

# Clone local_manifests repository
git clone https://github.com/gioaprilino/local_manifest.git .repo/local_manifests -b banana && \

# Removals
rm -rf prebuilts/clang/host/linux-x86

# Sync the repositories
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --optimized-fetch --prune && \

# Set up build environment
source build/envsetup.sh && \

# Lunch configuration
lunch banana_mojito-userdebug && \

m banana && \
echo "Date and time:" ; \

# Print out/build_date.txt
cat out/build_date.txt; echo \

# Print SHA256
sha256sum out/target/product/*/*.zip"

# Clean up
# rm -rf tissot/*



# Pull generated zip files
 crave pull out/target/product/*/*.zip 

# Pull generated img files
#crave pull out/target/product/*/*.img

# Upload zips to Telegram
# telegram-upload --to sdreleases tissot/*.zip

#Upload to Github Releases
#curl -sf https://raw.githubusercontent.com/Meghthedev/Releases/main/headless.sh | sh
