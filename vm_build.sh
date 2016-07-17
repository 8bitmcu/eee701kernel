#!/bin/bash

usage() {
    cat <<EOF
Usage: $CMD <subcommand> [options] [args]

subcommands:
  kernel [options]
    -c|--clean                clean
  image [options]
    -c|--clean                clean
  help                      this help
EOF
}

kernel() {
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
  make-kpkg --revision=0 kernel_image
}

image() {
  # debirf
  rm -rf ../debirf
  mkdir ../debirf
  cd ../debirf
  cp /usr/share/doc/debirf/example-profiles/minimal.tgz minimal.tgz
  tar -xf minimal.tgz
  
  # make debirf
  debirf make -k ../linux-image-$VERSION_i386.deb minimal
  debird makeiso minimal
}


COMMAND="$1"
[ "$COMMAND" ] || failure "Type '$CMD help' for usage."
shift

case $COMMAND in
    'kernel'|'k')
        kernel "$@"
        ;;
    'image'|'i')
        image "$@"
        ;;
    'help'|'h'|'?'|'-h'|'--help')
        usage
        ;;
    *)
        failure "Unknown command: '$COMMAND'
Type '$CMD help' for usage."
        ;;
esac
