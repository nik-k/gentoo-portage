# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/snd/snd-12.4.ebuild,v 1.1 2011/08/30 08:23:15 radhermit Exp $

EAPI=4

inherit multilib flag-o-matic autotools

DESCRIPTION="Snd is a sound editor"
HOMEPAGE="http://ccrma.stanford.edu/software/snd/"
SRC_URI="ftp://ccrma-ftp.stanford.edu/pub/Lisp/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-interix ~amd64-linux ~x86-linux"
IUSE="alsa doc esd fam fftw gmp gsl gtk jack ladspa motif opengl oss portaudio pulseaudio readline ruby +s7"

RDEPEND="media-libs/audiofile
	alsa? ( media-libs/alsa-lib )
	esd? ( media-sound/esound )
	fam? ( virtual/fam )
	fftw? ( sci-libs/fftw )
	gmp? ( dev-libs/gmp
		dev-libs/mpc
		dev-libs/mpfr )
	gsl? ( sci-libs/gsl )
	gtk? ( x11-libs/gtk+:3
		x11-libs/pango
		x11-libs/cairo
		opengl? ( x11-libs/gtkglext ) )
	jack? ( media-sound/jack-audio-connection-kit )
	ladspa? ( media-libs/ladspa-sdk )
	motif? ( >=x11-libs/openmotif-2.3:0 )
	opengl? ( virtual/opengl )
	portaudio? ( media-libs/portaudio )
	pulseaudio? ( media-sound/pulseaudio )
	readline? ( sys-libs/readline )
	ruby? ( dev-lang/ruby )"

REQUIRED_USE="^^ (
		( !ruby !s7 )
		( ruby !s7 )
		( !ruby s7 )
	)"

pkg_setup() {
	if ! use gtk && ! use motif; then
		ewarn "Warning: no graphic toolkit selected (gtk or motif)."
		ewarn "Upstream suggests to enable one of the toolkits (or both)"
		ewarn "or only the command line utilities will be helpful."
	fi
}

src_prepare() {
	sed -i -e "s:-O2 ::" configure.ac || die
	eautoreconf
}

src_configure() {
	# Workaround executable sections QA warning (bug #348754)
	append-ldflags -Wl,-z,noexecstack

	local myconf
	if use opengl; then
		myconf+=" --with-just-gl"
	else
		myconf+=" --without-gl"
	fi

	if ! use ruby && ! use s7 ; then
		myconf+=" --without-extension-language"
	fi

	econf \
		$(use_with alsa) \
		$(use_with esd) \
		$(use_with fam) \
		$(use_with fftw) \
		$(use_with gmp) \
		$(use_with gsl) \
		$(use_with gtk) \
		$(use_with jack) \
		$(use_with ladspa) \
		$(use_with motif) \
		$(use_with oss) \
		$(use_with portaudio) \
		$(use_with pulseaudio) \
		$(use_enable readline) \
		$(use_with ruby) \
		$(use_with s7) \
		--with-float-samples \
		${myconf}

}

src_compile() {
	emake snd

	# Do not compile ruby extensions for command line programs since they fail
	sed -i -e "s:HAVE_RUBY 1:HAVE_RUBY 0:" mus-config.h

	for i in sndinfo audinfo sndplay; do
	   emake ${i}
	done
}

src_install () {
	dobin snd sndplay sndinfo audinfo

	if use ruby ; then
		insinto /usr/share/snd
		doins *.rb
	fi

	if use s7 ; then
		insinto /usr/share/snd
		doins *.scm
	fi

	dodoc README.Snd HISTORY.Snd NEWS
	use doc && dohtml -r *.html pix/*.png tutorial
}
