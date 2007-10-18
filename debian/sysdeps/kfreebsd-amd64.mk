libc_slibdir = /lib
libc_libdir = /usr/lib
libc_rtlddir = /lib

# /lib64 and /usr/lib64 are provided by glibc instead base-files: #259302.
define libc0.1_extra_pkg_install
ln -sf /lib debian/$(curpass)/lib64
ln -sf lib debian/$(curpass)/usr/lib64
endef

# build 32-bit (i386) alternative library
GLIBC_PASSES += i386
DEB_ARCH_REGULAR_PACKAGES += libc0.1-i386 libc0.1-dev-i386
libc0.1-i386_shlib_dep = libc0.1-i386 (>= $(shlib_dep_ver))

i386_configure_target = i486-kfreebsd
i386_CC = $(CC) -m32
i386_CXX = $(CXX) -m32
i386_add-ons = ports linuxthreads $(add-ons)
i386_extra_cflags = -march=pentium4 -g -O3
i386_extra_config_options = $(extra_config_options) --disable-compatible-utmp
i386_includedir = /usr/include/i486-kfreebsd-gnu
i386_rtlddir = /lib
i386_slibdir = /lib32
i386_libdir = /usr/lib32
i386_MIN_KERNEL_SUPPORTED = 5.4.0

define libc0.1-dev-i386_extra_pkg_install
mkdir -p debian/libc0.1-dev-i386/usr/include
cp -af debian/tmp-i386/usr/include/i486-kfreebsd-gnu \
	debian/libc0.1-dev-i386/usr/include
endef

define libc0.1-i386_extra_pkg_install
mkdir -p debian/libc0.1-i386/lib
ln -sf /lib32/ld.so.1 debian/libc0.1-i386/lib
ln -sf /lib32 debian/libc0.1-i386/lib32
endef
