libc_add-ons = nptl $(add-ons)
libc_extra_cflags = -O3 -g
libc_slibdir = /lib
libc_libdir = /usr/lib
libc_rtlddir = /lib64

# /lib64 and /usr/lib64 are provided by glibc instead base-files: #259302.
define libc6_extra_pkg_install
ln -sf /lib debian/$(curpass)/lib64
ln -sf lib debian/$(curpass)/usr/lib64
endef

# build 32-bit (i386) alternative library
GLIBC_PASSES += i386
DEB_ARCH_REGULAR_PACKAGES += libc6-i386 libc6-dev-i386
libc6-i386_shlib_dep = libc6-i386 (>= $(shlib_dep_ver))

# This section is quite different in Ubuntu.
#
# This only looks like i386.  It's really i686, fine for compatability
i386_add-ons = nptl $(add-ons)
i386_configure_target = i686-linux
i386_CC = $(BUILD_CC) -m32
i386_CXX = $(BUILD_CXX) -m32
i386_MAKEFLAGS = MAKEFLAGS="gconvdir=/usr/lib32/gconv"
i386_extra_cflags = -march=i686 -mtune=generic -g -O3
i386_extra_config_options = $(extra_config_options) --disable-profile
i386_includedir = /usr/include/i486-linux-gnu
#i386_rtlddir = /lib
i386_slibdir = /lib32
i386_libdir = /usr/lib32

define libc6-dev-i386_extra_pkg_install
mkdir -p debian/libc6-dev-i386/usr/include
cp -af debian/tmp-i386/usr/include/i486-linux-gnu \
	debian/libc6-dev-i386/usr/include
endef

define libc6-i386_extra_pkg_install
mkdir -p debian/libc6-i386/lib
ln -s /lib32/ld-linux.so.2 debian/libc6-i386/lib/ld-linux.so.2
endef

