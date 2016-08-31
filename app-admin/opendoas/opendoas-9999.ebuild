# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils pam

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/Duncaen/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/Duncaen/${PN}/archive/v${V}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="A portable version of the OpenBSD doas command"
HOMEPAGE="https://github.com/Duncaen/OpenDoas"

LICENSE="BSD"
SLOT="0"
IUSE="pam"

DEPEND="pam? ( virtual/pam )"

src_prepare() {
	default
}

src_configure() {
	./configure \
		--prefix="${D}"/usr \
		--exec-prefix="${D}"/usr \
		--mandir="${D}"/usr/share/man \
		--pamdir="${D}"/etc/pam.d \
		$(use_with pam) 
}

src_install() {
	make
	make install
}

pkg_postinst() {
	ewarn 
	ewarn "Doas is very experimental"
	ewarn

	elog "To use doas the admin must create a doas.conf file in /etc"
	elog "echo 'permit :admin' | sudo tee /etc/doas.conf"
	elog "and allow the specific user access"
}
