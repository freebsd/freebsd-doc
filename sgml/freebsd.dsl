<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY dbstyle PUBLIC "-//Norman Walsh//DOCUMENT DocBook HTML Stylesheet//EN" CDATA DSSSL>
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>

      <!-- Configure the stylesheet using documented variables -->

      (define %gentext-nav-use-tables%
        ;; Use tables to build the navigation headers and footers?
        #f)

      (define %html-ext%
        ;; Default extension for HTML output files
        ".html")

      (define %shade-verbatim%
        ;; Should verbatim environments be shaded?
        #t)

      (define %use-id-as-filename%
        ;; Use ID attributes as name for component HTML files?
        #t)

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

      <!-- Tell the stylesheet about our local customisations -->
      
      (element hostid ($mono-seq$))
      (element username ($mono-seq$))
      (element devicename ($mono-seq$))
      (element maketarget ($mono-seq$))
      (element makevar ($mono-seq$))

      <!-- FAQList can wait. I've been drinking, and a brief glance at
           /usr/local/share/sgml/docbook/dsssl/modular/html/dblist.dsl is
           enough to bring me out in cold, Lisp induced sweats. . . -->
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="dbstyle">
</style-sheet>
