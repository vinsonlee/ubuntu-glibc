-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Format: 3.0 (quilt)
Source: glibc
Binary: libc-bin, libc-dev-bin, glibc-doc, glibc-source, locales, locales-all, nscd, multiarch-support, libc6, libc6-dev, libc6-dbg, libc6-pic, libc6-udeb, libc6.1, libc6.1-dev, libc6.1-dbg, libc6.1-pic, libc6.1-udeb, libc0.3, libc0.3-dev, libc0.3-dbg, libc0.3-pic, libc0.3-udeb, libc0.1, libc0.1-dev, libc0.1-dbg, libc0.1-pic, libc0.1-udeb, libc6-i386, libc6-dev-i386, libc6-sparc, libc6-dev-sparc, libc6-sparc64, libc6-dev-sparc64, libc6-s390, libc6-dev-s390, libc6-amd64, libc6-dev-amd64, libc6-powerpc, libc6-dev-powerpc, libc6-ppc64, libc6-dev-ppc64, libc6-mips32, libc6-dev-mips32, libc6-mipsn32, libc6-dev-mipsn32, libc6-mips64, libc6-dev-mips64, libc0.1-i386, libc0.1-dev-i386, libc6-x32, libc6-dev-x32, libc6-i686, libc6-xen, libc0.1-i686, libc0.3-i686, libc0.3-xen, libc6.1-alphaev67, libc6-loongson2f, libnss-dns-udeb, libnss-files-udeb
Architecture: any all
Version: 2.19-15
Maintainer: GNU Libc Maintainers <debian-glibc@lists.debian.org>
Uploaders: Clint Adams <clint@debian.org>, Aurelien Jarno <aurel32@debian.org>, Adam Conrad <adconrad@0c3.net>
Homepage: http://www.gnu.org/software/libc/libc.html
Standards-Version: 3.9.5
Vcs-Browser: http://svn.debian.org/wsvn/pkg-glibc/glibc-package/
Vcs-Svn: svn://svn.debian.org/pkg-glibc/glibc-package/
Testsuite: autopkgtest
Build-Depends: gettext, dpkg-dev (>= 1.17.14), xz-utils, file, quilt, autoconf, gawk, debhelper (>= 9.20141010), rdfind, symlinks, netbase, linux-libc-dev (>= 3.9) [linux-any], libaudit-dev [linux-any], libcap-dev [linux-any], libselinux-dev [linux-any], mig (>= 1.4-2) [hurd-i386], hurd-dev (>= 1:0.5.git20140320~) [hurd-i386], gnumach-dev (>= 2:1.4+git20141109-1) [hurd-i386], kfreebsd-kernel-headers [kfreebsd-any], binutils (>= 2.21), g++-4.8 (>= 4.8.3-8), g++-4.8-multilib [amd64 i386 kfreebsd-amd64 mips mipsel mipsn32 mipsn32el mips64 mips64el powerpc ppc64 s390x sparc sparc64 x32]
Build-Depends-Indep: perl, po-debconf (>= 1.0)
Package-List:
 glibc-doc deb doc optional arch=all profile=!stage1
 glibc-source deb devel optional arch=all profile=!stage1
 libc-bin deb libs required arch=any profile=!stage1
 libc-dev-bin deb libdevel optional arch=any profile=!stage1
 libc0.1 deb libs required arch=kfreebsd-amd64,kfreebsd-i386 profile=!stage1
 libc0.1-dbg deb debug extra arch=kfreebsd-amd64,kfreebsd-i386 profile=!stage1
 libc0.1-dev deb libdevel optional arch=kfreebsd-amd64,kfreebsd-i386
 libc0.1-dev-i386 deb libdevel optional arch=kfreebsd-amd64 profile=!nobiarch
 libc0.1-i386 deb libs optional arch=kfreebsd-amd64 profile=!stage1,!nobiarch
 libc0.1-i686 deb libs extra arch=kfreebsd-i386 profile=!stage1
 libc0.1-pic deb libdevel optional arch=kfreebsd-amd64,kfreebsd-i386 profile=!stage1
 libc0.1-udeb udeb debian-installer extra arch=kfreebsd-amd64,kfreebsd-i386 profile=!stage1
 libc0.3 deb libs required arch=hurd-i386 profile=!stage1
 libc0.3-dbg deb debug extra arch=hurd-i386 profile=!stage1
 libc0.3-dev deb libdevel optional arch=hurd-i386
 libc0.3-i686 deb libs extra arch=hurd-i386 profile=!stage1
 libc0.3-pic deb libdevel optional arch=hurd-i386 profile=!stage1
 libc0.3-udeb udeb debian-installer extra arch=hurd-i386 profile=!stage1
 libc0.3-xen deb libs extra arch=hurd-i386 profile=!stage1
 libc6 deb libs required arch=amd64,arm,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32 profile=!stage1
 libc6-amd64 deb libs optional arch=i386,x32 profile=!stage1,!nobiarch
 libc6-dbg deb debug extra arch=amd64,arm,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32 profile=!stage1
 libc6-dev deb libdevel optional arch=amd64,arm,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32
 libc6-dev-amd64 deb libdevel optional arch=i386,x32 profile=!nobiarch
 libc6-dev-i386 deb libdevel optional arch=amd64,x32 profile=!nobiarch
 libc6-dev-mips32 deb libdevel optional arch=mipsn32,mipsn32el,mips64,mips64el profile=!nobiarch
 libc6-dev-mips64 deb libdevel optional arch=mips,mipsel,mipsn32,mipsn32el profile=!nobiarch
 libc6-dev-mipsn32 deb libdevel optional arch=mips,mipsel,mips64,mips64el profile=!nobiarch
 libc6-dev-powerpc deb libdevel optional arch=ppc64 profile=!nobiarch
 libc6-dev-ppc64 deb libdevel optional arch=powerpc profile=!nobiarch
 libc6-dev-s390 deb libdevel optional arch=s390x profile=!nobiarch
 libc6-dev-sparc deb libdevel optional arch=sparc64 profile=!nobiarch
 libc6-dev-sparc64 deb libdevel optional arch=sparc profile=!nobiarch
 libc6-dev-x32 deb libdevel optional arch=amd64,i386 profile=!nobiarch
 libc6-i386 deb libs optional arch=amd64,x32 profile=!stage1,!nobiarch
 libc6-i686 deb libs extra arch=i386 profile=!stage1
 libc6-loongson2f deb libs extra arch=mipsel profile=!stage1
 libc6-mips32 deb libs optional arch=mipsn32,mipsn32el,mips64,mips64el profile=!stage1,!nobiarch
 libc6-mips64 deb libs optional arch=mips,mipsel,mipsn32,mipsn32el profile=!stage1,!nobiarch
 libc6-mipsn32 deb libs optional arch=mips,mipsel,mips64,mips64el profile=!stage1,!nobiarch
 libc6-pic deb libdevel optional arch=amd64,arm,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32 profile=!stage1
 libc6-powerpc deb libs optional arch=ppc64 profile=!stage1,!nobiarch
 libc6-ppc64 deb libs optional arch=powerpc profile=!stage1,!nobiarch
 libc6-s390 deb libs optional arch=s390x profile=!stage1,!nobiarch
 libc6-sparc deb libs optional arch=sparc64 profile=!stage1,!nobiarch
 libc6-sparc64 deb libs optional arch=sparc profile=!stage1,!nobiarch
 libc6-udeb udeb debian-installer extra arch=amd64,arm,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32 profile=!stage1
 libc6-x32 deb libs optional arch=amd64,i386 profile=!stage1,!nobiarch
 libc6-xen deb libs extra arch=i386 profile=!stage1
 libc6.1 deb libs required arch=alpha profile=!stage1
 libc6.1-alphaev67 deb libs extra arch=alpha profile=!stage1
 libc6.1-dbg deb debug extra arch=alpha profile=!stage1
 libc6.1-dev deb libdevel optional arch=alpha
 libc6.1-pic deb libdevel optional arch=alpha profile=!stage1
 libc6.1-udeb udeb debian-installer extra arch=alpha profile=!stage1
 libnss-dns-udeb udeb debian-installer extra arch=any profile=!stage1
 libnss-files-udeb udeb debian-installer extra arch=any profile=!stage1
 locales deb localization standard arch=all profile=!stage1
 locales-all deb localization extra arch=any profile=!stage1
 multiarch-support deb libs required arch=any profile=!stage1
 nscd deb admin optional arch=any profile=!stage1
