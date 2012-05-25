#
# The FreeBSD Russian Documentation Project
#
# $FreeBSD$
# $FreeBSDru: frdp/doc/ru_RU.KOI8-R/flyer/Makefile,v 1.1 2005/05/13 09:33:41 den Exp $
#
# Original revision: r19823
#

pdf: dvi ps
	ps2pdf13 -sPAPERSIZE=a4 flyer.ps

ps: dvi
	dvips -t a4 flyer.dvi -o

dvi: flyer.tex
	latex flyer.tex

clean:
	rm -f flyer.aux flyer.dvi flyer.log flyer.pdf flyer.ps
