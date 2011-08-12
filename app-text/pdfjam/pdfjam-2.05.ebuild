# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pdfjam/pdfjam-2.05.ebuild,v 1.8 2011/08/12 15:39:51 xarthisius Exp $

MY_PV=${PV/./}
DESCRIPTION="pdfnup, pdfjoin and pdf90"
HOMEPAGE="http://www.warwick.ac.uk/go/pdfjam"
SRC_URI="http://www.warwick.ac.uk/go/pdfjam/${PN}_${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ppc ppc64 ~s390 ~sh ~sparc x86"
IUSE=""
S=${WORKDIR}/${PN}

DEPEND="virtual/latex-base"
RDEPEND="${DEPEND}"

src_install() {
	dobin bin/* || die
	dodoc PDFjam-README.html || die
	doman man1/* || die
}
