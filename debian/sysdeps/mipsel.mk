#
# Temporary hack to use our own version of unistd.h
# to workaround kernel bugs on the build daemons
#
KERNEL_HEADER_DIR = $(stamp)mkincludedir-mips
$(stamp)mkincludedir-mips:
	rm -rf debian/include
	mkdir debian/include
	ln -s $(LINUX_HEADERS)/linux debian/include
	ln -s $(LINUX_HEADERS)/asm-generic debian/include
	cp -a $(LINUX_HEADERS)/asm debian/include
	cp -f debian/mips_asm_unistd.h debian/include/asm/unistd.h

	# To make configure happy if libc6-dev is not installed.
	touch debian/include/assert.h

	touch $@

libc_add-ons = ports nptl $(add-ons)

# build 32-bit (n32) alternative library
GLIBC_PASSES += mipsn32
DEB_ARCH_REGULAR_PACKAGES += libc6-mipsn32 libc6-dev-mipsn32
mipsn32_add-ons = ports nptl $(add-ons)
mipsn32_configure_target = mips32el-linux
mipsn32_CC = $(CC) -mabi=n32
mipsn32_CXX = $(CXX) -mabi=n32
libc6-mipsn32_shlib_dep = libc6-mipsn32 (>= $(shlib_dep_ver))
mipsn32_extra_cflags = -O3
mipsn32_slibdir = /lib32
mipsn32_libdir = /usr/lib32
mipsn32_extra_config_options := $(extra_config_options) --disable-profile

# build 64-bit alternative library
GLIBC_PASSES += mips64
DEB_ARCH_REGULAR_PACKAGES += libc6-mips64 libc6-dev-mips64
mips64_add-ons = ports nptl $(add-ons)
mips64_configure_target = mips64el-linux
mips64_CC = $(CC) -mabi=64
mips64_CXX = $(CXX) -mabi=64
libc6-mips64_shlib_dep = libc6-mips64 (>= $(shlib_dep_ver))
mips64_extra_cflags = -O3
mips64_slibdir = /lib64
mips64_libdir = /usr/lib64
mips64_extra_config_options := $(extra_config_options) --disable-profile

# Need to put a tri-arch aware version of ldd in the base package
define mipsn32_extra_install
cp debian/tmp-mipsn32/usr/bin/ldd debian/tmp-libc/usr/bin
endef
