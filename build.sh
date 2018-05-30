#!/bin/bash
# Configure
./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --with-xz              \
            --with-zlib &&
# Build and Install
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install &&
# Rearrange
mkdir -v "${SHED_FAKE_ROOT}/sbin" || exit 1
for SHED_PKG_LOCAL_TARGET in depmod insmod lsmod modinfo modprobe rmmod; do
    ln -sfv ../bin/kmod "${SHED_FAKE_ROOT}/sbin/${SHED_PKG_LOCAL_TARGET}" || exit 1
done
ln -sfv kmod "${SHED_FAKE_ROOT}/bin/lsmod"
