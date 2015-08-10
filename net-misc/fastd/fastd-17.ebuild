# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bird/bird-1.5.0.ebuild,v 1.1 2015/05/14 13:01:52 chainsaw Exp $
#http://repo.universe-factory.net/debian/pool/main/f/fastd/fastd_17-4.debian.tar.gz

EAPI=5

inherit cmake-utils

DESCRIPTION="Fast and Secure Tunneling Daemon"
HOMEPAGE="https://projects.universe-factory.net/projects/fastd/"
SRC_URI="https://projects.universe-factory.net/attachments/download/81/${P}.tar.xz"
LICENSE="BSD-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug nacl +sodium +openssl"
#REQUIRED_USE="nacl? ( !sodium )"
REQUIRED_USE="sodium? ( !nacl )"

RDEPEND="sys-libs/libcap
	|| ( net-libs/nacl dev-libs/libsodium )
	>=dev-libs/libuecc-5
	dev-libs/json-c
	openssl? ( dev-libs/openssl )"
DEPEND="dev-util/cmake
	>=sys-devel/bison-2.5
	sys-devel/m4
	virtual/pkgconfig"

src_configure() {
	export CMAKE_BUILD_TYPE="RELEASE"
	local mycmakeargs=(
		-DWITH_METHOD_CHIPER_TEST:BOOL=FALSE
		-DWITH_METHOD_NULL:BOOL=FALSE
		-DWITH_CHIPER_NULL:BOOL=FALSE
		-DWITH_CAPABILITIES:BOOL=TRUE
		-DENABLE_SYSTEMD=OFF
		-DENABLE_LTO=ON
		$(cmake-utils_use_enable nacl NACL)
		$(cmake-utils_use_enable sodium LIBSODIUM)
		$(cmake-utils_use_enable openssl)
	)

	cmake-utils_src_configure
}

src_install() {
	export CMAKE_BUILD_TYPE="RELEASE"
	local mycmakeargs=(
		-DWITH_METHOD_CHIPER_TEST:BOOL=FALSE
		-DWITH_METHOD_NULL:BOOL=FALSE
		-DWITH_CHIPER_NULL:BOOL=FALSE
		-DWITH_CAPABILITIES:BOOL=TRUE
		-DENABLE_SYSTEMD=OFF
		-DENABLE_LTO=ON
		$(cmake-utils_use_enable nacl NACL)
		$(cmake-utils_use_enable sodium LIBSODIUM)
		$(cmake-utils_use_enable openssl)
	)
	cmake-utils_src_install
	newinitd ${FILESDIR}/fastd.initd fastd
	doman doc/fastd.1
	keepdir /etc/fastd
	insinto /etc/fastd
	newins ${FILESDIR}/fastd.config fastd.config
	dodoc doc/examples/openwrt/fastd.config
}
