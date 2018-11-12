#!/bin/sh
#
# fase_1.sh - FreeBSD From Scratch, Primera Fase: Instalaci�n del Sistema.
#              Uso: ./fase_1.sh
#
# $FreeBSD$

set -x -e
PATH=/bin:/usr/bin:/sbin:/usr/sbin

# Requisitos:
#
# a) Haber completado sin errores "make buildworld" y "make buildkernel"
# b) Particiones sin usar (al menos una para el sistema de ficheros ra�z, 
#    probablemente m�s para los nuevos /usr y /var, a gusto de cada uno.)

# El punto montaje de la ra�z bajo la que va usted a crear el sistema nuevo.
# S�lo va a usarse como punto de montaje; que no se usar� espacio en �l 
# puesto que todos los ficheros ser�n depositados en el o los sistemas 
# de ficheros que est�n efectivamente montados.
DESTDIR=/rootnuevo
SRC=/usr/src         # Aqu� est� su �rbol de fuentes.

# ---------------------------------------------------------------------------- #
# Primer Paso: Creaci�n de un �rbol de directorios vac�o bajo $DESTDIR. 
# ---------------------------------------------------------------------------- #

step_one () {
  # El nuevo ra�z del sistema de ficheros. Obligatorio.
  # Cambie los nombres de dispositivo (DEV_*) para hacerlos acordes con 
  # sus necesidades o el "script" le
  # estallar� en la cara.
  DEV_ROOT=/dev/da3s1a
  mkdir -p ${DESTDIR}
  newfs ${DEV_ROOT}
  tunefs -n enable ${DEV_ROOT}
  mount -o noatime ${DEV_ROOT} ${DESTDIR}

  # Sistemas de ficheros extra y sus correspondientes puntos de montaje. 
  # Opcional.
  DEV_VAR=/dev/vinum/var_a
  newfs ${DEV_VAR}
  tunefs -n enable ${DEV_VAR}
  mkdir -m 755 ${DESTDIR}/var
  mount -o noatime ${DEV_VAR} ${DESTDIR}/var

  DEV_USR=/dev/vinum/usr_a
  newfs ${DEV_USR}
  tunefs -n enable ${DEV_USR}
  mkdir -m 755 ${DESTDIR}/usr
  mount -o noatime ${DEV_USR} ${DESTDIR}/usr

  mkdir -m 755 -p ${DESTDIR}/usr/ports
  mount /dev/vinum/ports ${DESTDIR}/usr/ports

  # Aqu� crearemos los dem�s directorios. Obligatorio.
  cd ${SRC}/etc; make distrib-dirs DESTDIR=${DESTDIR}
  # Personalmente me gusta enlazar tmp a var/tmp. Opcional.
  cd ${DESTDIR}; rmdir tmp; ln -s var/tmp
}

# ---------------------------------------------------------------------------- #
# Segundo Paso: Poblamos el �rbol de directorios /etc que est� vac�o a�n y 
#               ubicamos unos cuantos ficheros en /.
# ---------------------------------------------------------------------------- #

