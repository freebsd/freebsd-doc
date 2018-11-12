# $FreeBSD$
# Original revision: 1.2

pdf: dvi ps
	ps2pdf13 -sPAPERSIZE=a4 flyer.ps

ps: dvi
	dvips -t a4 flyer.dvi -o

dvi: flyer.tex
	pngtopnm -mix ../../share/images/flyer/logo-full.png | \
		pnmtops -noturn > logo-full.eps
	latex flyer.tex

clean:
	rm -f flyer.aux flyer.dvi flyer.log flyer.pdf flyer.ps \
		logo-full.eps
