#!/bin/bash
set -e -u
ARCHIVE=libicns-0.8.1.tar.gz
ARCHIVEDIR=libicns-0.8.1
. $KOBO_SCRIPT_DIR/build-common.sh

patch -p0 < $PATCHESDIR/libicns-make.patch

pushd $ARCHIVEDIR
        LDFLAGS="-L/${DEVICEROOT}/lib" ./configure --host=${CROSSTARGET} --prefix=/${DEVICEROOT}  --with-sysroot=/${DEVICEROOT}
	$MAKE -j$MAKE_JOBS
	$MAKE install
popd
markbuilt