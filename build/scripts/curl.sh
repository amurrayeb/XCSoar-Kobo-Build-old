#!/bin/bash
set -e -u
ARCHIVE=curl-7.30.0.tar.bz2
ARCHIVEDIR=curl-7.30.0
. $KOBO_SCRIPT_DIR/build-common.sh

pushd $ARCHIVEDIR
        PREFIX=/usr/arm-none-linux-gnueabi CHOST==${CROSSTARGET} CROSS_PREFIX==${CROSSTARGET}  ./configure  --prefix=/${DEVICEROOT} --host=${CROSSTARGET}
	$MAKE -j$MAKE_JOBS
	$MAKE install
popd
markbuilt
