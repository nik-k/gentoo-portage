# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-ICal/Data-ICal-0.160.0.ebuild,v 1.1 2011/08/31 13:04:59 tove Exp $

EAPI=4

MODULE_AUTHOR=ALEXMV
MODULE_VERSION=0.16
inherit perl-module

DESCRIPTION="Generates iCalendar (RFC 2445) calendar files"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/Class-Accessor
	dev-perl/class-returnvalue
	dev-perl/Text-vFile-asData"
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/Test-Warn
		dev-perl/Test-NoWarnings
		dev-perl/Test-LongString
	)"

SRC_TEST="do"

src_prepare() {
	sed -i "/^auto_install();/d" "${S}"/Makefile.PL || die
	perl-module_src_prepare
}
