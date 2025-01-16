# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Autogenerated by pycargoebuild 0.13.4

EAPI=8

CRATES="
"

inherit cargo shell-completion

DESCRIPTION="Unofficial Bitwarden CLI"
HOMEPAGE="https://github.com/doy/rbw"
SRC_URI="
	https://github.com/doy/rbw/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/peeweep/gentoo-go-deps/releases/download/${P}/${P}-crates.tar.xz
	${CARGO_CRATE_URIS}
"

LICENSE="MIT"
# Dependent crate licenses
LICENSE+=" Apache-2.0 BSD Boost-1.0 ISC MIT Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64"

QA_FLAGS_IGNORED="
	usr/bin/rbw
	usr/bin/rbw-agent
"

src_install() {
	cargo_src_install

	local rbw
	rbw="${ED}/usr/bin/rbw"

	"$rbw" gen-completions bash > rbw || die
	dobashcomp rbw

	"$rbw" gen-completions fish > rbw.fish || die
	dofishcomp rbw.fish

	"$rbw" gen-completions zsh > _rbw || die
	dozshcomp _rbw
}