-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Format: 3.0 (quilt)
Source: glibc
Binary: libc-bin, libc-dev-bin, glibc-doc, glibc-source, locales, locales-all, nscd, multiarch-support, libc6, libc6-dev, libc6-dbg, libc6-prof, libc6-pic, libc6-udeb, libc6.1, libc6.1-dev, libc6.1-dbg, libc6.1-prof, libc6.1-pic, libc6.1-udeb, libc0.3, libc0.3-dev, libc0.3-dbg, libc0.3-prof, libc0.3-pic, libc0.3-udeb, libc0.1, libc0.1-dev, libc0.1-dbg, libc0.1-prof, libc0.1-pic, libc0.1-udeb, libc6-i386, libc6-dev-i386, libc6-sparc, libc6-dev-sparc, libc6-sparc64, libc6-dev-sparc64, libc6-s390, libc6-dev-s390, libc6-amd64, libc6-dev-amd64, libc6-powerpc, libc6-dev-powerpc, libc6-ppc64, libc6-dev-ppc64, libc6-mips32, libc6-dev-mips32, libc6-mipsn32, libc6-dev-mipsn32, libc6-mips64, libc6-dev-mips64, libc6-armhf, libc6-dev-armhf, libc6-armel, libc6-dev-armel, libc0.1-i386, libc0.1-dev-i386, libc6-x32, libc6-dev-x32, libc6-i686, libc6-xen, libc0.1-i686, libc0.3-i686, libc0.3-xen, libc6.1-alphaev67, libc6-loongson2f, libnss-dns-udeb, libnss-files-udeb
Architecture: any all
Version: 2.19-3experimental0
Maintainer: GNU Libc Maintainers <debian-glibc@lists.debian.org>
Uploaders: Clint Adams <clint@debian.org>, Aurelien Jarno <aurel32@debian.org>, Adam Conrad <adconrad@0c3.net>
Homepage: http://www.gnu.org/software/libc/libc.html
Standards-Version: 3.9.5
Vcs-Browser: http://svn.debian.org/wsvn/pkg-glibc/glibc-package/
Vcs-Svn: svn://svn.debian.org/pkg-glibc/glibc-package/
Testsuite: autopkgtest
Build-Depends: gettext, dpkg-dev (>= 1.16.0), xz-utils, file, quilt, autoconf, gawk, debhelper (>= 7.4.3), rdfind, symlinks, netbase, linux-libc-dev (>= 3.9) [linux-any], libaudit-dev [linux-any], libcap-dev [linux-any], libselinux-dev [linux-any], systemtap-sdt-dev [linux-any], mig (>= 1.3-2) [hurd-i386], hurd-dev (>= 1:0.5.git20140320~) [hurd-i386], gnumach-dev (>= 2:1.4-2~) [hurd-i386], kfreebsd-kernel-headers [kfreebsd-any], binutils (>= 2.21), g++-4.8, g++-4.8-multilib [amd64 i386 kfreebsd-amd64 mips mipsel mipsn32 mipsn32el mips64 mips64el powerpc ppc64 s390x sparc sparc64 x32]
Build-Depends-Indep: perl, po-debconf (>= 1.0)
Package-List:
 glibc-doc deb doc optional arch=all
 glibc-source deb devel optional arch=all
 libc-bin deb libs required arch=any
 libc-dev-bin deb libdevel optional arch=any
 libc0.1 deb libs required arch=kfreebsd-amd64,kfreebsd-i386
 libc0.1-dbg deb debug extra arch=kfreebsd-amd64,kfreebsd-i386
 libc0.1-dev deb libdevel optional arch=kfreebsd-amd64,kfreebsd-i386
 libc0.1-dev-i386 deb libdevel optional arch=kfreebsd-amd64
 libc0.1-i386 deb libs optional arch=kfreebsd-amd64
 libc0.1-i686 deb libs extra arch=kfreebsd-i386
 libc0.1-pic deb libdevel optional arch=kfreebsd-amd64,kfreebsd-i386
 libc0.1-prof deb libdevel extra arch=kfreebsd-amd64,kfreebsd-i386
 libc0.1-udeb udeb debian-installer extra arch=kfreebsd-amd64,kfreebsd-i386
 libc0.3 deb libs required arch=hurd-i386
 libc0.3-dbg deb debug extra arch=hurd-i386
 libc0.3-dev deb libdevel optional arch=hurd-i386
 libc0.3-i686 deb libs extra arch=hurd-i386
 libc0.3-pic deb libdevel optional arch=hurd-i386
 libc0.3-prof deb libdevel extra arch=hurd-i386
 libc0.3-udeb udeb debian-installer extra arch=hurd-i386
 libc0.3-xen deb libs extra arch=hurd-i386
 libc6 deb libs required arch=amd64,arm,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32
 libc6-amd64 deb libs optional arch=i386,x32
 libc6-armel deb libs optional arch=armhf
 libc6-armhf deb libs optional arch=armel
 libc6-dbg deb debug extra arch=amd64,arm,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32
 libc6-dev deb libdevel optional arch=amd64,arm,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32
 libc6-dev-amd64 deb libdevel optional arch=i386,x32
 libc6-dev-armel deb libdevel optional arch=armhf
 libc6-dev-armhf deb libdevel optional arch=armel
 libc6-dev-i386 deb libdevel optional arch=amd64,x32
 libc6-dev-mips32 deb libdevel optional arch=mipsn32,mipsn32el,mips64,mips64el
 libc6-dev-mips64 deb libdevel optional arch=mips,mipsel,mipsn32,mipsn32el
 libc6-dev-mipsn32 deb libdevel optional arch=mips,mipsel,mips64,mips64el
 libc6-dev-powerpc deb libdevel optional arch=ppc64
 libc6-dev-ppc64 deb libdevel optional arch=powerpc
 libc6-dev-s390 deb libdevel optional arch=s390x
 libc6-dev-sparc deb libdevel optional arch=sparc64
 libc6-dev-sparc64 deb libdevel optional arch=sparc
 libc6-dev-x32 deb libdevel optional arch=amd64,i386
 libc6-i386 deb libs optional arch=amd64,x32
 libc6-i686 deb libs extra arch=i386
 libc6-loongson2f deb libs extra arch=mipsel
 libc6-mips32 deb libs optional arch=mipsn32,mipsn32el,mips64,mips64el
 libc6-mips64 deb libs optional arch=mips,mipsel,mipsn32,mipsn32el
 libc6-mipsn32 deb libs optional arch=mips,mipsel,mips64,mips64el
 libc6-pic deb libdevel optional arch=amd64,arm,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32
 libc6-powerpc deb libs optional arch=ppc64
 libc6-ppc64 deb libs optional arch=powerpc
 libc6-prof deb libdevel extra arch=amd64,arm,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32
 libc6-s390 deb libs optional arch=s390x
 libc6-sparc deb libs optional arch=sparc64
 libc6-sparc64 deb libs optional arch=sparc
 libc6-udeb udeb debian-installer extra arch=amd64,arm,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32
 libc6-x32 deb libs optional arch=amd64,i386
 libc6-xen deb libs extra arch=i386
 libc6.1 deb libs required arch=alpha,ia64
 libc6.1-alphaev67 deb libs extra arch=alpha
 libc6.1-dbg deb debug extra arch=alpha,ia64
 libc6.1-dev deb libdevel optional arch=alpha,ia64
 libc6.1-pic deb libdevel optional arch=alpha,ia64
 libc6.1-prof deb libdevel extra arch=alpha,ia64
 libc6.1-udeb udeb debian-installer extra arch=alpha,ia64
 libnss-dns-udeb udeb debian-installer extra arch=any
 libnss-files-udeb udeb debian-installer extra arch=any
 locales deb localization standard arch=all
 locales-all deb localization extra arch=any
 multiarch-support deb libs required arch=any
 nscd deb admin optional arch=any
