# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/leechcraft-laure/leechcraft-laure-0.5.90.ebuild,v 1.1 2012/12/25 16:40:07 maksbotan Exp $

EAPI="4"

inherit leechcraft

DESCRIPTION="VLC-based audio/video player for LeechCraft"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="~net-misc/leechcraft-core-${PV}
	sys-apps/file
	>=media-video/vlc-2.0.0"
RDEPEND="${DEPEND}"
