ld-bin := \
	flow-demo \
	gtk-ball-on-beam \
	gtk-stiff-pendulum \
	interpolate
flow-demo-sources := \
	ball-on-beam.vala \
	constant.vala \
	flow-demo.vala \
	flow-demo-ode.vala \
	linear-test-equation.vala \
	lorentz.vala \
	step.vala \
	stiff-pendulum.vala
flow-demo-vala-sharedlibs := $(top-builddir)/flow/flow
ldflags := -lm
gtk-ball-on-beam-sources := \
	ball-on-beam.vala \
	flow-demo-ode.vala \
	gtk-ball-on-beam.vala
gtk-ball-on-beam-valaflags := --pkg=gtk+-2.0 --enable-deprecated
gtk-ball-on-beam-ldflags := $(shell pkg-config gtk+-2.0 --libs)
gtk-ball-on-beam-vala-sharedlibs := $(top-builddir)/flow/flow
gtk-ball-on-beam-ccflags := $(shell pkg-config gtk+-2.0 --cflags)
gtk-stiff-pendulum-sources := \
	stiff-pendulum.vala \
	flow-demo-ode.vala \
	gtk-stiff-pendulum.vala
gtk-stiff-pendulum-valaflags := --pkg=gtk+-2.0 --enable-deprecated
gtk-stiff-pendulum-ldflags := $(shell pkg-config gtk+-2.0 --libs)
gtk-stiff-pendulum-vala-sharedlibs := $(top-builddir)/flow/flow
gtk-stiff-pendulum-ccflags := $(shell pkg-config gtk+-2.0 --cflags)
interpolate-sources := interpolate.vala
interpolate-vala-sharedlibs := $(top-builddir)/flow/flow

include $(dir $(lastword $(MAKEFILE_LIST)))../make/build.mk
