# The FreeBSD Simplified Chinese Documentation Project
# Original revision: 1.8
# $FreeBSD: www/zh_CN/Makefile.inc,v 1.1.1002.2 2005/12/18 09:12:48 delphij Exp $

WEBBASE?=	/data/zh_CN
WEB_PREFIX?=	${.CURDIR}/../..
DATESUBST?=	's/<!ENTITY date[ \t]*"$$Free[B]SD. .* \(.* .*\) .* .* $$">/<!ENTITY date	"上次更新： \1">/'
