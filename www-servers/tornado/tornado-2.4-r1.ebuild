# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/tornado/tornado-2.4-r1.ebuild,v 1.2 2013/02/11 14:54:43 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_5,2_6,2_7} pypy{1_9,2_0} )

inherit distutils-r1

DESCRIPTION="Scalable, non-blocking web server and tools"
HOMEPAGE="http://www.tornadoweb.org/ http://pypi.python.org/pypi/tornado"
SRC_URI="http://github.com/downloads/facebook/tornado/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="curl"

RDEPEND="curl? ( dev-python/pycurl[$(python_gen_usedep python2*)] )
	python_targets_python2_5? (
		dev-python/simplejson[python_targets_python2_5] )"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

REQUIRED_USE="curl? ( $(python_gen_useflags python2*) )"

src_test() {
	# The test server tries to bind at an unused port but suffers
	# a race condition in it. Seems to be fixed already.
	# https://github.com/facebook/tornado/blob/master/tornado/test/process_test.py#L64
	local DISTUTILS_NO_PARALLEL_BUILD=1

	distutils-r1_src_test
}

python_test() {
	cd "${TMPDIR}" || die
	"${PYTHON}" -m tornado.test.runtests || die "Tests fail with ${EPYTHON}"
}
