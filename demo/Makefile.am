CLEANFILES      = *~
noinst_PROGRAMS =                                  \
	flow-demo                                  \
	gtk-ball-on-beam

flow_demo_SOURCES =                                \
	ball-on-beam.vala                          \
	flow-demo.vala                             \
	flow-demo-ode.vala                         \
	linear-test-equation.vala                  \
	step.vala                                  \
	stiff-pendulum.vala

gtk_ball_on_beam_SOURCES =                         \
	ball-on-beam.vala                          \
	flow-demo-ode.vala                         \
	gtk-ball-on-beam.vala

VALAFLAGS =                                        \
	--vapidir=/opt/vala-svn/share/vala/vapi    \
	--vapidir=$(top_builddir)/flow             \
	--pkg=flow --pkg=gtk+-2.0

INCLUDES =                                         \
	@GOBJECT_CFLAGS@                           \
	@GTK_CFLAGS@                               \
	-I$(top_builddir)

LDADD =                                            \
	@GTK_LIBS@                                 \
	$(top_builddir)/flow/libflow.la

include Makefile.vm
