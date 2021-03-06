# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/vzctl/vzctl-3.3-r2.ebuild,v 1.2 2013/01/03 21:02:59 pinkbyte Exp $

EAPI="4"

inherit bash-completion-r1 eutils udev toolchain-funcs

DESCRIPTION="OpenVZ ConTainers control utility"
HOMEPAGE="http://openvz.org/"
SRC_URI="http://download.openvz.org/utils/${PN}/${PV}/src/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	net-firewall/iptables
	sys-apps/ed
	sys-apps/iproute2
	sys-fs/vzquota
	<sys-cluster/ploop-1.5"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	# Set default OSTEMPLATE on gentoo added
	sed -e 's:=redhat-:=gentoo-:' -i etc/dists/default || die

	sed -i -e "s:/lib/udev:$(udev_get_udevdir):" src/lib/dev.c || die

	# Fix paths in initscript, wrt bug #444201
	epatch "${FILESDIR}/${PN}-initscript-paths.patch"
}

src_configure() {
	econf \
		--localstatedir=/var \
		--enable-udev \
		--enable-bashcomp \
		--enable-logrotate
}

src_install() {
	emake DESTDIR="${D}" udevdir="$(udev_get_udevdir)"/rules.d install install-gentoo

	# install the bash-completion script into the right location
	rm -rf "${ED}"/etc/bash_completion.d
	newbashcomp etc/bash_completion.d/vzctl.sh ${PN}

	# We need to keep some dirs
	keepdir /vz/{dump,lock,root,private,template/cache}
	keepdir /etc/vz/names /var/lib/vzctl/veip
}

pkg_postinst() {
	ewarn "To avoid loosing network to CTs on iface down/up, please, add the"
	ewarn "following code to /etc/conf.d/net:"
	ewarn " postup() {"
	ewarn "     /usr/sbin/vzifup-post \${IFACE}"
	ewarn " }"

	ewarn "Starting with 3.0.25 there is new vzeventd service to reboot CTs."
	ewarn "Please, drop /usr/share/vzctl/scripts/vpsnetclean and"
	ewarn "/usr/share/vzctl/scripts/vpsreboot from crontab and use"
	ewarn "/etc/init.d/vzeventd."
}
