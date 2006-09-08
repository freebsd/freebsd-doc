<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$
     $FreeBSDru: frdp/doc/ru_RU.KOI8-R/books/porters-handbook/freebsd.dsl,v 1.6 2006/09/08 13:59:56 den Exp $

     Original revision: 1.5
-->

<!-- Local DSSSL file for the Porter's Handbook.  This is so we can include
     a link to the -ports mailing list at the bottom of the HTML files, 
     rather than the -questions mailing list. -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl SYSTEM "../../share/sgml/freebsd.dsl" CDATA DSSSL>
<!ENTITY % output.html  "IGNORE">
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
 
      <![ %output.html; [ 
	(define ($email-footer$)
          (make sequence
            (literal "По вопросам связанным с системой портов для FreeBSD, пишите по адресу <")
            (create-link (list (list "HREF" "mailto:ports@FreeBSD.org"))
              (literal "ports@FreeBSD.org"))
            (literal ">.")
            (make empty-element gi: "br")
            (literal "По вопросам, связанным с этой документацией, пишите по адресу <")
            (create-link (list (list "HREF" "mailto:doc@FreeBSD.org"))
              (literal "doc@FreeBSD.org"))
            (literal ">.")))

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
