#!/bin/bash
./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --with-xz              \
            --with-zlib
make -j $SHED_NUM_JOBS
make DESTDIR=${SHED_FAKE_ROOT} install
mkdir -v ${SHED_FAKE_ROOT}/sbin
for target in depmod insmod lsmod modinfo modprobe rmmod; do
    ln -sv ../bin/kmod ${SHED_FAKE_ROOT}/sbin/$target
done
ln -sv kmod ${SHED_FAKE_ROOT}/bin/lsmod
