<!--
     The FreeBSD Documentation Project
     The FreeBSD French Documentation Project

     $Id: freebsd.dsl,v 1.11 2002-12-11 20:06:19 blackend Exp $
     $FreeBSD$
     Original revision: 1.17

-->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>
<!ENTITY % output.html  "IGNORE">
<!ENTITY % output.print "IGNORE">
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
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"
                (literal "Ce document, ainsi que d'autres peut être téléchargé sur ")
                (make element gi: "a"
                      attributes: (list (list "href" "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc"))
                  (literal "ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                (literal ".")))
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"  
                (literal "Pour toutes questions à propos de FreeBSD, lisez la ")
                (make element gi: "a"
                      attributes: (list (list "href" "http://www.freebsd.org/docs.html"))
                  (literal "documentation"))
                (literal " avant de contacter <")
                (make element gi: "a"
                      attributes: (list (list "href" "mailto:questions@FreeBSD.org"))
                  (literal "questions@FreeBSD.org"))
                (literal ">.")
                (make empty-element gi: "br")
                (literal "Pour les questions sur cette documentation, contactez <")
                (make element gi: "a"
                      attributes: (list (list "href" "mailto:doc@FreeBSD.org"))
                  (literal "doc@FreeBSD.org"))
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