Checksums-Sha1:
 a3ec3b7d2a3a9eabbf9fba9a741ec3bcc5915074 12387008 glibc_2.19.orig.tar.xz
 6eb5aa681a98bfe1524651dba9a7c140adc7ca35 991664 glibc_2.19-3experimental0.debian.tar.xz
Checksums-Sha256:
 746e52bb4fc9b2f30bcd33d415172a40ab56c5fff6c494052d31b0795593cc60 12387008 glibc_2.19.orig.tar.xz
 7a94c623c6cbeb4055cc8b21ddfdbda7be14236edf7bb61b87c49e29068e099d 991664 glibc_2.19-3experimental0.debian.tar.xz
Files:
 64d4b33ed4f830f501d92925e9e36a05 12387008 glibc_2.19.orig.tar.xz
 4c4c6d654d7c89f8ac001597aa75551b 991664 glibc_2.19-3experimental0.debian.tar.xz

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBU6HeubqceAYd3YybAQhZpw/9EJcgLdk83GgtnPhObYsnIzUFx3TWufCb
GZ4oaBKMo7OENOnA7coEDQsoMQjx0xwU2Ug9rAIc6Er/gRX1IgcX2bvDcTVI23YF
xSS02Z3B6ud0tejfm7TQpCuOc76rB9U9OrCwh+2vAQADABLiZkL/K4PS1T4zAEC9
W79Ej3Mhz8gYT7D2T9X1HCtYG+chKeTx7qRIOCDT+XF8kC8pA5jw2WMJWRTMdF4M
frY2XmS+ElSLWNDHYfl2UBOV3F62DBlEpywlNDj2VxyKzMqczxQjg/ngcdZ46N2i
nOTCWugOMxHGRgz79QXDyr8mZSEvfLUX3gc0fqb4sya1IkJtEq/ZWNkCvhGmewD3
/XbjGG4cWUTUYxJa+A1H3T8oU95jfM+mtG4DKpBg+IitFsOYhFAv/DjjE7PU1YiY
idyIcFg/qzfYK8KbrbIk1jeUGR0733ssXi32kH5d23YHnrQW1s1iL0TwF0u1cm2U
6qSjEwtfzK5uHnm8A6dQRSCfHh+ykiTRZcl9LuJluUuah5XOI4qhArJk3Pjk8gIV
/+HUmz6ARciGsQcVQNEDB/raT15kAAJtSG9WahXV6/a9m+MwW/2nXk/oASuxkuy8
Rdo6htgc7vxPRHLesPcSU4LJ9Z8rfHSENkgZZr0K6QFenMbbWA00xtUTVZSh/go5
VhyHvEfvXmA=
=c8+8
-----END PGP SIGNATURE-----
