# $FreeBSD: www/hu/Makefile.inc,v 1.1 2007/01/07 22:44:46 keramida Exp $

DATESUBST=	's/<!ENTITY date[ \t]*"$$Free[B]SD. .* \(.* .*\) .* .* $$">/<!ENTITY date	"Utols\&oacute\; m\&oacute\;dos\&iacute\;t\&aacute\;s: \1">/'

WEBBASE?=       /data/hu
WEB_PREFIX?=	${.CURDIR}/../..
