CLEANFILES = *~

noinst_PROGRAMS = \
	flow-demo \
	gtk-ball-on-beam \
	gtk-stiff-pendulum \
	interpolate

flow_demo_SOURCES = \
	ball-on-beam.vala \
	constant.vala \
	flow-demo.vala \
	flow-demo-ode.vala \
	linear-test-equation.vala \
	lorentz.vala \
	step.vala \
	stiff-pendulum.vala

flow_demo_VALAFLAGS = \
	--vapidir=$(top_builddir)/flow \
	--pkg=flow

flow_demo_CFLAGS = \
	@GOBJECT_CFLAGS@ \
	-I$(top_srcdir)/flow

flow_demo_LDADD = \
	@GOBJECT_LIBS@ \
	$(top_builddir)/flow/libflow.la

gtk_ball_on_beam_SOURCES = \
	ball-on-beam.vala \
	flow-demo-ode.vala \
	gtk-ball-on-beam.vala

gtk_ball_on_beam_VALAFLAGS = \
	--vapidir=$(top_builddir)/flow \
	--pkg=flow \
	--pkg=gtk+-2.0

gtk_ball_on_beam_CFLAGS = \
	@GTK_CFLAGS@ \
	-I$(top_srcdir)/flow

gtk_ball_on_beam_LDADD = \
	@GTK_LIBS@ \
	$(top_builddir)/flow/libflow.la

gtk_stiff_pendulum_SOURCES = \
	stiff-pendulum.vala \
	flow-demo-ode.vala \
	gtk-stiff-pendulum.vala

gtk_stiff_pendulum_VALAFLAGS = \
	--vapidir=$(top_builddir)/flow \
	--pkg=flow \
	--pkg=gtk+-2.0

gtk_stiff_pendulum_CFLAGS = \
	@GTK_CFLAGS@ \
	-I$(top_srcdir)/flow

gtk_stiff_pendulum_LDADD = \
	@GTK_LIBS@ \
	$(top_builddir)/flow/libflow.la

interpolate_SOURCES = \
	interpolate.vala

interpolate_VALAFLAGS = \
	--vapidir=$(top_builddir)/flow \
	--pkg=flow

interpolate_CFLAGS = \
	@GOBJECT_CFLAGS@ \
	-I$(top_srcdir)/flow

interpolate_LDADD = \
	@GOBJECT_LIBS@ \
	$(top_builddir)/flow/libflow.la

