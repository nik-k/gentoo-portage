# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/nodejs/nodejs-0.6.21-r1.ebuild,v 1.2 2013/01/15 06:31:57 zerochaos Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit python eutils pax-utils

# omgwtf
RESTRICT="test"

DESCRIPTION="Evented IO for V8 Javascript"
HOMEPAGE="http://nodejs.org/"
SRC_URI="http://nodejs.org/dist/v${PV}/node-v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~x64-macos"
IUSE=""

DEPEND=">=dev-lang/v8-3.6.6.24
	dev-libs/openssl"
RDEPEND="${DEPEND}"

S=${WORKDIR}/node-v${PV}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	sed -i -e "/flags = \['-arch', arch\]/s/= .*$/= ''/" wscript || die
}

src_configure() {
	# this is a waf confuserator
	./configure --shared-v8 --prefix="${EPREFIX}"/usr || die
}

src_compile() {
	emake || die
}

src_install() {
	docompress -x /lib/node_modules/npm/man
	emake DESTDIR="${D}" install || die
	pax-mark -m "${ED}"/usr/bin/node
}

src_test() {
	emake test || die
}
