# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/qtemu/qtemu-1.0.5.ebuild,v 1.5 2013/02/07 21:37:10 ulm Exp $

EAPI="2"

inherit eutils qt4-r2 cmake-utils

DESCRIPTION="A graphical user interface for QEMU written in Qt4."
HOMEPAGE="http://qtemu.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1 CC-BY-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}
	app-emulation/qemu"

DOCS="ChangeLog README"
PATCHES=(
	"${FILESDIR}/${PV}-help_and_translation_paths.patch"
)

src_install() {
	cmake-utils_src_install
	doicon "${S}/images/${PN}.ico"
	make_desktop_entry "qtemu" "QtEmu" "${PN}.ico" "Qt;Utility;Emulator"
}
