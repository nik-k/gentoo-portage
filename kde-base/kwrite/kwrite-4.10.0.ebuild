# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kwrite/kwrite-4.10.0.ebuild,v 1.1 2013/02/07 04:57:49 alexxy Exp $

EAPI=5

KDE_HANDBOOK="optional"
KMNAME="kate"
KMEXTRACTONLY="doc/kate"
inherit kde4-meta

DESCRIPTION="KDE MDI editor/IDE"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep katepart)
"
