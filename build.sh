#!/bin/bash
./configure --prefix=/usr          \
            --bindir=/bin          \
            --sysconfdir=/etc      \
            --with-rootlibdir=/lib \
            --with-xz              \
            --with-zlib
make -j $SHED_NUMJOBS
make DESTDIR=${SHED_FAKEROOT} install
mkdir -v ${SHED_FAKEROOT}/sbin
for target in depmod insmod lsmod modinfo modprobe rmmod; do
    ln -sv ../bin/kmod ${SHED_FAKEROOT}/sbin/$target
done
ln -sv kmod ${SHED_FAKEROOT}/bin/lsmod
