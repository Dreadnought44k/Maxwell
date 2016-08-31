# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="fast, highly customizable system info script that supports Linux, OS X, iOS, BSD, Solaris and Windows (Cygwin)"
HOMEPAGE="https://github.com/dylanaraps/neofetch"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="https://github.com/dylanaraps/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/dylanaraps/${PN}/archive/${PV}.tar.gz"
	KEYWORDS="amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="images"

DEPEND="app-shells/bash"
RDEPEND="${DEPEND} images? ( www-client/w3m[imlib,fbcon] )"
