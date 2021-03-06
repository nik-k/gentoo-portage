# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/thunar-media-tags-plugin/thunar-media-tags-plugin-0.2.0.ebuild,v 1.4 2012/12/03 22:00:23 naota Exp $

EAPI=5
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Adds special features for media files to the Thunar File Manager"
HOMEPAGE="http://goodies.xfce.org/projects/thunar-plugins/thunar-media-tags-plugin"
SRC_URI="mirror://xfce/src/thunar-plugins/${PN}/${PV%.*}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="debug"

RDEPEND=">=media-libs/taglib-1.6
	>=x11-libs/gtk+-2.12:2
	>=xfce-base/exo-0.6
	>=xfce-base/thunar-1.2"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

pkg_setup() {
	PATCHES=( "${FILESDIR}"/${P}-linkorder.patch )

	XFCONF=(
		$(xfconf_use_debug)
		)

	DOCS=( AUTHORS ChangeLog NEWS README TODO )
}
