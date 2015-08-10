# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils

DESCRIPTION="very small Elliptic Curve Crzptography library"
homepage="https://git.universe-factory.net/libuecc/"
SRC_URI="https://projects.universe-factory.net/attachments/download/80/${P}.tar.xz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-static-libs"

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	append-ldflags -ffunction,-fdata-sections
	cmake-utils_src_compile
}
