<!--
	$FreeBSD$
	$FreeBSDde: de-docproj/share/sgml/freebsd.dsl,v 1.12 2003/04/23 22:35:56 mheinen Exp $
	basiert auf: 1.18
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
                (literal "Wenn Sie Fragen zu FreeBSD haben, schicken Sie eine E-Mail an <")
                (make element gi: "a"
                      attributes: (list (list "href" "mailto:de-bsd-questions@de.FreeBSD.org"))
                  (literal "de-bsd-questions@de.FreeBSD.org"))
                (literal ">.")
                (make empty-element gi: "br")
                (literal "Wenn Sie Fragen zu dieser Dokumentation haben, schicken Sie eine E-Mail an <")
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
        (define ($create-refentry-xref-link$ #!optional (n (current-node)))
          (let* ((r (select-elements (children n) (normalize "refentrytitle")))
                 (m (select-elements (children n) (normalize "manvolnum")))
                 (v (attribute-string (normalize "vendor") n))
                 (u (string-append "http://www.FreeBSD.org/cgi/man.cgi?query="
                         (data r) "&" "sektion=" (data m))))
            (case v
              (("current") (string-append u "&" "manpath=FreeBSD+5.0-current"))
              (("xfree86") (string-append u "&" "manpath=XFree86+4.2.0"))
              (("netbsd")  (string-append u "&" "manpath=NetBSD+1.5"))
              (("ports")   (string-append u "&" "manpath=FreeBSD+Ports"))
              (else u))))
      ]]>
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
