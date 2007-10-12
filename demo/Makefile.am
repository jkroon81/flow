CLEANFILES      = *~
noinst_PROGRAMS =                          \
	linear-test-equation               \
	stiff-pendulum

linear_test_equation_SOURCES =             \
	linear-test-equation.vala

stiff_pendulum_SOURCES =                   \
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
