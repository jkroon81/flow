CLEANFILES      = *~
noinst_PROGRAMS =                                  \
	flow-demo                                  \
	gtk-ball-on-beam                           \
	interpolate

flow_demo_SOURCES =                                \
	ball-on-beam.vala                          \
	flow-demo.vala                             \
	flow-demo-ode.vala                         \
	linear-test-equation.vala                  \
	step.vala                                  \
	stiff-pendulum.vala

flow_demo_VALAFLAGS =                              \
	--vapidir=/opt/vala-svn/share/vala/vapi    \
	--vapidir=$(top_builddir)/flow             \
	--pkg=flow

flow_demo_CFLAGS =                                 \
	@GOBJECT_CFLAGS@                           \
	-I$(top_builddir)

flow_demo_LDADD =                                  \
	@GOBJECT_LIBS@                             \
	$(top_builddir)/flow/libflow.la

gtk_ball_on_beam_SOURCES =                         \
	ball-on-beam.vala                          \
	flow-demo-ode.vala                         \
	gtk-ball-on-beam.vala

gtk_ball_on_beam_VALAFLAGS =                       \
	--vapidir=/opt/vala-svn/share/vala/vapi    \
	--vapidir=$(top_builddir)/flow             \
	--pkg=gtk+-2.0                             \
	--pkg=flow

gtk_ball_on_beam_CFLAGS =                          \
	@GTK_CFLAGS@                               \
	-I$(top_builddir)

gtk_ball_on_beam_LDADD =                           \
	@GTK_LIBS@                                 \
	$(top_builddir)/flow/libflow.la

interpolate_SOURCES =                              \
	interpolate.vala

interpolate_VALAFLAGS =                            \
	--vapidir=/opt/vala-svn/share/vala/vapi    \
	--vapidir=$(top_builddir)/flow             \
	--pkg=flow

interpolate_CFLAGS =                               \
	@GOBJECT_CFLAGS@                           \
	-I$(top_builddir)

interpolate_LDADD =                                \
	@GOBJECT_LIBS@                             \
	$(top_builddir)/flow/libflow.la

include Makefile.vm
