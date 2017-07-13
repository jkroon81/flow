vala-sharedlibs := $(top-builddir)/flow/flow
ldflags := -lm
gtk-valaflags := --pkg=gtk+-2.0 --enable-deprecated
gtk-ldflags := $(shell pkg-config gtk+-2.0 --libs)
gtk-ccflags := $(shell pkg-config gtk+-2.0 --cflags)
$(foreach b,ball-on-beam stiff-pendulum,\
  $(foreach f,vala ld cc,$(eval gtk-$b-$fflags := $(gtk-$fflags))))
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
gtk-ball-on-beam-sources := \
	ball-on-beam.vala \
	flow-demo-ode.vala \
	gtk-ball-on-beam.vala
gtk-stiff-pendulum-sources := \
	stiff-pendulum.vala \
	flow-demo-ode.vala \
	gtk-stiff-pendulum.vala
interpolate-sources := interpolate.vala

include $(dir $(lastword $(MAKEFILE_LIST)))../make/build.mk
