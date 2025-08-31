# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

DESCRIPTION="Command line tools for fly.io services"
HOMEPAGE="https://github.com/superfly/flyctl"

SRC_URI="https://github.com/superfly/flyctl/archive/v${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI+=" https://github.com/gentoo-zh/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
BDEPEND=">=dev-lang/go-1.24.5"

src_compile() {
	NOW_RFC3339="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
	ego build -o bin/flyctl -tags production -ldflags="
		-X 'github.com/superfly/flyctl/internal/buildinfo.buildDate=${NOW_RFC3339}'
		-X 'github.com/superfly/flyctl/internal/buildinfo.commit=b389cead658c02081d3cc1384def330a54707d67'
		-X 'github.com/superfly/flyctl/internal/buildinfo.buildVersion=${PV}'"
}

src_install() {
	dobin bin/flyctl
}
