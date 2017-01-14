-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Format: 1.0
Source: glibc
Version: 2.4-1ubuntu2
Binary: libnss-dns-udeb, nscd, libc0.1-prof, libc6-sparc64, libc6-dev-amd64, locales, libc0.3, libc6-udeb, libc6-i386, libc0.1-pic, libc0.1, libc6.1-dbg, libc6-sparc64v, libc6.1-udeb, libc6-s390x, libc0.3-dev, libc6-dev-ppc64, libc6-pic, libc0.1-udeb, libc6-sparcv9v, libc6-dev, locales-all, libc0.3-dbg, libc6-i686, libc0.1-i686, libc0.3-prof, libc6.1-pic, libc0.1-dbg, libc6-dev-i386, libc6-dbg, libc6-ppc64, libc6-sparcv9b, libc6.1-prof, libc6, libc6-xen, libc6-amd64, libc6-powerpc, libc6-dev-s390x, libc0.3-pic, libc6.1-dev, libc6-dev-powerpc, libc6-dev-sparc64, libc6.1, libc6-prof, libc0.1-dev, glibc-doc, libc0.3-udeb, libc6-sparc64b, libnss-files-udeb
Maintainer: GNU Libc Maintainers <debian-glibc@lists.debian.org>
Architecture: any
Standards-Version: 3.7.2
Build-Depends: gettext, make (>= 3.80-1), dpkg-dev (>= 1.13.5), bzip2, texinfo (>= 4.0), file,
 linux-kernel-headers (>= 2.6.11.2-0) [!hurd-i386 !kfreebsd-i386 !kfreebsd-amd64],
 mig (>= 1.3-2) [hurd-i386], hurd-dev (>= 20020608-1) [hurd-i386], gnumach-dev [hurd-i386], texi2html,
 kfreebsd-kernel-headers [kfreebsd-i386 kfreebsd-amd64],
 gcj-4.1, binutils (>= 2.16.1cvs20051109-1),
 autoconf, sed (>= 4.0.5-4), gawk, debhelper (>= 4.1.76),
 libc6-dev-amd64 [i386], libc6-dev-ppc64 [powerpc], libc6-dev-i386 [amd64], libc6-dev-powerpc [ppc64], libc6-dev-sparc64 [sparc], libc6-dev-s390x [s390],
 quilt
Build-Depends-Indep: perl, po-debconf
Uploaders: Ben Collins <bcollins@debian.org>, GOTO Masanori <gotom@debian.org>, Philip Blundell <pb@nexus.co.uk>, Jeff Bailey <jbailey@raspberryginger.com>, Daniel Jacobowitz <dan@debian.org>, Clint Adams <schizo@debian.org>, Denis Barbier <barbier@debian.org>, Aurelien Jarno <aurel32@debian.org>
Files: 
 f509f1b2b5d5cd9a9e128eb7b3e1583b 15193355 glibc_2.4.orig.tar.gz
 d7cc944a1351c6a2fb79879979497026 752775 glibc_2.4-1ubuntu2.diff.gz

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEh9dSvjztR8bOoMkRAsY3AKCAoQ/V0ls8X4JxqeomXfLIdLC7yQCggpw/
LFIkGGaB2HX8i3PVbGE5hjY=
=WYOP
-----END PGP SIGNATURE-----
