# $FreeBSD$
# $FreeBSDde: de-docproj/flyer/Makefile,v 1.1 2004/06/22 21:35:22 brueffer Exp $
# basiert auf: 1.1
#

pdf: dvi ps
	ps2pdf13 -sPAPERSIZE=a4 flyer.ps

ps: dvi
	dvips -t a4 flyer.dvi -o

dvi: flyer.tex
	latex flyer.tex

clean:
	rm -f flyer.aux flyer.dvi flyer.log flyer.pdf flyer.ps
