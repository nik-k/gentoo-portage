# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/mercurial/mercurial-9999.ebuild,v 1.17 2013/01/02 08:32:19 djc Exp $

EAPI=3
PYTHON_DEPEND="2"
PYTHON_USE_WITH="threads"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython 2.7-pypy-*"

inherit bash-completion-r1 elisp-common eutils distutils mercurial

DESCRIPTION="Scalable distributed SCM"
HOMEPAGE="http://mercurial.selenic.com/"
EHG_REPO_URI="http://selenic.com/repo/hg"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="bugzilla emacs gpg test tk zsh-completion"

RDEPEND="bugzilla? ( dev-python/mysql-python )
	gpg? ( app-crypt/gnupg )
	tk? ( dev-lang/tk )
	zsh-completion? ( app-shells/zsh )
	app-misc/ca-certificates"
DEPEND="emacs? ( virtual/emacs )
	test? ( app-arch/unzip
		dev-python/pygments )
	app-text/asciidoc
	dev-python/docutils"

PYTHON_CFLAGS=(
	"2.* + -fno-strict-aliasing"
	"* - -ftracer -ftree-vectorize"
)

PYTHON_MODNAME="${PN} hgext"
SITEFILE="70${PN}-gentoo.el"

src_prepare() {
	distutils_src_prepare
	# fix up logic that won't work in Gentoo Prefix (also won't outside in
	# certain cases), bug #362891
	sed -i -e 's:xcodebuild:nocodebuild:' setup.py || die
}

src_compile() {
	distutils_src_compile
	make doc || die
	if use emacs; then
		cd "${S}"/contrib || die
		elisp-compile mercurial.el || die "elisp-compile failed!"
	fi
	rm -rf contrib/{win32,macosx} || die
}

src_install() {
	distutils_src_install
	python_convert_shebangs 2 contrib/hg-ssh

	newbashcomp contrib/bash_completion ${PN} || die

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		newins contrib/zsh_completion _hg || die
	fi

	rm -f doc/*.?.txt || die
	dodoc CONTRIBUTORS README doc/*.txt || die
	cp hgweb*.cgi "${ED}"/usr/share/doc/${PF}/ || die

	dobin hgeditor || die
	dobin contrib/hgk || die
	dobin contrib/hg-ssh || die

	rm -f contrib/hgk contrib/hg-ssh || die

	rm -f contrib/bash_completion || die
	cp -r contrib "${ED}"/usr/share/doc/${PF}/ || die
	doman doc/*.? || die

	cat > "${T}/80mercurial" <<-EOF
HG="${EPREFIX}/usr/bin/hg"
EOF
	doenvd "${T}/80mercurial" || die

	if use emacs; then
		elisp-install ${PN} contrib/mercurial.el* || die "elisp-install failed!"
		elisp-site-file-install "${FILESDIR}"/${SITEFILE}
	fi

	insinto /etc/mercurial/hgrc.d
	doins "${FILESDIR}/cacerts.rc"
}

src_test() {
	cd "${S}/tests/" || die
	rm -rf *svn* || die					# Subversion tests fail with 1.5
	rm -f test-archive* || die			# Fails due to verbose tar output changes
	rm -f test-convert-baz* || die		# GNU Arch baz
	rm -f test-convert-cvs* || die		# CVS
	rm -f test-convert-darcs* || die	# Darcs
	rm -f test-convert-git* || die		# git
	rm -f test-convert-mtn* || die		# monotone
	rm -f test-convert-tla* || die		# GNU Arch tla
	rm -f test-doctest* || die			# doctest always fails with python 2.5.x
	rm -f test-largefiles* || die		# tends to time out
	if [[ ${EUID} -eq 0 ]]; then
		einfo "Removing tests which require user privileges to succeed"
		rm -f test-command-template* || die	# Test is broken when run as root
		rm -f test-convert* || die			# Test is broken when run as root
		rm -f test-lock-badness* || die		# Test is broken when run as root
		rm -f test-permissions* || die		# Test is broken when run as root
		rm -f test-pull-permission* || die	# Test is broken when run as root
		rm -f test-clone-failure* || die
		rm -f test-journal-exists* || die
		rm -f test-repair-strip* || die
	fi

	testing() {
		local testdir="${T}/tests-${PYTHON_ABI}"
		rm -rf "${testdir}" || die
		"$(PYTHON)" run-tests.py --tmpdir="${testdir}"
	}
	python_execute_function testing
}

pkg_postinst() {
	distutils_pkg_postinst
	use emacs && elisp-site-regen

	elog "If you want to convert repositories from other tools using convert"
	elog "extension please install correct tool:"
	elog "  dev-vcs/cvs"
	elog "  dev-vcs/darcs"
	elog "  dev-vcs/git"
	elog "  dev-vcs/monotone"
	elog "  dev-vcs/subversion"
}

pkg_postrm() {
	distutils_pkg_postrm
	use emacs && elisp-site-regen
}
