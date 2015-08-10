# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
#http://debian.draic.info/pool/main/a/alfred/alfred_2014.3.0-11.debian.tar.gz

EAPI=5

inherit user

DESCRIPTION="Almighty Lightweight Fact Remote Exchange Daemon"
HOMEPAGE="https://www.open-mesh.org/projects/open-mesh/wiki/Alfred"
SRC_URI="http://downloads.open-mesh.org/batman/stable/sources/${PN}/${P}.tar.gz"
LICENSE="BSD-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug gps"

DOCS="CHANGELOG README"

#libcap.pc intruduced in libcap version 2.23
RDEPEND=">=sys-libs/libcap-2.23
	virtual/pkgconfig
	gps? ( sci-geosciences/gpsd )"
DEPEND="gps? ( sci-geosciences/gpsd )
	sys-devel/m4"

src_compile() {
	emake CONFIG_ALFRED_VIS=n CONFIG_ALFRED_GPSD=n
}

src_install() {
	emake PREFIX="/usr" DESTDIR="${D}" CONFIG_ALFRED_VIS=n CONFIG_ALFRED_GPSD=n install
#	dodoc "${DOCS[@]}"
	dodoc ${DOCS}
#	newinitd ${FILESDIR}/fastd.initd fastd
	doman man/alfred.8
	use gps && doman gpsd/man/alfred-gpsd.8
#	doman vis/man/batadv-vis.8
	newconfd "${FILESDIR}"/alfred.confd alfred
	keepdir /etc/alfred
	insinto /etc/alfred
#	newins ${FILESDIR}/fastd.config fastd.config
#	dodoc doc/examples/openwrt/fastd.config
}

pkg_postinst() {
	enewgroup alfred
	enewuser alfred -1 -1 -1 alfred 
}
