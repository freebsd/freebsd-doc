<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY dbstyle PUBLIC "-//Norman Walsh//DOCUMENT DocBook HTML Stylesheet//EN" CDATA DSSSL>
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>

      <!-- Configure the stylesheet using documented variables -->

      (define %stylesheet%
        "handbook.css")

      (define %gentext-nav-use-tables%
        ;; Use tables to build the navigation headers and footers?
        #t)

      (define %html-ext%
        ;; Default extension for HTML output files
        ".html")

      (define %shade-verbatim%
        ;; Should verbatim environments be shaded?
        #f)

      (define %use-id-as-filename%
        ;; Use ID attributes as name for component HTML files?
        #t)
 
      (define %root-filename%
        ;; Name for the root HTML document
        "index")

      <!-- Slightly deeper customisations -->

      <!-- I want things marked up with 'sgmltag' eg., 

              <para>You can use <sgmltag>para</sgmltag> to indicate
                paragraphs.</para>

           to automatically have the opening and closing braces inserted,
           and it should be in a mono-spaced font. -->

      (element sgmltag ($mono-seq$
          (make sequence
            (literal "<")
            (process-children)
            (literal ">"))))

      <!-- John Fieber's 'instant' translation specification had 
           '<command>' rendered in a mono-space font, and '<application>'
           rendered in bold. 

           Norm's stylesheet doesn't do this (although '<command>' is 
           rendered in bold).

           Configure the stylesheet to behave more like John's. -->

      (element command ($mono-seq$))

      (element application ($bold-seq$))

      <!-- Warnings and cautions are put in boxed tables to make them stand
           out. The same effect can be better achieved using CSS or similar,
           so have them treated the same as <important>, <note>, and <tip>
      -->
      (element warning ($admonition$))
      (element (warning title) (empty-sosofo))
      (element (warning para) ($admonpara$))
      (element (warning simpara) ($admonpara$))
      (element caution ($admonition$))
      (element (caution title) (empty-sosofo))
      (element (caution para) ($admonpara$))
      (element (caution simpara) ($admonpara$))

      (define usen-warning-label-title-sep ": ")
      (define usen-caution-label-title-sep ": ")

      <!-- Tell the stylesheet about our local customisations -->
      
      (element hostid ($mono-seq$))
      (element username ($mono-seq$))
      (element devicename ($mono-seq$))
      (element maketarget ($mono-seq$))
      (element makevar ($mono-seq$))

      <!-- FAQList can wait. I've been drinking, and a brief glance at
           /usr/local/share/sgml/docbook/dsssl/modular/html/dblist.dsl is
           enough to bring me out in cold, Lisp induced sweats. . . -->

      <!-- This replaces the existing mechanism for showing verbatim
           blocks of text (programlistings, screens, and so forth.

           Norm's stylesheet renders these in a table, with optional
           shading if %shade-verbatim% is set. Previous practice for
           the LinuxDoc DTD (and John Fieber's stylesheet) was to
           indent them using <blockquote>. Stick with previous practice.

           Norm says he will introduce a tweakable knob to affect this
           in the future. -->
(define ($verbatim-display$ line-numbers?)
  (let ((content (make element gi: "BLOCKQUOTE"
                       attributes: (list
                                    (list "CLASS" (gi)))
                       (make element gi: "PRE"
                           (if line-numbers?
                               ($verbatim-content-with-linenumbers$)
                               ($verbatim-content$))))))
    (if %shade-verbatim%
        (make element gi: "TABLE"
              attributes: ($shade-verbatim-attr$)
              (make element gi: "TR"
                    (make element gi: "TD"
                          content)))
        content)))

    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="dbstyle">
</style-sheet>
