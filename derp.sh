# Build Script for Mojito

# Remove local_manifests directory
rm -rf .repo/local_manifests

## Clone the manifest repository
repo init --depth=1 -u https://github.com/DerpFest-AOSP/manifest.git -b 14

git clone https://github.com/giosaja96/local_manifest --depth 1 -b main .repo/local_manifests

# Force sync the repository
repo sync -c -j4 --force-sync --no-clone-bundle --no-tags

## Install ccache
sudo apt update
sudo apt install ccache -y

# Set up the build environment
source build/envsetup.sh

# Lunch for mojito device
lunch derp_mojito-userdebug

# Build for mojito device
mka derp
