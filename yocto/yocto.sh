sudo apt install chrpath diffstat gawk zstd lz4

git clone --depth 1 https://git.yoctoproject.org/git/poky -b dunfell
cd poky
git clone https://git.yoctoproject.org/git/meta-rockchip -b dunfell
git clone git://git.yoctoproject.org/meta-arm -b dunfell
git clone --depth 1 git://git.openembedded.org/meta-openembedded -b dunfell

. oe-init-build-env
#bitbake core-image-minimal