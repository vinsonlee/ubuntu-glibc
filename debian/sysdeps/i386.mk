# We use -mno-tls-direct-seg-refs to not wrap-around segments, as it
# greatly reduce the speed when running under the Xen hypervisor.
# libc_extra_config_options = $(extra_config_options) --without-__thread --disable-sanity-checks
libc_extra_cflags = -mno-tls-direct-seg-refs

define libc6_extra_pkg_install
mkdir -p debian/$(curpass)/usr/lib
ln -sf /lib/i486-linux-gnu debian/$(curpass)/lib/i386-linux-gnu
ln -sf /usr/lib/i486-linux-gnu debian/$(curpass)/usr/lib/i386-linux-gnu
endef

# NPTL requires at least i486 assembly.  We don't need to take
# special measures for i386 systems, since Debian kernel images now
# emulate the missing instructions on the i386.
nptl_configure_target=i486-linux
nptl_configure_build=i486-linux
nptl_extra_cflags = -march=i486 -mtune=i686 -g1 -O3

# We use -march=i686 and glibc's i686 routines use cmov, so require it.
# A Debian-local glibc patch adds cmov to the search path.
# The optimized libraries also use NPTL!
GLIBC_PASSES += i686
DEB_ARCH_REGULAR_PACKAGES += libc6-i686
i686_add-ons = nptl $(add-ons)
i686_configure_target=i686-linux
i686_extra_cflags = -march=i686 -mtune=i686 -g1 -O3
i686_rtlddir = /lib
i686_slibdir = /lib/tls/i686/cmov
i686_extra_config_options = $(extra_config_options) --disable-profile

# We use -mno-tls-direct-seg-refs to not wrap-around segments, as it
# greatly increase the speed when running under the Xen hypervisor.
GLIBC_PASSES += xen
DEB_ARCH_REGULAR_PACKAGES += libc6-xen
xen_add-ons = nptl $(add-ons)
xen_configure_target=i686-linux
xen_extra_cflags = -march=i686 -mtune=i686 -g1 -O3 -mno-tls-direct-seg-refs
xen_rtlddir = /lib
xen_slibdir = /lib/tls/i686/nosegneg
xen_extra_config_options = $(extra_config_options) --disable-profile

define xen_extra_install
mkdir -p debian/libc6-xen/etc/ld.so.conf.d
echo '# This directive teaches ldconfig to search in nosegneg subdirectories' >  debian/libc6-xen/etc/ld.so.conf.d/xen.conf
echo '# and cache the DSOs there with extra bit 0 set in their hwcap match'   >> debian/libc6-xen/etc/ld.so.conf.d/xen.conf
echo '# fields. In Xen guest kernels, the vDSO tells the dynamic linker to'   >> debian/libc6-xen/etc/ld.so.conf.d/xen.conf
echo '# search in nosegneg subdirectories and to match this extra hwcap bit'  >> debian/libc6-xen/etc/ld.so.conf.d/xen.conf
echo '# in the ld.so.cache file.'                                             >> debian/libc6-xen/etc/ld.so.conf.d/xen.conf
echo 'hwcap 0 nosegneg'                                                       >> debian/libc6-xen/etc/ld.so.conf.d/xen.conf
endef

# build 64-bit (amd64) alternative library
GLIBC_PASSES += amd64
DEB_ARCH_REGULAR_PACKAGES += libc6-amd64 libc6-dev-amd64
libc6-amd64_shlib_dep = libc6-amd64 (>= $(shlib_dep_ver))
amd64_add-ons = nptl $(add-ons)
amd64_configure_target = x86_64-linux
# __x86_64__ is defined here because Makeconfig uses -undef and the
# /usr/include/asm wrappers need that symbol.
amd64_CC = $(CC) -m64 -D__x86_64__
amd64_CXX = $(CXX) -m64 -D__x86_64__
amd64_extra_cflags = -O3 -g1
amd64_extra_config_options = $(extra_config_options) --disable-profile \
	--includedir=/usr/include/x86_64-linux-gnu
amd64_slibdir = /lib64
amd64_libdir = /usr/lib64

define amd64_extra_install
cp debian/tmp-amd64/usr/bin/ldd debian/tmp-libc/usr/bin
endef

define libc6-dev_extra_pkg_install
mkdir -p debian/libc6-dev/usr/lib/xen
cp -af debian/tmp-xen/usr/lib/*.a \
	debian/libc6-dev/usr/lib/xen
endef

define libc6-dev-amd64_extra_pkg_install
mkdir -p debian/libc6-dev-amd64/usr/include
cp -af debian/tmp-amd64/usr/include/x86_64-linux-gnu \
	debian/libc6-dev-amd64/usr/include
endef
