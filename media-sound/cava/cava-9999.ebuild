# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils linux-info

if [[ ${PV} = "9999" ]]; then
	EGIT_REPO_URI="https://github.com/karlstav/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/karlstav/${PN}/archive/${V}.tar.gz"
	KEYWORDS="~amd64"
fi

DESCRIPTION="Console-based Audio Visualizer for Alsa"
HOMEPAGE="Console-based Audio Visualizer for Alsa"

LICENSE="MIT"
SLOT="0"

DEPEND="dev-libs/iniparser
		sci-libs/fftw"

RDEPEND="sci-libs/fftw"

src_prepare() {
	default
}

src_configure() {
	./autogen.sh

	# Use the legacy iniparser to build under 4.0, circumventing a bug on musl based systems
	./configure \
	--enable-legacy_iniparser
}

pkg_setup() { 
	if linux_config_exists; then
		einfo "Checking kernel configuration at $(linux_config_path)..."
		if ! linux_chkconfig_present SND_ALOOP ; then
			ewarn 'Kernel option CONFIG_SND_ALOOP=[ym] is needed for ALSA users'
			ewarn 'If using PulseAudio or MPD fifo then this can be ignored'
		fi
	fi
}

src_install() {
	emake
}

pkg_postint() {
	ewarn
	ewarn "Cava is know to segfault on start if there is no configuration file to read"
	ewarn
}
