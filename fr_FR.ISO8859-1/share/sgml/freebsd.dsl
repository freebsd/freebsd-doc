<!-- $FreeBSD: doc/fr_FR.ISO_8859-1/share/sgml/freebsd.dsl,v 1.1 2000/03/23 09:00:08 nik Exp $ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
 
      <![ %output.html; [ 
        <!-- Fix a problem with the French localisation.  This should really
             be a patch to the dsssl-docbook-modular port, but this gets it
             more widely available sooner.  A patch will be applied to the
             port as well, and then this can be removed. -->
        (define (gentext-fr-nav-prev prev)
          (make sequence (literal "Pr\U-00E9;c\U-00E9;dent")))

	(define ($email-footer$)
          (make sequence
            (literal "For questions about FreeBSD, e-mail <")
            (make element gi: "a"
                  attributes: (list (list "href" "mailto:questions@FreeBSD.org"))
              (literal "questions@FreeBSD.org"))
            (literal ">.")
            (make empty-element gi: "br")
            (literal "For questions about this documentation, e-mail <")
              (make element gi: "a"
                    attributes: (list (list "href" "mailto:doc@FreeBSD.org"))
                (literal "doc@FreeBSD.org"))
	      (literal ">."))) 
      ]]>
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
