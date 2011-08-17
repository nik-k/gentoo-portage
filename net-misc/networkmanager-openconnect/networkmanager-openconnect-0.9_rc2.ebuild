# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/networkmanager-openconnect/networkmanager-openconnect-0.9_rc2.ebuild,v 1.1 2011/08/17 10:51:54 dagger Exp $

EAPI="4"
GNOME_TARBALL_SUFFIX="bz2"
GNOME_ORG_MODULE="NetworkManager-${PN##*-}"
GNOME_ORG_PVP="0.8"
REAL_PV="0.8.999"

inherit gnome.org

DESCRIPTION="NetworkManager OpenConnect plugin"
HOMEPAGE="http://www.gnome.org/projects/NetworkManager/"
# Replace our fake _rc version with the actual version
SRC_URI="${SRC_URI//${PV}/${REAL_PV}}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

RDEPEND="
	>=net-misc/networkmanager-${PV}
	>=dev-libs/dbus-glib-0.74
	net-misc/openconnect
	gnome? (
		>=x11-libs/gtk+-3.0.0:3
		gnome-base/gconf
		gnome-base/gnome-keyring
	)"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool
	dev-util/pkgconfig"

# Replace our fake _rc version with the actual version
S="${WORKDIR}/${GNOME_ORG_MODULE}-${REAL_PV}"

src_configure() {
	ECONF="--disable-more-warnings
		--disable-static
		--with-dist-version=Gentoo
		--with-gtkver=3.0
		$(use_with gnome)
		$(use_with gnome authdlg)"

	econf ${ECONF}
}

src_install() {
	default
	# Remove useless .la files
	find "${D}" -name '*.la' -exec rm -f {} +
}
