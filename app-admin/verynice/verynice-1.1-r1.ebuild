# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/verynice/verynice-1.1-r1.ebuild,v 1.1 2012/12/26 20:38:24 hasufell Exp $

EAPI=5

inherit eutils toolchain-funcs

DESCRIPTION="A tool for dynamically adjusting the nice-level of processes"
HOMEPAGE="http://thermal.cnde.iastate.edu/~sdh4/verynice/"
SRC_URI="http://thermal.cnde.iastate.edu/~sdh4/verynice/down/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
}

src_compile() {
	tc-export CC
	emake RPM_BUILD_ROOT="${D}" PREFIX=/usr
}

src_install(){
	emake RPM_BUILD_ROOT="${D}" PREFIX=/usr VERSION=${PVR} install
	doinitd "${FILESDIR}"/verynice
}
