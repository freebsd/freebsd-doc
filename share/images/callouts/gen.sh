#!/bin/sh

# $FreeBSD$

for i in `seq 1 30`
do
    convert -size 101x101 xc:green -transparent green -fill black -draw 'circle 50,50 50' -fill white -stroke none -pointsize 83 -gravity center -kerning -5 -font Helvetica-bold -draw "text 0,5 \"$i\"" -scale '12x12' $i.png

done
