# Copyright 2026 Pedro Pereira
# Distributed under the terms of the Apache License, Version 2.0

EAPI=8

inherit cmake git-r3

DESCRIPTION="Wayland compositor inspired by Window Maker"
HOMEPAGE="https://github.com/phkaeser/wlmaker"
EGIT_REPO_URI="https://github.com/phkaeser/wlmaker.git"
EGIT_COMMIT="v${PV}"
EGIT_SUBMODULES=( submodules/libbase submodules/inih )

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug doc test xwayland"
RESTRICT="!test? ( test )"

DEPEND="
	>=dev-libs/wayland-protocols-1.32
	dev-libs/libinput:=
	dev-libs/libxdg-basedir
	dev-libs/wayland
	gui-libs/wlroots:0.20[x11-backend]
	sys-libs/ncurses:=
	x11-libs/cairo
	x11-libs/libxcb
	x11-libs/libxkbcommon
	xwayland? (
		gui-libs/wlroots:0.20[X]
		x11-base/xwayland
	)
"
RDEPEND="${DEPEND}"
BDEPEND="
	dev-util/wayland-scanner
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
	doc? (
		app-text/doxygen
		media-gfx/plantuml
	)
"

src_prepare() {
	use xwayland || sed -i '/^pkg_check_modules(XWAYLAND /d' src/CMakeLists.txt || die
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=( -Dconfig_DEBUG=$(usex debug) )
	cmake_src_configure
}

src_compile() {
	cmake_src_compile
	use doc && cmake_src_compile doc
}

src_install() {
	cmake_src_install
	use doc && local HTML_DOCS=( "${BUILD_DIR}"/doc/html/. )
	einstalldocs
}
