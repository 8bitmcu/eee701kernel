FROM		ubuntu:latest
MAINTAINER 	Vincent <agashka2@gmail.com>

RUN apt-get update
RUN apt-get install git fakeroot build-essential ncurses-dev xz-utils libssl-dev bc kernel-package -y
RUN curl -O https://cdn.kernel.org/pub/linux/kernel/v4.x/testing/linux-4.7-rc5.tar.xz
RUN tar -xvJf linux-4.7-rc5.tar.xz
WORKDIR /linux-4.7-rc5
RUN make clean && make mrproper
