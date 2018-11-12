<!--
	$FreeBSD$
	The FreeBSD Hungarian Documentation Project
	Translated by: Gabor Kovesdan <gabor@FreeBSD.org>
	%SOURCE%	en_US.ISO8859-1/share/sgml/freebsd.dsl
	%SRCID%		1.22
-->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>

<!ENTITY % freebsd.l10n PUBLIC "-//FreeBSD//ENTITIES DocBook Language Specific Entities//EN">
%freebsd.l10n;

<!ENTITY % output.html  "IGNORE"> 
<!ENTITY % output.print "IGNORE">
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
 
      <![ %output.html; [ 
	(define ($email-footer$)
          (make sequence
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"
                (literal "Ha kérdése van a FreeBSD-vel kapcsolatban, a következõ
		  címre írhat (angolul): <")
                (make element gi: "a"
                      attributes: (list (list "href" "mailto:freebsd-questions@FreeBSD.org"))
                  (literal "freebsd-questions@FreeBSD.org>."))
                (make empty-element gi: "br")
                (literal "Ha ezzel a dokumentummal kapcsolatban van kérdése,
		  kérjük erre a címre írjon: <")
                (make element gi: "a"
                      attributes: (list (list "href" "mailto:gabor@FreeBSD.org"))
                  (literal "gabor@FreeBSD.org>."))
	        ))))
          
	(define (local-hu-label-title-sep)
	  (list
	    (list (normalize "caution")		": ")
	    (list (normalize "warning")		": ")
	  ))
      ]]>
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
