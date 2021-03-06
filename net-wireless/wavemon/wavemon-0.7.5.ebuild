# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wavemon/wavemon-0.7.5.ebuild,v 1.10 2012/12/30 14:23:09 ago Exp $

EAPI="4"

AUTOTOOLS_AUTORECONF=1
AUTOTOOLS_IN_SOURCE_BUILD=1

inherit autotools-utils

DESCRIPTION="Ncurses based monitor for IEEE 802.11 wireless LAN cards"
HOMEPAGE="http://eden-feed.erg.abdn.ac.uk/wavemon/"
SRC_URI="http://eden-feed.erg.abdn.ac.uk/wavemon/stable-releases/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~arm hppa ppc sparc x86"

IUSE="caps"
DEPEND="sys-libs/ncurses
	caps? ( sys-libs/libcap )"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS ChangeLog NEWS README THANKS )
PATCHES=( "${FILESDIR}/${PN}-0.6.7-dont-override-CFLAGS.patch" )

src_prepare() {
	# Do not install docs to /usr/share
	sed -i -e '/^install:/s/install-docs//' Makefile.in || die 'sed on Makefile.in failed'

	# automagic on libcap, discovered in bug #448406
	use caps || export ac_cv_lib_cap_cap_get_flag=false

	autotools-utils_src_prepare
}

src_install() {
	autotools-utils_src_install
	# Install man files manually(bug #397807)
	doman wavemon.1
	doman wavemonrc.5
}
