# $FreeBSD$

DATESUBST=	's/<!ENTITY date[ \t]*"$$Free[B]SD. .* \(.* .*\) .* .* $$">/<!ENTITY date	"Utols\&oacute\; m\&oacute\;dos\&iacute\;t\&aacute\;s: \1">/'

WEBBASE?=       /data/hu
DOC_PREFIX?=	${.CURDIR}/../../..
