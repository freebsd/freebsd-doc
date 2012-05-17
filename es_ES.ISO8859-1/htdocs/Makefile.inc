# $FreeBSD: www/es/Makefile.inc,v 1.3 2000/11/29 23:56:55 kuriyama Exp $

DATESUBST=	's/<!ENTITY date[ \t]*"$$Free[B]SD. .* \(.* .*\) .* .* $$">/<!ENTITY date	"\&Uacute\;ltima modificaci\&oacute\;n: \1">/'

WEBBASE?=	/data/es
DOC_PREFIX?=    ${.CURDIR}/../../..
