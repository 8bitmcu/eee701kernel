#!/bin/bash

echo "building kernel $KERNEL, version $VERSION"

# download or copy kernel if exists on host
if [ -a /host/$KERNEL.tar.xz ]
  then
    cp /host/$KERNEL.tar.xz /
  else
    curl -O https://cdn.kernel.org/pub/linux/kernel/v4.x/testing/$KERNEL.tar.xz
fi

# extract the kernel, change to dir
tar -xJf $KERNEL.tar.xz
cd $KERNEL

# clean
make clean && make mrproper

# copy kernel config file
cp /host/.config /$KERNEL/

# compile kernel, copy to host
make
cp arch/x86/bzImage /host/out/bzImage

# install modules, create init ram disk
make modules_install
mkinitramfs -k -o /host/out/initrd $VERSION
