-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Format: 3.0 (quilt)
Source: glibc
Binary: libc-bin, libc-dev-bin, libc-l10n, glibc-doc, glibc-source, locales, locales-all, nscd, multiarch-support, libc6, libc6-dev, libc6-dbg, libc6-pic, libc6-udeb, libc6.1, libc6.1-dev, libc6.1-dbg, libc6.1-pic, libc6.1-udeb, libc0.3, libc0.3-dev, libc0.3-dbg, libc0.3-pic, libc0.3-udeb, libc0.1, libc0.1-dev, libc0.1-dbg, libc0.1-pic, libc0.1-udeb, libc6-i386, libc6-dev-i386, libc6-sparc, libc6-dev-sparc, libc6-sparc64, libc6-dev-sparc64, libc6-s390, libc6-dev-s390, libc6-amd64, libc6-dev-amd64, libc6-powerpc, libc6-dev-powerpc, libc6-ppc64, libc6-dev-ppc64, libc6-mips32, libc6-dev-mips32, libc6-mipsn32, libc6-dev-mipsn32, libc6-mips64, libc6-dev-mips64, libc0.1-i386, libc0.1-dev-i386, libc6-x32, libc6-dev-x32, libc6-i686, libc6-xen, libc0.1-i686, libc6.1-alphaev67
Architecture: any all
Version: 2.22-7
Maintainer: GNU Libc Maintainers <debian-glibc@lists.debian.org>
Uploaders: Clint Adams <clint@debian.org>, Aurelien Jarno <aurel32@debian.org>, Adam Conrad <adconrad@0c3.net>, Samuel Thibault <sthibault@debian.org>
Homepage: http://www.gnu.org/software/libc/libc.html
Standards-Version: 3.9.7
Vcs-Browser: https://anonscm.debian.org/cgit/pkg-glibc/glibc.git
Vcs-Git: https://anonscm.debian.org/git/pkg-glibc/glibc.git
Testsuite: autopkgtest
Build-Depends: gettext, dpkg-dev (>= 1.17.14), xz-utils, file, quilt, autoconf, gawk, debhelper (>= 9.20141010), rdfind, symlinks, netbase, linux-libc-dev (>= 3.9) [linux-any], libaudit-dev [linux-any], libcap-dev [linux-any], libselinux-dev [linux-any], mig (>= 1.5-3) [hurd-i386], gnumach-dev (>= 2:1.4+git20141109~) [hurd-i386], hurd-dev (>= 1:0.5.git20140320~) [hurd-i386] | hurd-headers-dev [hurd-i386], hurd-dev (>= 1:0.5.git20140320~) [hurd-i386] <!stage1> | libihash-dev [hurd-i386] <!stage1>, kfreebsd-kernel-headers [kfreebsd-any], binutils (>= 2.21), g++-5, g++-5-multilib [amd64 i386 kfreebsd-amd64 mips mipsel mipsn32 mipsn32el mips64 mips64el powerpc ppc64 s390x sparc sparc64 x32], libc-bin (>= 2.22) <cross>
Build-Depends-Indep: perl, po-debconf (>= 1.0)
Package-List:
 glibc-doc deb doc optional arch=all profile=!stage1
 glibc-source deb devel optional arch=all profile=!stage1
 libc-bin deb libs required arch=any profile=!stage1 essential=yes
 libc-dev-bin deb libdevel optional arch=any profile=!stage1
 libc-l10n deb localization standard arch=all profile=!stage1
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
 libc0.3-pic deb libdevel optional arch=hurd-i386 profile=!stage1
 libc0.3-udeb udeb debian-installer extra arch=hurd-i386 profile=!stage1
 libc6 deb libs required arch=amd64,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,nios2,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32 profile=!stage1
 libc6-amd64 deb libs optional arch=i386,x32 profile=!stage1,!nobiarch
 libc6-dbg deb debug extra arch=amd64,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,nios2,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32 profile=!stage1
 libc6-dev deb libdevel optional arch=amd64,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,nios2,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32
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
 libc6-mips32 deb libs optional arch=mipsn32,mipsn32el,mips64,mips64el profile=!stage1,!nobiarch
 libc6-mips64 deb libs optional arch=mips,mipsel,mipsn32,mipsn32el profile=!stage1,!nobiarch
 libc6-mipsn32 deb libs optional arch=mips,mipsel,mips64,mips64el profile=!stage1,!nobiarch
 libc6-pic deb libdevel optional arch=amd64,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,nios2,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32 profile=!stage1
 libc6-powerpc deb libs optional arch=ppc64 profile=!stage1,!nobiarch
 libc6-ppc64 deb libs optional arch=powerpc profile=!stage1,!nobiarch
 libc6-s390 deb libs optional arch=s390x profile=!stage1,!nobiarch
 libc6-sparc deb libs optional arch=sparc64 profile=!stage1,!nobiarch
 libc6-sparc64 deb libs optional arch=sparc profile=!stage1,!nobiarch
 libc6-udeb udeb debian-installer extra arch=amd64,arm64,armel,armhf,hppa,i386,m68k,mips,mipsel,mipsn32,mipsn32el,mips64,mips64el,nios2,powerpc,powerpcspe,ppc64,ppc64el,sparc,sparc64,s390x,sh4,x32 profile=!stage1
 libc6-x32 deb libs optional arch=amd64,i386 profile=!stage1,!nobiarch
 libc6-xen deb libs extra arch=i386 profile=!stage1
 libc6.1 deb libs required arch=alpha profile=!stage1
 libc6.1-alphaev67 deb libs extra arch=alpha profile=!stage1
 libc6.1-dbg deb debug extra arch=alpha profile=!stage1
 libc6.1-dev deb libdevel optional arch=alpha
 libc6.1-pic deb libdevel optional arch=alpha profile=!stage1
 libc6.1-udeb udeb debian-installer extra arch=alpha profile=!stage1
 locales deb localization standard arch=all profile=!stage1
 locales-all deb localization extra arch=any profile=!stage1
 multiarch-support deb libs required arch=any profile=!stage1
 nscd deb admin optional arch=any profile=!stage1
