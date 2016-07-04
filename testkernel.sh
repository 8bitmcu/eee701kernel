#!/bin/bash

qemu-system-x86_64 -m 2048M -kernel out/bzImage -initrd out/initrd
