# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/nomacs/nomacs-0.4.0.ebuild,v 1.1 2012/09/02 02:10:42 pesa Exp $

EAPI=4

#LANGS="als de en ru zh" TODO: translation handling

inherit cmake-utils

DESCRIPTION="Qt4-based image viewer"
HOMEPAGE="http://www.nomacs.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}-source.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="raw"

RDEPEND="
	>=media-gfx/exiv2-0.20[zlib]
	>=x11-libs/qt-core-4.7.0:4
	>=x11-libs/qt-gui-4.7.0:4
	raw? (
		>=media-libs/libraw-0.14
		>=media-libs/opencv-2.4.0[qt4]
	)"
DEPEND="${RDEPEND}
	app-arch/unzip
	virtual/pkgconfig
"

S=${WORKDIR}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable raw)
	)
	cmake-utils_src_configure
}