Checksums-Sha1:
 111574a1e8b145dca12bc9b6563c738e1a9c9a9f 13311992 glibc_2.22.orig.tar.xz
 13f71a6e9b803d416e2459e4c711420ecef12a6f 1025140 glibc_2.22-7.debian.tar.xz
Checksums-Sha256:
 d4f9c3f0d33f2833a39232b1038a1619ba7cda3779765b9b8af94a555c6f6ba8 13311992 glibc_2.22.orig.tar.xz
 60ffb9bb0c51a55b3f2cf2cc945a6b07a52ae268d60d4228d93d7c78ea94e928 1025140 glibc_2.22-7.debian.tar.xz
Files:
 a68b5bcc317e4d221661c1416f6f59ce 13311992 glibc_2.22.orig.tar.xz
 769ca1118250a419b4084e6f2f6c2aec 1025140 glibc_2.22-7.debian.tar.xz

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXFin9AAoJEPs9hU7TiF8YwfcP/igfD4xBf476F5XdxieWYpWw
dHCc/mR/M+LzkZMVn7G0Vq7BWKnMnQHOCrx9G0+cnBy37u8E0HRplfNHcz3mBSuE
8GqYze4sUDtRdR/89Mf81lmzlyDSPCAbqMeraacrR4LTzFir1aSHGRndy54JiNEg
OpDeUOrlsDj+onvfafip7OBt3uhU7a8w+Owr/aRCWOr5pjMJDCNr7AqmsawM+9Bx
h5jGbluVOrEHuoh7GpeP3epIx1ojnrgv/Dia4tg7dCopsvLHGG+FWju9mY4ERSR5
2bPM4Jv3mbXvyLUCP5lDDzSNT9D3qARmCdW1K6FMccOpsI9wtKIVKWOhiB/Qpnpl
WW5RSp5D+vz75qIpD8aKwVEvuSfzh35CblEtkFS9Xq+Nmmn5cfoBntZwhOtl5v09
WGXz4M0pMVAhOtIY+1tSwCQD66yKweBTuXRgpnZaj2VvCBr0No3o4XpL70z0vRia
7+Z7dHRNfdXM5mbMZSNHR1PmyFcLwk0caU4xffdlzZEy9Y7uotfF8T5AuG0u5iSs
dJmNQvhn/0jyZBW9ps3cCVRV7f5u50FBLI43ipMm4plcK/36lrrnJuQ+2TQrCy9h
CspbOBvm4iSb5QdpBb68T++IPDbXJG6TN+5T0cDKP2EECAGOzHxA+G9xjj0jU9z6
R21OingXGMEDdYXL5KCK
=UwvL
-----END PGP SIGNATURE-----
