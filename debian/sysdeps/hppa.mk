# hppa64 needs symlink /usr/hppa64-linux/include to /usr/include
# (See: Bug#239020)  In future we may drop this file with supporting hppa64.

# The hppa testsuite is slow.  This compensates for it and lets the tests
# finish.
# Comment this out, because the signal just never seems to come...
# export TIMEOUTFACTOR=10

RUN_TESTSUITE = no

define libc6-dev_extra_pkg_install
mkdir -p debian/$(curpass)/usr
mkdir -p debian/$(curpass)/usr/hppa64-linux
mkdir -p debian/$(curpass)/usr/hppa64-linux-gnu
ln -sf /usr/include debian/$(curpass)/usr/hppa64-linux/include
ln -sf /usr/include debian/$(curpass)/usr/hppa64-linux-gnu/include
endef

libc_extra_config_options = $(extra_config_options) --without-tls --without-__thread

