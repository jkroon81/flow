CLEANFILES      = flow.vapi *~
lib_LTLIBRARIES = libflow.la

libflow_la_SOURCES =                                 \
	flow-dopri.vala                              \
	flow-euler.vala                              \
	flow-integrator.vala                         \
	flow-ode.vala                                \
	flow-ode-solver.vala                         \
	flow-rungekutta-explicit.vala                \
	flow-solver.vala                             \
	flow-step-method.vala                        \
	flow-vector.vala

libflow_la_VALAFLAGS =                               \
	--vapidir=/opt/vala-svn/share/vala/vapi      \
	--library=flow

libflow_la_CFLAGS =                                  \
	@GOBJECT_CFLAGS@                             \
	-I$(top_builddir)

libflow_la_LIBADD =                                  \
	@GOBJECT_LIBS@                               \
	-lm

include Makefile.vm
