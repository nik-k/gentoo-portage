# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/clipgrab/clipgrab-3.2.0.9.ebuild,v 1.1 2012/10/06 19:59:58 xmw Exp $

EAPI=4

inherit qt4-r2 eutils

DESCRIPTION="Download from various internet video services like Youtube etc."
HOMEPAGE="http://clipgrab.de/en"
SRC_URI="http://${PN}.de/download/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-webkit:4"
RDEPEND="${DEPEND}
	virtual/ffmpeg"

PATCHES=(
	"${FILESDIR}/3.2.0.6-obey.patch"
)

src_install() {
	dobin ${PN}

	newicon icon.png ${PN}.png
	make_desktop_entry clipgrab Clipgrab "" "Qt;Video;AudioVideo;"
}
