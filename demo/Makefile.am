CLEANFILES      = *~
noinst_PROGRAMS = flow-demo

flow_demo_SOURCES =                        \
	flow-demo.vala                     \
	flow-demo-ode.vala                 \
	linear-test-equation.vala          \
	step.vala                          \
	stiff-pendulum.vala

VALAFLAGS =                                \
	--vapidir=$(top_builddir)/flow     \
	--pkg=flow

INCLUDES =                                 \
	@GOBJECT_CFLAGS@                   \
	-I$(top_builddir)

LDADD =                                    \
	$(top_builddir)/flow/libflow.la

include Makefile.vm