Checksums-Sha1:
 a3ec3b7d2a3a9eabbf9fba9a741ec3bcc5915074 12387008 glibc_2.19.orig.tar.xz
 8a51bc9c209b3adef5271e18d2b4a93867f3d622 1039604 glibc_2.19-15.debian.tar.xz
Checksums-Sha256:
 746e52bb4fc9b2f30bcd33d415172a40ab56c5fff6c494052d31b0795593cc60 12387008 glibc_2.19.orig.tar.xz
 96d9de5b3ae0ce86cb5711904de4ef8f09482a5d591bbf4da12d5d2cbc721204 1039604 glibc_2.19-15.debian.tar.xz
Files:
 64d4b33ed4f830f501d92925e9e36a05 12387008 glibc_2.19.orig.tar.xz
 bfa8b23dcc421e949661ea88087848dc 1039604 glibc_2.19-15.debian.tar.xz

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU14G+AAoJELqceAYd3YybeJAP/1IncUxk/y6l9KP6Ircwscg9
EXVvRbiBFfqUOz7nukjB6YhXoR5gAKHEKDeTaVAMCjNMtqz1HT53Ki11xjypF/oM
bS/i63b0vTeuTTTVR6DIa7tZ1oEmNVDNAOIZVAM31jydNP+2ohSw+U4k+Tu0QFIS
Nrlyqaa/wNrh1ibVHdPWAjH8C44xse2pDlYG6+K1fJJO2neqRrSMszLagEEMm9V7
9qXz2qw96JSoz79WKHyyWrhsQekvJBXrwtvWrrO0x1e3d7jMccx2YCfyWkt0lAHL
hyEIl4Gks4u3FKNT2i6m0ogpkVyKTRBg76rxzrTltgorO0c6Yscu0+7DwFGMLyIY
dbEQG9IPXZg8NZdEgD6ePDc+NkT/V6p9YyNJq5hPNF8JOFHLfc8wJu1w8G7wlrjv
kGyTrxIXXG/R0K1nUT+QghoQ5LFj8Z4efu2bB4QXSUKVLhiulJBK5cQTncuahZ8L
Fq3tUUyRrXgtnxe77sj0ecXrUFxsUJj9r/IObBSDIl3r4ub+SucofHqKnVSWrH0e
5dDKBOSik13rA1jl2/dyEwfyY6Ma4Rz42BsJ11q53B/gA0/bjG2Ps+yMP49c0A4E
/uXG2v3ICFjXtuiRnHbqv6fy/AyFc0Tgj0MWgI0yIC88hhjumTgPwHUEhFlioFxh
nUS3FQ4az+B7WQLbw5Ak
=VL2X
-----END PGP SIGNATURE-----
