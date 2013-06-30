<!--
     The FreeBSD Documentation Project
     The FreeBSD French Documentation Project

     $Id: freebsd.dsl,v 1.13 2010-12-08 06:25:59 hrs Exp $
     $FreeBSD$
     Original revision: 1.17

-->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>

	<!-- Fix a problem with the French localisation. The bug was
	submitted to authors of docbook project -->
	(define (local-fr-label-title-sep)
        (list
          (list (normalize "warning")           "\U-00A0;: ")
	))

    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
