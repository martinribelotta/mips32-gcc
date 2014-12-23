#!/bin/sh

CT_NG_URL=https://github.com/crosstool-ng/crosstool-ng/archive
CT_NG_VER=1.20.0
CT_NG_TAR=crosstool-ng-crosstool-ng-$CT_NG_VER.tar.gz
CT_NG_DIR=crosstool-ng-crosstool-ng-$CT_NG_VER

if [ ! -f $CT_NG_TAR ]; then
	wget -O $CT_NG_TAR $CT_NG_URL/$CT_NG_TAR
fi

if [ ! -d $CT_NG_DIR ]; then
	tar -xf $CT_NG_TAR
fi

if [ ! -x $CT_NG_DIR/ct-ng ]; then
	cd $CT_NG_DIR
	./bootstrap && ./configure --enable-local && make
	cd ..
fi

if [ ! -f $CT_NG_DIR/.config ]; then
	cp pic32mz_defconfig $CT_NG_DIR/.config
fi

cd $CT_NG_DIR
./ct-ng build
