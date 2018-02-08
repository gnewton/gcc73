
BASE := /home/gnewton/install/foobar2o
GMPLIB := $(BASE)/lib/libgmp.so 
MPFRLIB:= $(BASE)/lib/libmpfr.so
MPCLIB:= $(BASE)/lib/libmpc.so
ISLLIB:= $(BASE)/lib/libisl.so
GCCBIN:= $(BASE)/bin/gcc

#all: download gmp mpfr mpc isl gcc
all: download $(GMPLIB) mpfr mpc isl gcc
	./build-gcc.sh

clean:
	-cd download; rm -rf gmp-6.1.2 mpfr-4.0.1 mpc-1.1.0 isl-0.18 gcc-7.3.0

gmp: $(GMPLIB)

mpfr: $(MPFRLIB)

mpc:$(MPCLIB)

isl: $(ISLLIB)

gcc: $(GCCBIN)

$(GMPLIB):
	./download.sh gmp; export BASE_PATH=$(BASE); cd download/gmp-6.1.2; export LD_LIBRARY_PATH=$(BASE)/lib:${LD_LIBRARY_PATH}; export LD_RUN_PATH=$(BASE)/lib:${LD_RUN_PATH}; export C_INCLUDE_PATH=$(BASE)/include:${C_INCLUDE_PATH}; ./configure --prefix=$(BASE); make; make check; make install

$(MPFRLIB):
	./download.sh mpfr; export LD_LIBRARY_PATH=$(BASE)/lib:${LD_LIBRARY_PATH}; export LD_RUN_PATH=$(BASE)/lib:${LD_RUN_PATH}; export C_INCLUDE_PATH=$(BASE)/include:${C_INCLUDE_PATH}; cd download/mpfr-4.0.1; ./configure --with-gmp-build=../gmp-6.1.2 --prefix=$(BASE); make; make install

$(MPCLIB): download/gmp-6.1.2 gmp mpfr 
	./download.sh mpc; cd download/mpc-1.1.0/; ./configure --prefix=$(BASE) --with-gmp-lib=$(BASE)/lib --with-gmp-include=$(BASE)/include; make; make install

download/gmp-6.1.2:
	./download.sh gmp

$(ISLLIB): gmp
	./download.sh isl; cd download/isl-0.18; ./configure --prefix=$(BASE)  --with-gmp-prefix=$(BASE); make; make install



$(GCCBIN): gmp mpfr mpc isl
	./download.sh gcc; cd download/gcc-7.3.0; ./configure --disable-multilib --prefix=$(BASE)/gcc --enable-languages=all --with-gmp=$(BASE) --with-mpfr=$(BASE) --with-mpc=$(BASE) --with-isl=$(BASE); unset LIBRARY_PATH CPATH C_INCLUDE_PATH PKG_CONFIG_PATH CPLUS_INCLUDE_PATH INCLUDE; export LD_LIBRARY_PATH=$BASE_PATH/lib; export LD_RUN_PATH=$BASE_PATH/lib; export C_INCLUDE_PATH=$BASE_PATH/include; make; make install
