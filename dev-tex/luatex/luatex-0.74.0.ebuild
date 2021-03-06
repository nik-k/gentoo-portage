# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/luatex/luatex-0.74.0.ebuild,v 1.1 2013/01/15 21:21:20 aballier Exp $

EAPI=4

inherit libtool eutils texlive-common

MY_P=${PN}-beta-${PV}
DESCRIPTION="An extended version of pdfTeX using Lua as an embedded scripting language."
HOMEPAGE="http://www.luatex.org/"
SRC_URI="http://foundry.supelec.fr/gf/download/frsrelease/396/1876/${MY_P}-source.tar.bz2
	http://foundry.supelec.fr/gf/download/frsrelease/396/1878/${MY_P}-doc.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="doc"

RDEPEND="dev-libs/zziplib
	>=media-libs/libpng-1.4
	x11-libs/cairo
	x11-libs/pixman
	>=app-text/poppler-0.12.3-r3[xpdf-headers(+)]
	sys-libs/zlib
	>=dev-libs/kpathsea-6.0.1_p20110627"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MY_P}/source"

src_prepare() {
	epatch "${FILESDIR}/remove-zlib-version-check.patch" \
		"${FILESDIR}/includes.patch"
	S="${S}/build-aux" elibtoolize --shallow
}

src_configure() {
	# Too many regexps use A-Z a-z constructs, what causes problems with locales
	# that don't have the same alphabetical order than ascii. Bug #244619
	# So we set LC_ALL to C in order to avoid problems.
	export LC_ALL=C

	cd "${S}/texk/web2c"
	econf \
		--disable-cxx-runtime-hack \
		--disable-all-pkgs	\
		--disable-mp		\
		--disable-ptex		\
		--disable-tex		\
		--disable-mf		\
	    --disable-largefile \
		--disable-ipc		\
		--disable-shared	\
		--enable-luatex		\
		--enable-dump-share	\
		--without-mf-x-toolkit \
		--without-x			\
	    --with-system-kpathsea	\
	    --with-kpathsea-includes="${EPREFIX}"/usr/include \
		--with-system-cairo \
		--with-system-pixman \
	    --with-system-gd	\
	    --with-system-libpng	\
	    --with-system-teckit \
	    --with-system-zlib \
	    --with-system-t1lib \
		--with-system-xpdf \
		--with-system-poppler \
		--with-system-zziplib \
		--with-system-ptexenc \
	    --disable-multiplatform
}

src_compile() {
	texk/web2c/luatexdir/getluatexsvnversion.sh || die
	cd "${WORKDIR}/${MY_P}/source/texk/web2c"
	emake luatex
}

src_install() {
	cd "${WORKDIR}/${MY_P}/source/texk/web2c"
	emake DESTDIR="${D}" bin_PROGRAMS="luatex" SUBDIRS="" nodist_man_MANS="" \
		install-exec-am

	dodoc "${WORKDIR}/${MY_P}/README" luatexdir/NEWS
	cp source/texk/web2c/man
	cp man/luatex.man "${T}/luatex.1"
	doman "${T}/luatex.1"
	use doc && dodoc "${WORKDIR}/${MY_P}/manual/"*.pdf
}

pkg_postinst() {
	if ! has_version '>=dev-texlive/texlive-basic-2008' ; then
		elog "Note that this package does not install many files, mainly just the"
		elog "${PN} executable, which needs other files in order to be"
		elog "useful. Please consider installing a recent TeX distribution such as"
		elog "TeX Live 2008 or later to take advantage of the full power of"
		elog "${PN} ."
	fi
	efmtutil-sys
}
