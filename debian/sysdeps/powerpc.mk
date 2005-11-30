DEB_ARCH_REGULAR_PACKAGES += libc6-ppc64 libc6-dev-ppc64

GLIBC_PASSES += ppc64
MIN_KERNEL_SUPPORTED = 2.6.0

libc_add-ons = nptl $(add-ons)
libc_extra_config_options := $(extra_config_options) --with-tls --with-__thread
libc_extra_cflags = -O3

ppc64_configure_target=powerpc64-linux
ppc64_CC = $(BUILD_CC) -m64
ppc64_extra_cflags = -O3
ppc64_extra_config_options = $(extra_config_options) --disable-profile
ppc64_add-ons = nptl $(add-ons)
libc6-ppc64_shlib_dep = libc6-ppc64 (>= $(shlib_dep_ver))
ppc64_LIBDIR = 64

