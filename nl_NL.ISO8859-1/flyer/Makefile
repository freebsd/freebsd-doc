# $FreeBSD$
# $FreeBSDnl: nl_NL.ISO8859-1/flyer/Makefile,v 1.2 2005/04/30 11:45:54 remko Exp $

pdf: dvi ps
	ps2pdf13 -sPAPERSIZE=a4 flyer.ps

ps: dvi
	dvips -t a4 flyer.dvi -o

dvi: flyer.tex
	latex flyer.tex

clean:
	rm -f flyer.aux flyer.dvi flyer.log flyer.pdf flyer.ps
