# $FreeBSD: www/tools/portsgrowth/ports.plt,v 1.1 2002/05/20 10:44:35 phantom Exp $
set terminal png
set output "ports.png"
set ylabel "Number of ports"
set timefmt "%Y/%m/%d %H:%M:%S"
set format x "%Y"
set xdata time
set grid
# Uncomment to make ranges match 
#  http://people.freebsd.org/~asami/papers/growth.gif
# set xrange ["1995/01":"2000/11"]
# set yrange [0:4000]
set multiplot
plot "ports.log" using 1:3 notitle with points
plot "ports.log" using 1:3 smooth bezier notitle with lines
