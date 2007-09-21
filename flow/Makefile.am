CLEANFILES      = flow.vala *~
lib_LTLIBRARIES = libflow.la

libflow_la_SOURCES =                \
	flow-vector.vala

libflow_la_VALAFLAGS =              \
	--library=flow

libflow_la_CFLAGS =                 \
	@GOBJECT_CFLAGS@            \
	-I$(top_builddir)

libflow_la_LIBADD =                 \
	@GOBJECT_LIBS@

include Makefile.vm
