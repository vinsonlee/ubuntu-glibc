-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Format: 3.0 (quilt)
Source: glibc
Binary: libc-bin, libc-dev-bin, glibc-doc, glibc-source, locales, locales-all, nscd, multiarch-support, libc6, libc6-dev, libc6-dbg, libc6-prof, libc6-pic, libc6-udeb, libc6.1, libc6.1-dev, libc6.1-dbg, libc6.1-prof, libc6.1-pic, libc6.1-udeb, libc0.3, libc0.3-dev, libc0.3-dbg, libc0.3-prof, libc0.3-pic, libc0.3-udeb, libc0.1, libc0.1-dev, libc0.1-dbg, libc0.1-prof, libc0.1-pic, libc0.1-udeb, libc6-i386, libc6-dev-i386, libc6-sparc, libc6-dev-sparc, libc6-sparc64, libc6-dev-sparc64, libc6-s390, libc6-dev-s390, libc6-amd64, libc6-dev-amd64, libc6-powerpc, libc6-dev-powerpc, libc6-ppc64, libc6-dev-ppc64, libc6-mips32, libc6-dev-mips32, libc6-mipsn32, libc6-dev-mipsn32, libc6-mips64, libc6-dev-mips64, libc6-armhf, libc6-dev-armhf, libc6-armel, libc6-dev-armel, libc0.1-i386, libc0.1-dev-i386, libc6-x32, libc6-dev-x32, libc6-i686, libc6-xen, libc0.1-i686, libc0.3-i686, libc0.3-xen, libc6.1-alphaev67, libc6-loongson2f, libnss-dns-udeb, libnss-files-udeb
Architecture: any all
Version: 2.19-10ubuntu2.2
Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
Uploaders: Clint Adams <clint@debian.org>, Aurelien Jarno <aurel32@debian.org>, Adam Conrad <adconrad@0c3.net>
Homepage: http://www.gnu.org/software/libc/libc.html
Standards-Version: 3.9.5
Vcs-Browser: http://svn.debian.org/wsvn/pkg-glibc/glibc-package/
Vcs-Svn: svn://svn.debian.org/pkg-glibc/glibc-package/
Build-Depends: gettext, dpkg-dev (>= 1.17.1), xz-utils, file, quilt, autoconf, gawk, debhelper (>= 7.4.3), rdfind, symlinks, netbase, linux-libc-dev (>= 3.9) [linux-any], libaudit-dev [linux-any], libcap-dev [linux-any], libselinux-dev [linux-any], systemtap-sdt-dev [linux-any], mig (>= 1.3-2) [hurd-i386], hurd-dev (>= 1:0.5.git20140320~) [hurd-i386], gnumach-dev (>= 2:1.4-2~) [hurd-i386], kfreebsd-kernel-headers [kfreebsd-any], binutils (>= 2.21), g++-4.8 (>= 4.8.3-8), g++-4.8-multilib [amd64 armhf armel i386 kfreebsd-amd64 mips mipsel mipsn32 mipsn32el mips64 mips64el powerpc ppc64 s390x sparc sparc64 x32]
Build-Depends-Indep: perl, po-debconf (>= 1.0)
Package-List: 
 glibc-doc deb doc optional
 glibc-source deb devel optional
 libc-bin deb libs required
 libc-dev-bin deb libdevel optional
 libc0.1 deb libs required
 libc0.1-dbg deb debug extra
 libc0.1-dev deb libdevel optional
 libc0.1-dev-i386 deb libdevel optional
 libc0.1-i386 deb libs optional
 libc0.1-i686 deb libs extra
 libc0.1-pic deb libdevel optional
 libc0.1-prof deb libdevel extra
 libc0.1-udeb udeb debian-installer extra
 libc0.3 deb libs required
 libc0.3-dbg deb debug extra
 libc0.3-dev deb libdevel optional
 libc0.3-i686 deb libs extra
 libc0.3-pic deb libdevel optional
 libc0.3-prof deb libdevel extra
 libc0.3-udeb udeb debian-installer extra
 libc0.3-xen deb libs extra
 libc6 deb libs required
 libc6-amd64 deb libs optional
 libc6-armel deb libs optional
 libc6-armhf deb libs optional
 libc6-dbg deb debug extra
 libc6-dev deb libdevel optional
 libc6-dev-amd64 deb libdevel optional
 libc6-dev-armel deb libdevel optional
 libc6-dev-armhf deb libdevel optional
 libc6-dev-i386 deb libdevel optional
 libc6-dev-mips32 deb libdevel optional
 libc6-dev-mips64 deb libdevel optional
 libc6-dev-mipsn32 deb libdevel optional
 libc6-dev-powerpc deb libdevel optional
 libc6-dev-ppc64 deb libdevel optional
 libc6-dev-s390 deb libdevel optional
 libc6-dev-sparc deb libdevel optional
 libc6-dev-sparc64 deb libdevel optional
 libc6-dev-x32 deb libdevel optional
 libc6-i386 deb libs optional
 libc6-i686 deb libs extra
 libc6-loongson2f deb libs extra
 libc6-mips32 deb libs optional
 libc6-mips64 deb libs optional
 libc6-mipsn32 deb libs optional
 libc6-pic deb libdevel optional
 libc6-powerpc deb libs optional
 libc6-ppc64 deb libs optional
 libc6-prof deb libdevel extra
 libc6-s390 deb libs optional
 libc6-sparc deb libs optional
 libc6-sparc64 deb libs optional
 libc6-udeb udeb debian-installer extra
 libc6-x32 deb libs optional
 libc6-xen deb libs extra
 libc6.1 deb libs required
 libc6.1-alphaev67 deb libs extra
 libc6.1-dbg deb debug extra
 libc6.1-dev deb libdevel optional
 libc6.1-pic deb libdevel optional
 libc6.1-prof deb libdevel extra
 libc6.1-udeb udeb debian-installer extra
 libnss-dns-udeb udeb debian-installer extra
 libnss-files-udeb udeb debian-installer extra
 locales deb localization standard
 locales-all deb localization extra
 multiarch-support deb libs required
 nscd deb admin optional
