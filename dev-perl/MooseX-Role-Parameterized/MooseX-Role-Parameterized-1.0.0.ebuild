# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Role-Parameterized/MooseX-Role-Parameterized-1.0.0.ebuild,v 1.2 2013/01/13 12:55:21 maekke Exp $

EAPI=4

MODULE_AUTHOR=SARTAK
MODULE_VERSION=1.00
inherit perl-module

DESCRIPTION="Roles with composition parameters"

SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~x64-macos"
IUSE="test"

RDEPEND="
	>=dev-perl/Moose-2.30.0
"
DEPEND="
	${RDEPEND}
	test? (
		>=virtual/perl-Test-Simple-0.960.0
		dev-perl/Test-Fatal
	)
"
SRC_TEST="do"
