<!--	$FreeBSDde: de-docproj/share/sgml/freebsd.dsl,v 1.6 2001/05/07 20:27:46 ue Exp $
	$FreeBSD$ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>
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
                (literal "Wenn Sie Fragen zu FreeBSD haben, schicken Sie eine EMail an <")
                (make element gi: "a"
                      attributes: (list (list "href" "mailto:de-bsd-questions@de.FreeBSD.org"))
                  (literal "de-bsd-questions@de.FreeBSD.org"))
                (literal ">.")
                (make empty-element gi: "br")
                (literal "Wenn Sie Fragen zu dieser Dokumentation haben, schicken Sie eine Email an <")
                (make element gi: "a"
                      attributes: (list (list "href" "mailto:de-bsd-translators@de.FreeBSD.org"))
                  (literal "de-bsd-translators@de.FreeBSD.org"))
	        (literal ">.")))))


	<!-- Convert " ... " to `` ... '' in the HTML output. -->
	(element quote
	  (make sequence
	    (literal "``")
	    (process-children)
	    (literal "''")))

        <!-- Generate links to HTML man pages -->
        (define %refentry-xref-link% #t)

        <!-- Specify how to generate the man page link HREF -->
        (define ($create-refentry-xref-link$ refentrytitle manvolnum)
          (string-append "http://www.FreeBSD.org/cgi/man.cgi?query="
			refentrytitle "&" "sektion=" manvolnum))
      ]]>
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
