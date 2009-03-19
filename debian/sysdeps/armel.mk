libc_add-ons = ports nptl $(add-ons)

# Build a VFP version as it greatly speeds up floating point math
GLIBC_PASSES += vfp
DEB_ARCH_REGULAR_PACKAGES += libc6-vfp
vfp_add-ons = ports nptl $(add-ons)
# not needed
#vfp_configure_target=arm-linux
vfp_extra_cflags = -mfpu=vfp -mfloat-abi=softfp
vfp_rtlddir = /lib
# could as well be /lib/tls/vfp but the armel port was always NPTL
vfp_slibdir = /lib/vfp
vfp_extra_config_options = $(extra_config_options) --disable-profile

