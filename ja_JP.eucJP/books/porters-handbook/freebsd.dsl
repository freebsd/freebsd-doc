<!--
     The FreeBSD Documentation Project
     The FreeBSD Japanese Documentation Project

     Original revision: 1.2
     $FreeBSD$
-->

<!-- Local DSSSL file for the Porter's Handbook.  This is so we can include
     a link to the -ports mailing list at the bottom of the HTML files, 
     rather than the -questions mailing list. -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl SYSTEM "../../share/sgml/freebsd.dsl" CDATA DSSSL>
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
 
      <![ %output.html; [ 
	(define ($email-footer$)
          (make sequence
            (literal "FreeBSD ports システムに関する質問は、(英語で) <")
            (make element gi: "a"
                  attributes: (list (list "href" "mailto:ports@freebsd.org"))
              (literal "ports@freebsd.org"))
            (literal "> へ、")
            (make empty-element gi: "br")
            (literal "この文書の原文に関するお問い合わせは、(英語で) <")
              (make element gi: "a"
                    attributes: (list (list "href" "mailto:doc@freebsd.org"))
               (literal "doc@freebsd.org"))
	    (literal "> までお願いします。")))

	<!-- Convert " ... " to `` ... '' in the HTML output. -->
	(element quote
	  (make sequence
	    (literal "``")
	    (process-children)
	    (literal "''")))
      ]]>
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
