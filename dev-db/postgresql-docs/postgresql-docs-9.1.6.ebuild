# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/postgresql-docs/postgresql-docs-9.1.6.ebuild,v 1.5 2012/12/01 19:02:59 armin76 Exp $

EAPI="4"

inherit versionator

KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~ppc-macos ~x86-solaris"

SLOT="$(get_version_component_range 1-2)"
S="${WORKDIR}/postgresql-${PV}"

DESCRIPTION="PostgreSQL documentation"
HOMEPAGE="http://www.postgresql.org/"
SRC_URI="mirror://postgresql/source/v${PV}/postgresql-${PV}.tar.bz2"
LICENSE="POSTGRESQL"

IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	tar xjf "${DISTDIR}/${A}" -C "${WORKDIR}" "${A%.tar.bz2}/doc"
}

src_install() {
	dodir /usr/share/doc/${PF}/html

	cd "${S}/doc"

	docinto sgml
	dodoc src/sgml/*.{sgml,dsl}

	docinto sgml/ref
	dodoc src/sgml/ref/*.sgml

	docinto html
	dodoc src/sgml/html/*.html
	dodoc src/sgml/html/stylesheet.css

	docinto
	dodoc TODO

	dodir /etc/eselect/postgresql/slots/${SLOT}
	echo "postgres_ebuilds=\"\${postgres_ebuilds} ${PF}\"" > \
		"${ED}/etc/eselect/postgresql/slots/${SLOT}/docs"
}
