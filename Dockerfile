
FROM		ubuntu:latest
MAINTAINER 	Vincent <agashka2@gmail.com>

# dependencies
RUN apt-get update
RUN apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc kernel-package initramfs-tools -y
