# $FreeBSD: www/tools/portsgrowth/ports.plt,v 1.2 2004/09/26 13:36:01 simon Exp $
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
plot "ports.log" using 1:3 smooth bezier notitle with lines
