<!-- $FreeBSD$ -->
<!-- $FreeBSDru: frdp/doc/ru_RU.KOI8-R/books/porters-handbook/freebsd.dsl,v 1.2 2000/09/17 15:14:10 phantom Exp $ -->

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
            (literal "По вопросам связанным с системой портов для FreeBSD, пишите по адресу <")
            (make element gi: "a"
                  attributes: (list (list "href" "mailto:ports@freebsd.org"))
              (literal "ports@freebsd.org"))
            (literal ">.")
            (make empty-element gi: "br")
            (literal "По вопросам связанным с этом документацией, пишите по адресу <")
              (make element gi: "a"
                    attributes: (list (list "href" "mailto:doc@freebsd.org"))
                (literal "doc@freebsd.org"))
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