step_two () {
  # A�ada o borre de �sta lista seg�n su criterio. La mayor�a son obligatorios.
  for f in \
    /.profile \
    /etc/group \
    /etc/hosts \
    /etc/inetd.conf \
    /etc/ipfw.conf \
    /etc/make.conf \
    /etc/master.passwd \
    /etc/nsswitch.conf \
    /etc/ntp.conf \
    /etc/printcap \
    /etc/profile \
    /etc/rc.conf \
    /etc/resolv.conf \
    /etc/start_if.xl0 \
    /etc/ttys \
    /etc/ppp/* \
    /etc/mail/aliases \
    /etc/mail/aliases.db \
    /etc/mail/hal9000.mc \
    /etc/mail/service.switch \
    /etc/ssh/*key* \
    /etc/ssh/*_config \
    /etc/X11/XF86Config-4 \
    /boot/splash.bmp \
    /boot/loader.conf \
    /boot/device.hints ; do
    cp -p ${f} ${DESTDIR}${f}
  done
  # Borre el temproot que haya creado mergemasger. Si lo ha creado.
  TEMPROOT=/var/tmp/temproot.fase1
  if test -d ${TEMPROOT}; then
    chflags -R 0 ${TEMPROOT}
    rm -rf ${TEMPROOT}
  fi
  mergemaster -i -m ${SRC}/etc -t ${TEMPROOT} -D ${DESTDIR}
  cap_mkdb ${DESTDIR}/etc/login.conf
  pwd_mkdb -d ${DESTDIR}/etc -p ${DESTDIR}/etc/master.passwd

  # Mergemaster no crea ficheros vac�os por ejemplo en /var/log. Lo haremos 
  # aqu� pero sin sobreescribir (y destru�r) ficheros copiados en el bucle
  # de m�s arriba.
  cd ${TEMPROOT}
  find . -type f | sed 's,^\./,,' |
  while read f; do
    if test -r ${DESTDIR}/${f}; then
      echo "${DESTDIR}/${f} ya existe; no copiado"
    else
      echo "Creando ${DESTDIR}/${f} vac�o"
      cp -p ${f} ${DESTDIR}/${f}
    fi
  done
  chflags -R 0 ${TEMPROOT}
  rm -rf ${TEMPROOT}
}

# ---------------------------------------------------------------------------- #
# Tercer  Paso: Instalando el mundo (install world).
# ---------------------------------------------------------------------------- #

step_three () {
  cd ${SRC}
  make installworld DESTDIR=${DESTDIR}
}

# ---------------------------------------------------------------------------- #
# Cuarto Paso: Instalaci�n del kernel y los m�dulos.
# ---------------------------------------------------------------------------- #

step_four () {
  cd ${SRC}
  # loader.conf y device.hints son necesarios para installkernel.
  # Si en el segundo paso no los ha copiado h�galo tal y como se muestra en 
  # las dos l�neas siguientes.
  #   cp sys/boot/forth/loader.conf ${DESTDIR}/boot/defaults
  #   cp sys/i386/conf/GENERIC.hints ${DESTDIR}/boot/device.hints
  make installkernel DESTDIR=${DESTDIR} KERNCONF=NOMBRE_DE_SU_KERNEL
}

# ---------------------------------------------------------------------------- #
# Quinto Paso: Instalaci�n y modificaci�n de algunos ficheros clave.
# ---------------------------------------------------------------------------- #

step_five () {
  # Creamos /etc/fstab; obligatorio. Modif�quelo para que coincida con sus 
  # dispositivos.
  cat <<EOF >${DESTDIR}/etc/fstab
# Device         Mountpoint          FStype    Options              Dump Pass#
/dev/da3s1b      none                swap      sw                   0    0
/dev/da4s2b      none                swap      sw                   0    0
/dev/da3s1a      /                   ufs       rw                   1    1
/dev/da1s2a      /src                ufs       rw                   0    2
/dev/da2s2f      /share              ufs       rw                   0    2
/dev/vinum/var_a /var                ufs       rw                   0    2
/dev/vinum/usr_a /usr                ufs       rw                   0    2
/dev/vinum/home  /home               ufs       rw                   0    2
/dev/vinum/ncvs  /home/ncvs          ufs       rw,noatime           0    2
/dev/vinum/ports /usr/ports          ufs       rw,noatime           0    2
#
/dev/cd0         /dvd                cd9660    ro,noauto            0    0
/dev/cd1         /cdrom              cd9660    ro,noauto            0    0
proc             /proc               procfs    rw                   0    0
EOF

  # M�s directorios; opcional.
  mkdir -m 755 -p ${DESTDIR}/src;       chown root:wheel ${DESTDIR}/src
  mkdir -m 755 -p ${DESTDIR}/share;     chown root:wheel ${DESTDIR}/share
  mkdir -m 755 -p ${DESTDIR}/dvd;       chown root:wheel ${DESTDIR}/dvd
  mkdir -m 755 -p ${DESTDIR}/home;      chown root:wheel ${DESTDIR}/home
  mkdir -m 755 -p ${DESTDIR}/usr/ports; chown root:wheel ${DESTDIR}/usr/ports
  # Configuraci�n de la zona horaria; no es obligatorio pero casi.
  cp ${DESTDIR}/usr/share/zoneinfo/Antarctica/South_Pole ${DESTDIR}/etc/localtime
  if test -r /etc/wall_cmos_clock; then
     cp -p /etc/wall_cmos_clock ${DESTDIR}/etc/wall_cmos_clock
  fi
}

# ---------------------------------------------------------------------------- #
# Sexto Paso: Lo que considero importante tener cuando accedo a un sistema
# nuevo por primera vez.
# NOTA: No instale demasiados binarios en �ste paso. Con el sistema viejo 
# en funcionamiento y los nuevos binarios y ficheros de cabecera instalados 
# es casi seguro tener problemas de bootstrap. Los "ports" deber�an compilarse 
# despu�s de haber arrancado el nuevo sistema.
# ---------------------------------------------------------------------------- #

step_six () {
  chroot ${DESTDIR} sh -c "cd /usr/ports/shells/zsh; make clean install clean"
  chroot ${DESTDIR} sh -c "cd /etc/mail; make install"  # configuraci�n 
                                                        # de sendmail

  # Si no enlazamos simb�licamente compat los ficheros de linux_base 
  # ir�n a parar al sistema de ficheros ra�z.
  cd ${DESTDIR}; mkdir -m 755 usr/compat
  chown root:wheel usr/compat; ln -s usr/compat
  mkdir -m 755 usr/compat/linux
  mkdir -m 755 boot/grub

  # Creaci�n de los directorios "spool" para las impresoras que hay en 
  # mi /etc/printcap
  cd ${DESTDIR}/var/spool/output/lpd; mkdir -p as od ev te lp da
  touch ${DESTDIR}/var/log/lpd-errs

  # M�s ficheros que quiero heredar del sistema ant�guo.
  for f in \
    /var/cron/tabs/root \
    /var/mail/* \
    /boot/grub/*; do
    cp -p ${f} ${DESTDIR}${f}
  done

  # Si no tiene /home en una partici�n compartida es un buen momento para 
  # copiarlo al sitio correcto.
  # mkdir -p ${DESTDIR}/home
  # cd /home; tar cf - . | (cd ${DESTDIR}/home; tar xpvf -)

  # Como novedad en FreeBSD 5.x perl est� en /usr/local/bin pero la 
  # mayor�a de "scripts" esperan encontrarlo en /usr/bin/perl y as� lo 
  # reflejan en su primera l�nea; use un enlace simb�lico para que funcionen.
  cd ${DESTDIR}/usr/bin; ln -s ../local/bin/perl
  cd ${DESTDIR}/usr; rmdir src; ln -s ../src/current src
}

do_steps () {
  step_one
  step_two
  step_three
  step_four
  step_five
  step_six
}

do_steps 2>&1 | tee fase_1.log

# EOF $RCSfile: fase_1.sh,v $    vim: tabstop=2:expandtab:
