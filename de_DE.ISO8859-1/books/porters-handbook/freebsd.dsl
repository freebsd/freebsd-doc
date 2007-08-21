<!--
     The FreeBSD Documentation Project
     The FreeBSD German Documentation Project
     $FreeBSD$
     $FreeBSDde: de-docproj/books/porters-handbook/freebsd.dsl,v 1.2 2007/07/29 11:57:54 jkois Exp $
     basiert auf:  1.5
-->
<!--
     Local DSSSL file for the Porter's Handbook.  This is so we can include
     a link to the -ports mailing list at the bottom of the HTML files,
     rather than the -questions mailing list.
-->

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
            (make empty-element gi: "br")
            (literal "Fragen zum FreeBSD Ports-System richten Sie bitte an <")
            (create-link (list (list "HREF" "mailto:ports@FreeBSD.org"))
              (literal "ports@FreeBSD.org"))
            (literal ">,")
            (literal "  Fragen zu diesem Dokument hingegen an <")
            (create-link (list (list "HREF" "mailto:de-bsd-translators@de.FreeBSD.org"))
              (literal "de-bsd-translators@de.FreeBSD.org"))
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
