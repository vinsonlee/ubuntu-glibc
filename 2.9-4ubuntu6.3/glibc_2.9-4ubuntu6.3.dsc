-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Format: 1.0
Source: glibc
Binary: glibc-doc, glibc-source, locales, locales-all, nscd, libc6, libc6-dev, libc6-dbg, libc6-prof, libc6-pic, libc6-udeb, libc6.1, libc6.1-dev, libc6.1-dbg, libc6.1-prof, libc6.1-pic, libc6.1-udeb, libc0.3, libc0.3-dev, libc0.3-dbg, libc0.3-prof, libc0.3-pic, libc0.3-udeb, libc0.1, libc0.1-dev, libc0.1-dbg, libc0.1-prof, libc0.1-pic, libc0.1-udeb, libc6-i386, libc6-dev-i386, libc6-sparc64, libc6-dev-sparc64, libc6-s390x, libc6-dev-s390x, libc6-amd64, libc6-dev-amd64, libc6-powerpc, libc6-dev-powerpc, libc6-ppc64, libc6-dev-ppc64, libc6-mipsn32, libc6-dev-mipsn32, libc6-mips64, libc6-dev-mips64, libc0.1-i386, libc0.1-dev-i386, libc6-sparcv9b, libc6-sparcv9v, libc6-sparcv9v2, libc6-sparc64b, libc6-sparc64v, libc6-sparc64v2, libc6-i686, libc6-xen, libc0.1-i686, libc6-vfp, libc6.1-alphaev67, libnss-dns-udeb, libnss-files-udeb
Architecture: any
Version: 2.9-4ubuntu6.3
Maintainer: Ubuntu Core developers <ubuntu-devel-discuss@lists.ubuntu.com>
Uploaders: Ben Collins <bcollins@debian.org>, GOTO Masanori <gotom@debian.org>, Philip Blundell <pb@nexus.co.uk>, Jeff Bailey <jbailey@raspberryginger.com>, Daniel Jacobowitz <dan@debian.org>, Clint Adams <schizo@debian.org>, Aurelien Jarno <aurel32@debian.org>, Pierre Habouzit <madcoder@debian.org>
Standards-Version: 3.8.0
Vcs-Bzr: http://bazaar.launchpad.net/~ubuntu-toolchain/ubuntu-toolchain/glibc-2.5-package
Build-Depends: gettext, make (>= 3.80), dpkg-dev (>= 1.14.17), bzip2, lzma, file, quilt, texinfo (>= 4.0), texi2html, autoconf, sed (>= 4.0.5-4), gawk, debhelper (>= 5.0), linux-libc-dev [!hurd-i386 !kfreebsd-i386 !kfreebsd-amd64], mig (>= 1.3-2) [hurd-i386], hurd-dev (>= 20080607-3) [hurd-i386], gnumach-dev [hurd-i386], libpthread-stubs0-dev [hurd-i386], kfreebsd-kernel-headers [kfreebsd-i386 kfreebsd-amd64], binutils (>= 2.19-0ubuntu3), g++-4.3 (>= 4.3.2-2ubuntu5) [!alpha !sparc], g++-4.3-multilib [amd64 i386 kfreebsd-amd64 mips mipsel powerpc ppc64 s390 sparc], g++-4.3 (>= 4.3.3-2) [alpha]
Build-Depends-Indep: perl, po-debconf (>= 1.0)
Checksums-Sha1: 
 4f7c5cb1327a1e56970707e6017f61464ead91d3 23036779 glibc_2.9.orig.tar.gz
 1d75e3f3ffa9ea4c99a198b50f5b4ac776505023 2684077 glibc_2.9-4ubuntu6.3.diff.gz
Checksums-Sha256: 
 5c2f63baea1ecdf647e477b9ff609bbe551eef5a3878f265d2cd9bd7fb7d041a 23036779 glibc_2.9.orig.tar.gz
 ad560dc626a892c6cb9f7d778030e81029d853f2da16c0649ee2ce19ce97d16f 2684077 glibc_2.9-4ubuntu6.3.diff.gz
Files: 
 926e90e50fe4f830575fef1c6a554768 23036779 glibc_2.9.orig.tar.gz
 3579c672c77eed5dbd0f43fca80ffa1b 2684077 glibc_2.9-4ubuntu6.3.diff.gz
Debian-Vcs-Browser: http://svn.debian.org/wsvn/pkg-glibc/glibc-package/
Debian-Vcs-Svn: svn://svn.debian.org/pkg-glibc/glibc-package/
Original-Maintainer: GNU Libc Maintainers <debian-glibc@lists.debian.org>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Kees Cook <kees@outflux.net>

iEYEARECAAYFAkzA1RMACgkQH/9LqRcGPm2gMwCfdQpUR7SPHNTuk5BPGGnvP7gU
wBQAn0TPl+5GU7VxWjS6mj3ShgT5NU82
=L+Ml
-----END PGP SIGNATURE-----
