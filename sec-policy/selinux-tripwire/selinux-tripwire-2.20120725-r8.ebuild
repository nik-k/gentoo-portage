# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sec-policy/selinux-tripwire/selinux-tripwire-2.20120725-r8.ebuild,v 1.2 2012/12/13 10:05:08 swift Exp $
EAPI="4"

IUSE=""
MODS="tripwire"
BASEPOL="2.20120725-r8"

inherit selinux-policy-2

DESCRIPTION="SELinux policy for tripwire"

KEYWORDS="amd64 x86"
