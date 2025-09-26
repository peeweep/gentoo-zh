# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit go-module

DESCRIPTION="An easy way to manage all your Geo resources"
HOMEPAGE="https://github.com/golang/vuln"
SRC_URI="
	https://github.com/golang/vuln/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/gentoo-zh/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz
"

S="${WORKDIR}/vuln-${PV}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	ego build ./cmd/govulncheck
}

src_install() {
	dobin govulncheck
}
