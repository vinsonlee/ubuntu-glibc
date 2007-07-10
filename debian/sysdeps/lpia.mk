# We use -mno-tls-direct-seg-refs to not wrap-around segments, as it
# greatly reduce the speed when running under the Xen hypervisor.
# libc_extra_config_options = $(extra_config_options) --without-__thread --disable-sanity-checks
libc_extra_cflags = -mno-tls-direct-seg-refs

## FIXME: lpia; shouldn't be needed anymore.
# NPTL requires at least i486 assembly.  We don't need to take
# special measures for i386 systems, since Debian kernel images now
# emulate the missing instructions on the i386.
#nptl_configure_target=i686-linux
#nptl_configure_build=i686-linux
#nptl_extra_cflags = -march=i686 -mtune=i586 -g -O3
