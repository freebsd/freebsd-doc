#!/bin/sh
#
# $FreeBSD$
#
# Shell script to generate the .pnm files required for the send-pr
# mechanism.  This is not used by the build process, as it requires
# X libraries for the gozer program; rather they are generated and
# committed into www/en/gifs/

GOZER=/usr/X11R6/bin/gozer
PNGTOPNM=/usr/local/bin/pngtopnm
VERBOSE=/usr/bin/false

# Generate 8 character code from A-Z0-9 (no o,O,0)
availchars="A B C D E F G H I J K L M N P Q R S T U V W X Y Z 1 2 3 4 5 6 7 8 9"

for char in ${availchars}
do
    ${VERBOSE} Making ${char}.png...
    ${GOZER} -x 2 -t ${char} -f "#990000" -b "#ffffff" ${char}.png
    ${VERBOSE} DONE
    ${VERBOSE} Converting ${char}.pnm to ${char}.png...
    ${PNGTOPNM} ${char}.png > ${char}.pnm
    ${VERBOSE} DONE
    ${VERBOSE} Removing ${char}.png...
    rm ${char}.png
    ${VERBOSE} DONE
done

