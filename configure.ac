AC_INIT(autogen.sh)
AC_CONFIG_AUX_DIR(build)
AM_INIT_AUTOMAKE(flow, 0.0.0)

AC_PROG_LIBTOOL()
AC_PATH_PROG(VALAC, valac, valac)
PKG_CHECK_MODULES(GOBJECT, gobject-2.0)
PKG_CHECK_MODULES(GTK, gtk+-2.0)

SHAVE_INIT([build], [enable])

AC_OUTPUT(
	build/shave
	build/shave-libtool
	Makefile
	demo/Makefile
	flow/Makefile
	util/Makefile
	)
