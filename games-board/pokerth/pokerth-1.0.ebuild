# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/pokerth/pokerth-1.0.ebuild,v 1.2 2013/01/22 19:55:16 mr_bones_ Exp $

EAPI=5
inherit flag-o-matic eutils qt4-r2 games

MY_P="PokerTH-${PV}-src"
DESCRIPTION="Texas Hold'em poker game"
HOMEPAGE="http://www.pokerth.net/"
SRC_URI="mirror://sourceforge/pokerth/${MY_P}.tar.bz2"

LICENSE="AGPL-3 GPL-1 GPL-2 GPL-3 BitstreamVera public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="dedicated"

RDEPEND="dev-db/sqlite:3
	dev-libs/boost[threads(+)]
	dev-libs/protobuf
	dev-libs/libgcrypt
	dev-libs/tinyxml[stl]
	net-libs/libircclient
	>=net-misc/curl-7.16
	x11-libs/qt-core:4
	virtual/gsasl
	!dedicated? (
		media-libs/libsdl
		media-libs/sdl-mixer[mod,vorbis]
		x11-libs/qt-gui:4
	)"
DEPEND="${RDEPEND}
	!dedicated? ( x11-libs/qt-sql:4 )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	if use dedicated ; then
		sed -i \
			-e 's/pokerth_game.pro//' \
			pokerth.pro || die
	fi

	sed -i \
		-e '/no_dead_strip_inits_and_terms/d' \
		*pro || die

	epatch "${FILESDIR}"/${P}-underlinking.patch
}

src_configure() {
	eqmake4
}

src_install() {
	dogamesbin bin/pokerth_server
	if ! use dedicated ; then
		dogamesbin ${PN}
		insinto "${GAMES_DATADIR}/${PN}"
		doins -r data
		domenu ${PN}.desktop
		doicon ${PN}.png
	fi
	doman docs/pokerth.1
	dodoc ChangeLog TODO docs/{gui_styling,server_setup}_howto.txt
	prepgamesdirs
}
