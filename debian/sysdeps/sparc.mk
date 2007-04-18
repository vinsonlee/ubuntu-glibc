# build 64-bit (sparc64) alternative library
GLIBC_PASSES += sparc64
DEB_ARCH_REGULAR_PACKAGES += libc6-sparc64 libc6-dev-sparc64
sparc64_add-ons = nptl $(add-ons)
sparc64_configure_target=sparc64-linux
sparc64_CC = $(BUILD_CC) -m64
sparc64_CXX = $(BUILD_CXX) -m64
sparc64_extra_cflags = -g -O3
libc6-sparc64_shlib_dep = libc6-sparc64 (>= $(shlib_dep_ver))
sparc64_slibdir = /lib64
sparc64_libdir = /usr/lib64
sparc64_extra_config_options = $(extra_config_options) --disable-profile \
	--includedir=/usr/include/sparc64-linux-gnu

define libc6-dev-sparc64_extra_pkg_install
mkdir -p debian/libc6-dev-sparc64/usr/include/gnu
cp -af debian/tmp-sparc64/usr/include/sparc64-linux-gnu/gnu/stubs-64.h \
        debian/libc6-dev-sparc64/usr/include/gnu
mkdir -p debian/libc6-dev-sparc64/usr/include/sparc64-linux-gnu
cp -af debian/tmp-sparc64/usr/include/* \
        debian/libc6-dev-sparc64/usr/include/sparc64-linux-gnu/
endef

GLIBC_PASSES += sparc64b
DEB_ARCH_REGULAR_PACKAGES += libc6-sparc64b
sparc64b_add-ons = nptl $(add-ons)
sparc64b_configure_build=sparc64-linux
sparc64b_configure_target=sparc64b-linux
sparc64b_CC = $(BUILD_CC) -m64 -mcpu=ultrasparc3
sparc64b_CXX = $(BUILD_CXX) -m64 -mcpu=ultrasparc3
sparc64b_extra_cflags = -g2 -O3
sparc64b_extra_config_options = $(extra_config_options) --disable-profile
libc6-sparc64b_shlib_dep = libc6-sparc64b (>= $(shlib_dep_ver))
sparc64b_slibdir = /lib64/ultra3

GLIBC_PASSES += sparc64v
DEB_ARCH_REGULAR_PACKAGES += libc6-sparc64v
sparc64v_add-ons = nptl $(add-ons)
sparc64v_configure_build=sparc64-linux
sparc64v_configure_target=sparc64v-linux
sparc64v_CC = $(BUILD_CC) -m64 -mcpu=niagara
sparc64v_CXX = $(BUILD_CXX) -m64 -mcpu=niagara
sparc64v_extra_cflags = -g2 -O3
sparc64v_extra_config_options = $(extra_config_options) --disable-profile
libc6-sparc64v_shlib_dep = libc6-sparc64v (>= $(shlib_dep_ver))
sparc64v_slibdir = /lib64/v9v

# build a sparcv9 optimized library
#GLIBC_PASSES += sparcv9
#DEB_ARCH_REGULAR_PACKAGES += libc6-sparcv9
sparcv9_add-ons = nptl $(add-ons)
sparcv9_configure_target=sparcv9-linux
sparcv9_configure_build=sparcv9-linux
sparcv9_extra_cflags = -g -O3
sparcv9_extra_config_options = $(extra_config_options) --disable-profile
sparcv9_rtlddir = /lib
sparcv9_slibdir = /lib/v9

# build a sparcv9b optimized library
GLIBC_PASSES += sparcv9b
DEB_ARCH_REGULAR_PACKAGES += libc6-sparcv9b
sparcv9b_add-ons = nptl $(add-ons)
sparcv9b_configure_target=sparcv9b-linux
sparcv9b_configure_build=sparcv9b-linux
sparcv9b_extra_cflags = -mtune=ultrasparc3 -g -O3
sparcv9b_extra_config_options = $(extra_config_options) --disable-profile
sparcv9b_rtlddir = /lib
sparcv9b_slibdir = /lib/ultra3

GLIBC_PASSES += sparcv9v
DEB_ARCH_REGULAR_PACKAGES += libc6-sparcv9v
sparcv9v_add-ons = nptl $(add-ons)
sparcv9v_configure_target=sparcv9v-linux
sparcv9v_extra_cflags = -O3 -mtune=niagara
sparcv9v_extra_config_options = $(extra_config_options) --disable-profile --with-tls --with-__thread
sparcv9v_rtlddir = /lib
sparcv9v_slibdir = /lib/v9v

