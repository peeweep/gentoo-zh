# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

FRONTEND_COMMIT_ID="0bf85fa0abdfa25c4bd20305e2013ac307cfc106"

DESCRIPTION="A file list/WebDAV program that supports multiple storages"
HOMEPAGE="https://alist.nn.ci"
SRC_URI="
	https://github.com/cloudreve/cloudreve/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/cloudreve/frontend/archive/${FRONTEND_COMMIT_ID}.tar.gz -> ${P}-frontend-${FRONTEND_COMMIT_ID}.tar.gz
	node_modules.tar.gz
	https://github.com/gentoo-zh/gentoo-deps/releases/download/${P}/${P}-vendor.tar.xz
"
# https://github.com/gentoo-zh/gentoo-deps/releases/download/${P}/${P}-node_modules.tar.xz -> node_modules.tar.gz

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
BDEPEND="
	net-libs/nodejs
	sys-apps/yarn
"

src_prepare() {
	rm -r assets || die
	mv ${WORKDIR}/frontend-0bf85fa0abdfa25c4bd20305e2013ac307cfc106 assets || die
	mv ${WORKDIR}/node_modules assets/ || die
	default
}

src_compile() {
	# prepare assets.zip, see .build/build-assets.sh
	pushd assets
	# PREFIX="${T}/fake-prefix" yarn --offline build || die
	# npm run build || die
	popd
	zip -r - assets/build >assets.zip

	local ldflags="
		-X github.com/cloudreve/Cloudreve/v4/application/constants.BackendVersion=${PV}
		-X github.com/cloudreve/Cloudreve/v4/application/constants.LastCommit=123
	"
	ego build -o ${PN} -ldflags "${ldflags}"
}
