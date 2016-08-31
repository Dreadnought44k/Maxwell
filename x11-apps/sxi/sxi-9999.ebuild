# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils git-r3

EGIT_REPO_URI="https://github.com/serprex/sxi.git"
KEYWORDS="~amd64"

DESCRIPTION="Suckless xinit"
HOMEPAGE="https://github.com/serprex/sxi"

LICENSE=""
SLOT="0"

RDEPEND="x11-base/xorg-server
		 x11-apps/xauth
		 x11-libs/libX11"

DEPEND="${RDEPEND}
		dev-util/ninja"

src_prepare() {
	default
}

src_install() {
	ninja sxi
	dobin sxi
}


