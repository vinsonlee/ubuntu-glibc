GLIBC_PASSES += sparcv9b sparcv9v sparc64 sparc64b sparc64v
DEB_ARCH_REGULAR_PACKAGES += libc6-sparc64 libc6-sparc64b libc6-sparc64v libc6-sparcv9b libc6-sparcv9v libc6-dev-sparc64
 
sparc64_MIN_KERNEL_SUPPORTED = 2.4.18
sparc64_configure_build=sparc64-linux
sparc64_configure_target=sparc64-linux
sparc64_CC = $(BUILD_CC) -m64 -mcpu=ultrasparc
sparc64_extra_cflags = -g2 -O3
sparc64_extra_config_options = $(extra_config_options) --disable-profile --without-tls --without-__thread
sparc64_add-ons = linuxthreads $(add-ons)
libc6-sparc64_shlib_dep = libc6-sparc64 (>= $(shlib_dep_ver))
sparc64_LIBDIR = 64
 
sparc64b_MIN_KERNEL_SUPPORTED = 2.6.0
sparc64b_configure_build=sparc64-linux
sparc64b_configure_target=sparc64b-linux
sparc64b_CC = $(BUILD_CC) -m64 -mcpu=ultrasparc3
sparc64b_extra_cflags = -g2 -O3
sparc64b_extra_config_options = $(extra_config_options) --disable-profile --without-tls --without-__thread
sparc64b_add-ons = linuxthreads $(add-ons)
libc6-sparc64b_shlib_dep = libc6-sparc64b (>= $(shlib_dep_ver))
sparc64b_LIBDIR = 64/v9b
 
sparc64v_MIN_KERNEL_SUPPORTED = 2.6.0
sparc64v_configure_build=sparc64-linux
sparc64v_configure_target=sparc64v-linux
sparc64v_CC = $(BUILD_CC) -m64 -mcpu=ultrasparc3
sparc64v_extra_cflags = -g2 -O3
sparc64v_extra_config_options = $(extra_config_options) --disable-profile --without-tls --without-__thread
sparc64v_add-ons = linuxthreads $(add-ons)
libc6-sparc64v_shlib_dep = libc6-sparc64v (>= $(shlib_dep_ver))
sparc64v_LIBDIR = 64/v9v
 
libc_MIN_KERNEL_SUPPORTED = 2.6.0
libc_add-ons = nptl $(add-ons)
libc_extra_config_options := $(extra_config_options) --with-tls --with-__thread
libc_extra_cflags = -O3
libc_configure_build=sparcv9-linux
libc_configure_target=sparcv9-linux

sparcv9b_MIN_KERNEL_SUPPORTED = 2.6.0
sparcv9b_configure_target=sparcv9b-linux
sparcv9b_extra_cflags = -O3 -mtune=ultrasparc3
sparcv9b_extra_config_options = $(extra_config_options) --disable-profile --with-tls --with-__thread
sparcv9b_add-ons = nptl $(add-ons)
sparcv9b_LIBDIR = /ultra3

sparcv9v_MIN_KERNEL_SUPPORTED = 2.6.0
sparcv9v_configure_target=sparcv9v-linux
sparcv9v_extra_cflags = -O3 -mtune=ultrasparc3
sparcv9v_extra_config_options = $(extra_config_options) --disable-profile --with-tls --with-__thread
sparcv9v_add-ons = nptl $(add-ons)
sparcv9v_LIBDIR = /v9v