Checksums-Sha1: 
 a3ec3b7d2a3a9eabbf9fba9a741ec3bcc5915074 12387008 glibc_2.19.orig.tar.xz
 ae388d7a568a3fd0ee6a8052101339c6bde5c39c 1162572 glibc_2.19-10ubuntu2.2.debian.tar.xz
Checksums-Sha256: 
 746e52bb4fc9b2f30bcd33d415172a40ab56c5fff6c494052d31b0795593cc60 12387008 glibc_2.19.orig.tar.xz
 8330e620b91ad6ca92807202971f2d2b283482584ab032b7f2ed8335ef45e568 1162572 glibc_2.19-10ubuntu2.2.debian.tar.xz
Files: 
 64d4b33ed4f830f501d92925e9e36a05 12387008 glibc_2.19.orig.tar.xz
 02336c109e11c2f4a6b2a1d25540bc51 1162572 glibc_2.19-10ubuntu2.2.debian.tar.xz
Original-Maintainer: GNU Libc Maintainers <debian-glibc@lists.debian.org>
Testsuite: autopkgtest

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQEcBAEBAgAGBQJUgIgzAAoJEPNFAiJniEz2tWsIAIaTw1ODeelIZy8z0+No5ztS
ytLgyjnHEdpyw4JWxOuIxn1DWyTQxUgOb80DwPGB5F1aycCl8w+imr5XwE/KVLIt
rLZo32kSOfngOQ77kWYLa8DlguiRnSNBMpPUIgE4NkVP7ucYBgeQ3CFT7FWVrn8L
Y3wdgQ3xEF2MpaZUxjTjR7eyedMPcQhVxkjPd3JTPL54G0fDGsFJGN9bMmhhIVNz
FCW+F79t6zYUXVQAr+uY8G1BdgcEX7qiX1MVdptqMmLXHsUmR7uurm9hV6YdwKNK
bY2h/mU/NwxrOkoGI5eBjBvj7PqfQOuDA8mD6NQFVCCMK1X0l/0dqxXPjq+Msgc=
=13yk
-----END PGP SIGNATURE-----
