# Build Script for Mojito

# Remove local_manifests directory
rm -rf .repo/local_manifests

# Clone the manifest repository
git clone https://github.com/giosaja96/local_manifest --depth 1 -b main .repo/local_manifests

# Force sync the repository
repo sync --force-sync -c -j $(nproc)

## Install ccache
sudo apt update
sudo apt install ccache -y

# Set up the build environment
source build/envsetup.sh

# Lunch for mojito device
lunch derp_mojito-userdebug

# Build for mojito device
mka derp
