<!--
     The FreeBSD Italian Documentation Project

     $FreeBSD$
     Original revision: 1.20
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

        (define ($email-footer$)
          (make sequence
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"
                (literal "Questo, ed altri documenti, possono essere scaricati da ")
                (create-link
                  (list (list "HREF" "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                  (literal "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                (literal ".")))
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"
                (literal "Per domande su FreeBSD, leggi la ")
                (create-link
                  (list (list "HREF" "http://www.FreeBSD.org/docs.html"))
                  (literal "documentazione"))
                (literal " prima di contattare <")
                (create-link
                  (list (list "HREF" "mailto:questions@FreeBSD.org"))
                  (literal "questions@FreeBSD.org"))
                (literal ">.")
                (make empty-element gi: "br")
                (literal "Per domande su questa documentazione, invia una e-mail a <")
                (create-link (list (list "HREF" "mailto:doc@FreeBSD.org"))
                  (literal "doc@FreeBSD.org"))
                (literal ">.")))))
      ]]>

      (define (local-it-label-title-sep)
        (list
          (list (normalize "warning")           ": ")
          (list (normalize "caution")           ": ")
          (list (normalize "chapter")           "  ")
          (list (normalize "sect1")             "  ")
          (list (normalize "sect2")             "  ")
          (list (normalize "sect3")             "  ")
          (list (normalize "sect4")             "  ")
          (list (normalize "sect5")             "  ")
          ))

    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
