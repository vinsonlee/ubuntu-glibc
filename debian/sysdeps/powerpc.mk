# needed for Ubuntu powerpc buildds
libc_MIN_KERNEL_SUPPORTED = 2.6.15

# build 64-bit (ppc64) alternative library
GLIBC_PASSES += ppc64
DEB_ARCH_REGULAR_PACKAGES += libc6-ppc64 libc6-dev-ppc64
ppc64_add-ons = nptl $(add-ons)
ppc64_configure_target = powerpc64-linux
ppc64_CC = $(CC) -m64 -fno-stack-protector -U_FORTIFY_SOURCE
ppc64_CXX = $(CXX) -m64 -fno-stack-protector -U_FORTIFY_SOURCE
libc6-ppc64_shlib_dep = libc6-ppc64 (>= $(shlib_dep_ver))
ppc64_extra_cflags = -O3
ppc64_extra_config_options := $(extra_config_options) --disable-profile
ppc64_slibdir = /lib64
ppc64_libdir = /usr/lib64
ppc64_includedir = /usr/include/powerpc64-linux-gnu

define libc6-dev-ppc64_extra_pkg_install
mkdir -p debian/libc6-dev-ppc64/usr/include/gnu
cp -af debian/tmp-ppc64/usr/include/powerpc64-linux-gnu/gnu/stubs-64.h \
        debian/libc6-dev-ppc64/usr/include/gnu
mkdir -p debian/libc6-dev-ppc64/usr/include/powerpc64-linux-gnu
endef

