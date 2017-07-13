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
ld-staticlib := \
	ball-on-beam \
	stiff-pendulum \
	flow-demo-ode
ball-on-beam-sources := ball-on-beam.vala
ball-on-beam-vala-staticlibs := $(builddir)/flow-demo-ode
stiff-pendulum-sources := stiff-pendulum.vala
stiff-pendulum-vala-staticlibs := $(builddir)/flow-demo-ode
flow-demo-ode-sources := flow-demo-ode.vala
flow-demo-sources := \
	constant.vala \
	flow-demo.vala \
	linear-test-equation.vala \
	lorentz.vala \
	step.vala
flow-demo-vala-staticlibs := \
	$(builddir)/ball-on-beam \
	$(builddir)/stiff-pendulum \
	$(builddir)/flow-demo-ode
gtk-ball-on-beam-sources := gtk-ball-on-beam.vala
gtk-ball-on-beam-vala-staticlibs := \
	$(builddir)/ball-on-beam \
	$(builddir)/flow-demo-ode
gtk-stiff-pendulum-sources := gtk-stiff-pendulum.vala
gtk-stiff-pendulum-vala-staticlibs := \
	$(builddir)/stiff-pendulum \
	$(builddir)/flow-demo-ode
interpolate-sources := interpolate.vala

include $(dir $(lastword $(MAKEFILE_LIST)))../make/build.mk
