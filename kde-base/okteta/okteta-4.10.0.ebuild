# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/okteta/okteta-4.10.0.ebuild,v 1.1 2013/02/07 04:57:53 alexxy Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kdesdk"
KDE_SCM="svn"
inherit kde4-meta

DESCRIPTION="KDE hexeditor"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	app-crypt/qca:2
"
RDEPEND="${DEPEND}"

RESTRICT=test
# bug 443750

# bug #264917, removes failing test
PATCHES=( "${FILESDIR}/${PN}-4.8.2-test.patch" )
