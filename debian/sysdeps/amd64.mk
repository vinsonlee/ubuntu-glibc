GLIBC_PASSES += i386
DEB_ARCH_REGULAR_PACKAGES += libc6-i386 libc6-dev-i386

# build libc with nptl instead of linuxthreads
libc_MIN_KERNEL_SUPPORTED = 2.6.0
libc_add-ons = nptl $(add-ons)
libc_extra_cflags = -O3
libc_extra_config_options := $(extra_config_options) --with-tls --with-__thread

#i386lt_add-ons = linuxthreads $(add-ons)
#i386lt_configure_target=i486-linux
#i386lt_configure_build=i486-linux
#i386lt_CC = $(BUILD_CC) -m32
#i386lt_extra_cflags = -march=i486 -mtune=i486 -g2 -O3
#i386lt_LIBDIR = 32
#i386lt_MIN_KERNEL_SUPPORTED = 2.6.0
#i386lt_extra_config_options = $(extra_config_options) --disable-profile --with-tls --without-__thread --includedir=/usr/include/i386-linux-gnu

# This only looks like i386.  It's really i686, fine for compatability.
i386_add-ons = nptl $(add-ons)
i386_configure_target=i686-linux
i386_configure_build=i686-linux
i386_CC = $(BUILD_CC) -m32
i386_extra_cflags = -march=i686 -mtune=i686 -g2 -O3
i386_LIBDIR = 32
i386_MIN_KERNEL_SUPPORTED = 2.6.0
i386_extra_config_options = $(extra_config_options) --disable-profile --with-tls --with-__thread --includedir=/usr/include/i386-linux-gnu
libc6-i386_shlib_dep = libc6-i386 (>= $(shlib_dep_ver))

define libc6-i386_extra_pkg_install
mkdir -p debian/libc6-i386/lib
ln -s /lib32/ld-linux.so.2 debian/libc6-i386/lib/ld-linux.so.2
endef

define extra_debhelper
echo debian/tmp-i386/usr/include/i386-linux-gnu usr/include >>debian/libc6-dev-i386.install
endef

