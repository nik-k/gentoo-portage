# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/leechcraft-deadlyrics/leechcraft-deadlyrics-0.5.90.ebuild,v 1.1 2012/12/25 16:58:13 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="Searches for song lyrics and displays them in LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}"
RDEPEND="${DEPEND}
		virtual/leechcraft-search-show
		virtual/leechcraft-downloader-http"
