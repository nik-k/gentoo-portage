# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Locale-Maketext-Simple/Locale-Maketext-Simple-0.210.0.ebuild,v 1.3 2012/05/20 12:19:04 tove Exp $

EAPI=2

MODULE_AUTHOR=JESSE
MODULE_VERSION=0.21
inherit perl-module

DESCRIPTION="Locale::Maketext::Simple - Simple interface to Locale::Maketext::Lexicon"

SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86 ~amd64-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

#RDEPEND=""
#DEPEND="test? ( dev-perl/locale-maketext-lexicon )"

SRC_TEST="do"
