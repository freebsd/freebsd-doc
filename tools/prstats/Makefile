#
# $FreeBSD$
#

all:
	./go.tcl
	./eval.tcl
	make copy

copy:
	./cut.tcl 365 __ __365
	./cut.tcl 30 __ __30
	./cut.tcl 7 __ __7
	./cut.tcl 1 __ __1
	/usr/local/bin/gnuplot g
