#!/bin/bash
set -e -u
ARCHIVE=SDL_ttf-2.0.11.tar.gz
ARCHIVEDIR=SDL_ttf-2.0.11
. $KOBO_SCRIPT_DIR/build-common.sh

# configure uses this to decide if it's doing opengl... it's installed even if we don't want it
# (sdl is configured without... probably should fix make file in SDL0
[ -e /${DEVICEROOT}/include/SDL/SDL_opengl.h ] && rm /${DEVICEROOT}/include/SDL/SDL_opengl.h

pushd $ARCHIVEDIR
        CHOST=${CROSSTARGET} CROSS_PREFIX=${CROSSTARGET} SDL_CONFIG=/${DEVICEROOT}/bin/sdl-config ./configure  --prefix=/${DEVICEROOT}  --host=${CROSSTARGET} --disable-sdltest --with-freetype-prefix=/${DEVICEROOT}

	$MAKE -j$MAKE_JOBS
	$MAKE install
popd
markbuilt
