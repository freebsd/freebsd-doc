# $FreeBSD$

DATESUBST=	's/<!ENTITY date[ \t]*"$$Free[B]SD. .* \(.* .*\) .* .* $$">/<!ENTITY date	"\&Uacute\;ltima modificaci\&oacute\;n: \1">/'

WEBBASE?=	/data/es
DOC_PREFIX?=    ${.CURDIR}/../../..
