#!/bin/bash

echo "building kernel $KERNEL, version $VERSION"

# download or copy kernel if exists on host
curl -O https://cdn.kernel.org/pub/linux/kernel/v4.x/testing/$KERNEL.tar.xz

# extract the kernel, change to dir
tar -xJf $KERNEL.tar.xz
cd $KERNEL

# clean
make-kpkg clean

### copy kernel config file
cp /host/.config /$KERNEL/

# compile kernel & package
make-kpkg kernel_image

# debirf
rm -rf ../debirf
mkdir ../debirf
cd ../debirf
cp /usr/share/doc/debirf/example-profiles/minimal.tgz minimal.tgz
tar -xf minimal.tgz

# make debirf
debirf make -k ../linux-image-$VERSION_i386.deb minimal
debird makeiso minimal
