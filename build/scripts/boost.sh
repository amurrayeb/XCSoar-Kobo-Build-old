#!/bin/bash
set -e -u
ARCHIVE=boost_1_53_0.tar.bz2 
ARCHIVEDIR=boost_1_53_0
. $KOBO_SCRIPT_DIR/build-common.sh



pushd $ARCHIVEDIR
  ./bootstrap.sh --without-libraries=python
  echo "using gcc : arm : arm-none-linux-gnueabi-g++ : ;" >>  tools/build/v2/user-config.jam
  ./b2 
  ./b2 install --prefix=/${DEVICEROOT}
popd

markbuilt
