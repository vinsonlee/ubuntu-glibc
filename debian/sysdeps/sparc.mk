# NPTL Config
# GLIBC_PASSES += nptl

# build 64-bit (sparc64) alternative library
GLIBC_PASSES += sparc64
DEB_ARCH_REGULAR_PACKAGES += libc6-sparc64 libc6-dev-sparc64
sparc64_MIN_KERNEL_SUPPORTED = 2.6.0
sparc64_configure_target=sparc64-linux
sparc64_CC = $(BUILD_CC) -m64
sparc64_extra_cflags = -g1 -O3
sparc64_extra_config_options = $(extra_config_options) --disable-profile \
	--includedir=/usr/include/sparc64-linux-gnu
sparc64_add-ons = nptl $(add-ons)
libc6-sparc64_shlib_dep = libc6-sparc64 (>= $(shlib_dep_ver))
sparc64_slibdir = /lib64
sparc64_libdir = /usr/lib64

GLIBC_PASSES += sparc64b
DEB_ARCH_REGULAR_PACKAGES += libc6-sparc64b
sparc64b_MIN_KERNEL_SUPPORTED = 2.6.0
sparc64b_configure_build=sparc64-linux
sparc64b_configure_target=sparc64b-linux
sparc64b_CC = $(BUILD_CC) -m64 -mcpu=ultrasparc3
sparc64b_extra_cflags = -g2 -O3
sparc64b_extra_config_options = $(extra_config_options) --disable-profile
sparc64b_add-ons = nptl $(add-ons)
libc6-sparc64b_shlib_dep = libc6-sparc64b (>= $(shlib_dep_ver))
sparc64b_LIBDIR = 64/ultra3

GLIBC_PASSES += sparc64v
DEB_ARCH_REGULAR_PACKAGES += libc6-sparc64v
sparc64v_MIN_KERNEL_SUPPORTED = 2.6.0
sparc64v_configure_build=sparc64-linux
sparc64v_configure_target=sparc64v-linux
sparc64v_CC = $(BUILD_CC) -m64 -mcpu=niagara
sparc64v_extra_cflags = -g2 -O3
sparc64v_extra_config_options = $(extra_config_options) --disable-profile
sparc64v_add-ons = nptl $(add-ons)
libc6-sparc64v_shlib_dep = libc6-sparc64v (>= $(shlib_dep_ver))
sparc64v_LIBDIR = 64/v9v

# build a sparcv9 optimized library
#GLIBC_PASSES += sparcv9
#DEB_ARCH_REGULAR_PACKAGES += libc6-sparcv9
sparcv9_MIN_KERNEL_SUPPORTED = 2.6.0
sparcv9_configure_target=sparcv9-linux
sparcv9_configure_build=sparcv9-linux
sparcv9_extra_cflags = -g1 -O3
sparcv9_extra_config_options = $(extra_config_options) --disable-profile
sparcv9_add-ons = nptl $(add-ons)
sparcv9_rtlddir = /lib
sparcv9_slibdir = /lib/v9

# build a sparcv9b optimized library
GLIBC_PASSES += sparcv9b
DEB_ARCH_REGULAR_PACKAGES += libc6-sparcv9b
sparcv9b_MIN_KERNEL_SUPPORTED = 2.6.0
sparcv9b_configure_target=sparcv9b-linux
sparcv9b_configure_build=sparcv9b-linux
sparcv9b_extra_cflags = -mtune=ultrasparc3 -g1 -O3
sparcv9b_extra_config_options = $(extra_config_options) --disable-profile
sparcv9b_add-ons = nptl $(add-ons)
sparcv9b_rtlddir = /lib
sparcv9b_slibdir = /lib/ultra3

GLIBC_PASSES += sparcv9v
DEB_ARCH_REGULAR_PACKAGES += libc6-sparcv9v
sparcv9v_MIN_KERNEL_SUPPORTED = 2.6.0
sparcv9v_configure_target=sparcv9v-linux
sparcv9v_extra_cflags = -O3 -mtune=niagara
sparcv9v_extra_config_options = $(extra_config_options) --disable-profile --with-tls --with-__thread
sparcv9v_add-ons = nptl $(add-ons)
sparcv9v_LIBDIR = /v9v

define libc6-dev-sparc64_extra_pkg_install
mkdir -p debian/libc6-dev-sparc64/usr/include
cp -af debian/tmp-sparc64/usr/include/sparc64-linux-gnu \
        debian/libc6-dev-sparc64/usr/include
endef

