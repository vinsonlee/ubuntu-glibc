#!/usr/bin/perl

# These get export by debian/sysdeps/depflags.mk
$DEB_HOST_GNU_SYSTEM = $ENV{'DEB_HOST_GNU_SYSTEM'};
$DEB_HOST_GNU_TYPE = $ENV{'DEB_HOST_GNU_TYPE'};
$libc = $ENV{'libc'};
$glibc = $ENV{'glibc'};
@deptypes = ('Depends', 'Replaces', 'Conflicts', 'Provides',
	     'Suggests');

# Let's make sure we are sane
if (!defined($DEB_HOST_GNU_SYSTEM) or !defined($DEB_HOST_GNU_TYPE) or
    !defined($libc) or !defined($glibc)) {
    die "Could not get all parameters";
}

@ARGV == 1 or die "Usage: depflags <type>";
$type = $ARGV[0];

# OS specific stuff
if ($DEB_HOST_GNU_SYSTEM eq "gnu") {
    push @{$libc_dev_c{'Depends'}}, ('gnumach-dev', 'hurd-dev');
    push @{$libc_dev_c{'Replaces'}}, 'glibc2-dev';
    push @{$libc_dev_c{'Conflicts'}}, 'glibc2-dev';
    push @{$libc_c{'Replaces'}}, 'glibc2';
    push @{$libc_c{'Conflicts'}}, 'glibc2';
    push @{$libc_c{'Depends'}}, 'hurd (>= 20010718-1)';
}
if ($DEB_HOST_GNU_SYSTEM eq "linux-gnu") {
    push @{$libc_c{'Suggests'}}, 'locales';
    push @{$libc_dev_c{'Recommends'}}, 'c-compiler';
    push @{$libc_dev_c{'Replaces'}}, ('man-db (<= 2.3.10-41)', 'gettext (<= 0.10.26-1)',
		'ppp (<= 2.2.0f-24)', 'libgdbmg1-dev (<= 1.7.3-24)');
    push @{$libc_dev_c{'Depends'}}, 'linux-kernel-headers';
}
if ($DEB_HOST_GNU_SYSTEM eq "kfreebsd-gnu") {
    push @{$libc_c{'Suggests'}}, 'locales';
    push @{$libc_c{'Replaces'}}, 'libc0.1-dev (<< 2.3.2.ds1-14)';
    push @{$libc_dev_c{'Recommends'}}, 'c-compiler';
    push @{$libc_dev_c{'Replaces'}}, 'kfreebsd-kernel-headers (<< 0.11)';
    push @{$libc_dev_c{'Depends'}}, 'kfreebsd-kernel-headers (>= 0.11)';
}

# ${glibc}-doc is suggested by $libc_c and $libc_dev_c.
push @{$libc_c{'Suggests'}}, "${glibc}-doc";
push @{$libc_dev_c{'Suggests'}}, "${glibc}-doc";
push @{$libc_dev_c{'Suggests'}}, "manpages-dev";

# nss-db is now seperate
push @{$libc_c{'Recommends'}}, 'libnss-db';

# tzdata is now separate
# In Ubuntu, it's a recommends.
push @{$libc_c{'Recommends'}}, 'tzdata';

# Old strace doesn't work with current libc6
push @{$libc_c{'Conflicts'}}, 'strace (<< 4.0-0)';

# 2.1.94 required a patch, applied in gcc -15, so c++ compiles will work again
push @{$libc_dev_c{'Conflicts'}}, 'libstdc++2.10-dev (<< 1:2.95.2-15)';

# 2.2.2+CVS requires a newer gcc. For non-i386, we just worry about the
# weak-sym patch, since on i386 we need an even newer one because of the
# pic-kludge that breaks libc_nonshared.a inclusion.
if ($DEB_HOST_GNU_TYPE =~ m/^i486-linux-gnu$/) {
    push @{$libc_dev_c{'Conflicts'}}, 'gcc-2.95 (<< 1:2.95.3-9)';
} else {
    push @{$libc_dev_c{'Conflicts'}}, 'gcc-2.95 (<< 1:2.95.3-8)';
}

# The db2 changes left libnss-db broken, except for the newer version
# which uses db3
push @{$libc_c{'Conflicts'}}, 'libnss-db (<= 2.2-6.1.1)';

# From now on we provide our own ldconfig and ldd, so we don't need ldso
push @{$libc_dev_c{'Replaces'}}, 'ldso (<= 1.9.11-9)';
push @{$libc_c{'Replaces'}}, 'ldso (<= 1.9.11-9)';

# Some old packages from glibc that don't get built, but need to be handled
push @{$libc_c{'Replaces'}}, ('timezone', 'timezones', 'gconv-modules',
	'libtricks');
push @{$libc_c{'Conflicts'}}, ('timezone', 'timezones', 'gconv-modules',
	'libtricks', "${libc}-doc");

# conflicts from libc5 days
if ($DEB_HOST_GNU_TYPE =~ m/^(i486|m68k)-linux-gnu$/) {
    push @{$libc_c{'Conflicts'}}, ('libc5 (<< 5.4.33-7)', 'libpthread0 (<< 0.7-10)');
} elsif ($DEB_HOST_GNU_TYPE eq 'sparc-linux-gnu') {
    push @{$libc_c{'Conflicts'}}, ('libc5 (<< 5.3.12-2)', 'libpthread0 (<< 0.7-10)');
}
if ($DEB_HOST_GNU_TYPE =~ m/^(alpha|i486|m68k|sparc)-linux-gnu$/) {
    push @{$libc_dev_c{'Conflicts'}}, ('libpthread0-dev', 'libdl1-dev',
	'libdb1-dev', 'libgdbm1-dev');
    # Add this here too, old package
    push @{$libc_c{'Conflicts'}}, ("${libc}-bin", 'libwcsmbs');
    push @{$libc_c{'Replaces'}}, "${libc}-bin";
}

