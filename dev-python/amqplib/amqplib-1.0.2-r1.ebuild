# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/amqplib/amqplib-1.0.2-r1.ebuild,v 1.1 2013/01/19 20:13:07 mgorny Exp $

EAPI=5
PYTHON_COMPAT=( python{2_5,2_6,2_7,3_1,3_2,3_3} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Python client for the Advanced Message Queuing Procotol (AMQP)"
HOMEPAGE="http://code.google.com/p/py-amqplib/"
SRC_URI="http://py-amqplib.googlecode.com/files/${P}.tgz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples extras test"

PATCHES=(
	"${FILESDIR}/${PN}-0.6.1_disable_socket_tests.patch"
	"${FILESDIR}/${P}-unicode_tests_py3.patch"
)

python_test() {
	"${PYTHON}" tests/client_0_8/run_all.py \
		|| die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	distutils-r1_python_install_all

	dodoc -r docs/
	if use examples; then
		docinto examples
		dodoc -r demo/.
		docompress -x /usr/share/doc/${PF}/examples
	fi
	if use extras; then
		insinto /usr/share/${PF}
		doins -r extras
	fi
}
