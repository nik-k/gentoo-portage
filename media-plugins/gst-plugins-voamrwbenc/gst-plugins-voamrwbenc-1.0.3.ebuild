# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-voamrwbenc/gst-plugins-voamrwbenc-1.0.3.ebuild,v 1.1 2012/12/05 08:04:30 eva Exp $

EAPI="5"

inherit gst-plugins-bad

DESCRIPTION="GStreamer plugin for encoding AMR-WB"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=media-libs/vo-amrwbenc-0.1"
DEPEND="${RDEPEND}"
