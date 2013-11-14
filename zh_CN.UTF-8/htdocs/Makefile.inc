# The FreeBSD Simplified Chinese Documentation Project
# Original revision: 1.8
# $FreeBSD$

WEBBASE?=	/data/zh_CN
DOC_PREFIX?=	${.CURDIR}/../../..
DATESUBST?=	's/<!ENTITY date[ \t]*"$$Free[B]SD. .* \(.* .*\) .* .* $$">/<!ENTITY date	"上次更新： \1">/'
