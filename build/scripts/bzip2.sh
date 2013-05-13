#!/bin/bash
set -e -u
ARCHIVE=bzip2-1.0.6.tar.gz
ARCHIVEDIR=bzip2-1.0.6
. $KOBO_SCRIPT_DIR/build-common.sh

patch -p0 < $PATCHESDIR/bzip2-libraryonly.patch


pushd $ARCHIVEDIR
        CROSSPREFIX=arm-none-linux-gnueabi $MAKE
        $MAKE PREFIX=/${DEVICEROOT} install
	sudo $MAKE PREFIX=/usr/${CROSSTARGET} install
popd
markbuilt