# Old, Pre glibc 2.1
if ($DEB_HOST_GNU_TYPE =~ m/^(alpha|i486|m68k|sparc|powerpc|arm)-linux-gnu$/) {
    push @{$libc_dev_c{'Conflicts'}}, ("${libc}-dev (<< 2.0.110-1)",
	'locales (<< 2.1.3-5)');
}

# XXX: Not sure why this conflict is here, maybe broken c++?
if ($DEB_HOST_GNU_TYPE =~ m/^(i486|m68k|alpha)-linux-gnu$/) {
    push @{$libc_c{'Conflicts'}}, ('apt (<< 0.3.0)', 'libglib1.2 (<< 1.2.1-2)');
}

# Some old c++ libs
if ($DEB_HOST_GNU_TYPE =~ m/^(alpha|i486)-linux-gnu$/) {
    push @{$libc_dev_c{'Conflicts'}}, 'libstdc++2.9-dev';
} elsif ($DEB_HOST_GNU_TYPE eq "powerpc-linux-gnu") {
    push @{$libc_dev_c{'Conflicts'}}, ('libstdc++2.9 (<< 2.91.58-2.1)',
	'libstdc++2.8 (<< 2.90.29-1)');
} elsif ($DEB_HOST_GNU_TYPE eq "m68k-linux-gnu") {
    push @{$libc_dev_c{'Conflicts'}}, 'libstdc++2.9-dev';
}

# XXX: What is this!?
if ($DEB_HOST_GNU_TYPE eq "alpha-linux-gnu") {
    push @{$libc_dev_c{'Conflicts'}}, ('libncurses4-dev (<< 4.2-3.1)',
	'libreadlineg2-dev (<< 2.1-13.1)');
}

# Conflict/Replace netkit-rpc, and its manpages
push @{$libc_c{'Conflicts'}}, 'netkit-rpc';
push @{$libc_c{'Replaces'}}, 'netkit-rpc';
push @{$libc_dev_c{'Conflicts'}}, 'netkit-rpc';
push @{$libc_dev_c{'Replaces'}}, 'netkit-rpc';
push @{$libc_c{'Replaces'}}, 'netbase (<< 4.0)';
push @{$libc_dev_c{'Replaces'}}, 'netbase (<< 4.0)';

# Conflict old wine - didn't like NPTL
push @{$libc_c{'Conflicts'}}, 'wine (<< 0.0.20031118-1)';

# Conflict some packages because of bad errno handling
push @{$libc_c{'Conflicts'}}, 'cyrus-imapd (<< 1.5.19-15)';

# Conflict old gcc because they have /usr/hppa64-linux/include symlink
# (Bug#239020)
if ($DEB_HOST_GNU_TYPE eq "hppa-linux-gnu") {
    push @{$libc_dev_c{'Conflicts'}}, ('gcc-3.3-hppa64 (<= 1:3.3.3-6)',
	'gcc-3.4-hppa64 (<= 3.4-0pre4)');
}

# Replace kerberos4kth-dev (<< 1.2.2-10) for fixing #234347.
push @{$libc_dev_c{'Replaces'}}, 'kerberos4kth-dev (<< 1.2.2-10)';

# Replace libc-dev (<< 2.3.2.ds1-14) for fixing #239170.
# Replace libc-dev (<< 2.3.5-2) for fixing #280030.
push @{$libc_dev_c{'Replaces'}}, "${libc}-prof (<< 2.3.5-2)";

# Conflict e2fsprogs (<< 1.35-7) that cannot work with new ldd.
push @{$libc_c{'Conflicts'}}, 'e2fsprogs (<< 1.35-7)';

# Conflict old initrd-tools (<< 0.1.84.1) that cannot work with
# new libc.
push @{$libc_c{'Conflicts'}}, 'initrd-tools (<< 0.1.84.1)';

# Ubuntu hack until Dapper releases: Hard depend on locales to make sure
# # that timezones pieces get pulled in for upgrades
push @{$libc_c{'Depends'}}, 'locales (>= 2.3.11)';

# Ubuntu hack to cope with the fact that we shipped /lib64 and /usr/lib64
# in base-files for a while, and now they're in libc6, same as Debian
if ($DEB_HOST_GNU_TYPE eq "x86_64-linux-gnu") {
    push @{$libc_c{'Replaces'}}, 'base-files (<< 3.1.9ubuntu8)';
}

# Make sure we only have one version of libc-dev installed
push @{$libc_dev_c{'Provides'}}, 'libc-dev';
push @{$libc_dev_c{'Conflicts'}}, 'libc-dev';
if ($libc ne "libc6") {
    push @{$libc_dev_c{'Provides'}}, 'libc6-dev';
}

# Conflict with broken libterm-readline-gnu-perl to avoid #326856.
push @{$libc_c{'Conflicts'}}, 'libterm-readline-gnu-perl (<< 1.15-2)';

if ($type eq "libc") {
    %pkg = %libc_c;
} elsif ($type eq "libc_dev") {
    %pkg = %libc_dev_c;
} else {
    die "Unknown package $type";
}

foreach $dep (@deptypes) {
    next if not defined($pkg{$dep});
    print "-D${dep}=\"" . join(', ', @{$pkg{$dep}}) . "\" ";
}
