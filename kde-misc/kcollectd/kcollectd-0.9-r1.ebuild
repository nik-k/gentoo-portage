# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kcollectd/kcollectd-0.9-r1.ebuild,v 1.1 2012/10/19 17:25:36 kensington Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Simple KDE-based live data viewer for collectd"
HOMEPAGE="http://www.forwiss.uni-passau.de/~berberic/Linux/kcollectd.html"
SRC_URI="http://www.forwiss.uni-passau.de/~berberic/Linux/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/boost
	net-analyzer/rrdtool"
RDEPEND="${DEPEND}
	|| ( app-admin/collectd[collectd_plugins_rrdtool] app-admin/collectd[collectd_plugins_rrdcached] )"

PATCHES=(
	"${FILESDIR}/${P}-boost.patch"
	"${FILESDIR}/${P}-cflags.patch"
	"${FILESDIR}/${P}-desktop.patch"
)
