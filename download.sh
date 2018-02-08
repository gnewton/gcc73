#!/usr/bin/env bash

# Author: Glen Newton
# Copyright 2018 Glen Newton

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace


if [ ! -d "download" ]; then
    mkdir download
fi
cd download
if [ "${1}" = "" ]; then
    echo ""
fi

case "${1}" in
    "gmp")
	echo "gmp"
	if [ ! -f "gmp-6.1.2.tar.xz" ]; then
	    wget https://gmplib.org/download/gmp/gmp-6.1.2.tar.xz
	fi
	if [ -d "gmp-6.1.2" ]; then
	    rm -rf gmp-6.1.2
	fi
	xzcat gmp-6.1.2.tar.xz|tar xf -
	;;


    "mpfr")
	if [ ! -f mpfr-4.0.1.tar.xz ]; then
	    wget http://www.mpfr.org/mpfr-4.0.1/mpfr-4.0.1.tar.xz
	fi
	if [ -d "mpfr-4.0.1" ]; then
	    rm -rf mpfr-4.0.1
	fi
	xzcat mpfr-4.0.1.tar.xz|tar xf -
	;;

    "mpc")
	if [ ! -f mpc-1.1.0.tar.gz ]; then
	    wget https://ftp.gnu.org/gnu/mpc/mpc-1.1.0.tar.gz
	fi
	if [ -d "mpc-1.1.0" ]; then
	    rm -rf mpc-1.1.0
	fi
	gunzip -c mpc-1.1.0.tar.gz |tar xf -
	;;

    "isl")
	if [ ! -f isl-0.18.tar.bz2 ]; then
	    wget https://gcc.gnu.org/pub/gcc/infrastructure/isl-0.18.tar.bz2
	fi
	if [ -d "isl-0.18" ]; then
	    rm -rf isl-0.18
	fi
	bunzip2 -c isl-0.18.tar.bz2 |tar xf -
	;;

    "gcc")
	if [ ! -f gcc-7.3.0.tar.xz ]; then
	    wget http://gcc.skazkaforyou.com/releases/gcc-7.3.0/gcc-7.3.0.tar.xz
	fi
	if [ -d "gcc-7.3.0" ]; then
	    rm -rf gcc-7.3.0
	fi
	xzcat gcc-7.3.0.tar.xz|tar xf -
	;;
    
    *)
        echo $"Usage: $0 {start|stop|restart|condrestart|status}"
        exit 1
	
esac

cd ..

