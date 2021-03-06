# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/bzr-git/bzr-git-0.6.8.ebuild,v 1.1 2012/10/08 19:50:04 fauli Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils

DESCRIPTION="Support for Git branches in Bazaar"
HOMEPAGE="http://bazaar-vcs.org/BzrForeignBranches/Git"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"

if [[ ${PV} = 9999 ]]; then
	inherit bzr
	EBZR_REPO_URI="lp:bzr-git"
	KEYWORDS=""
else
	SRC_URI="http://samba.org/~jelmer/bzr/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

IUSE=""
# Test are broken, they want API functions from Dulwich which are not
# installed in Gentoo
RESTRICT="test"

# Check info.py for dulwich and bzr version dependency info.
# The file should be fairly straightforward to understand.
DEPEND=""
RDEPEND=">=dev-python/dulwich-0.8.2
	>=dev-vcs/bzr-2.5.0"
