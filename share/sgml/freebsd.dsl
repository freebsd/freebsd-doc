<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY % output.html  "IGNORE">
<!ENTITY % output.print "IGNORE">
<!ENTITY % lang.ja      "IGNORE">
<!ENTITY % lang.ja.dsssl	"IGNORE">
<![ %output.html; [
<!ENTITY docbook.dsl PUBLIC "-//Norman Walsh//DOCUMENT DocBook HTML Stylesheet//EN" CDATA DSSSL>
]]>
<![ %output.print; [
<!ENTITY docbook.dsl PUBLIC "-//Norman Walsh//DOCUMENT DocBook Print Stylesheet//EN" CDATA DSSSL>
]]>
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
      <!-- Locatization -->
      <![ %lang.ja; [
	<![ %lang.ja.dsssl; [
	  (define %gentext-language% "ja")
	]]>
	(define %html-header-tags% '(("META" ("HTTP-EQUIV" "Content-Type") ("CONTENT" "text/html; charset=EUC-JP"))))
      ]]>

      <!-- HTML only .................................................... -->
      
      <![ %output.html; [
        <!-- Configure the stylesheet using documented variables -->

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

        (define html-manifest
          ;; Write a manifest?
          #f)

        <!-- Understand <segmentedlist> and related elements.  Simpleminded,
             and only works for the HTML output. -->

        (element segmentedlist
          (make element gi: "TABLE"
            (process-children)))

        (element seglistitem
          (make element gi: "TR"
            (process-children)))

        (element seg
          (make element gi: "TD"
                attributes: '(("VALIGN" "TOP"))
            (process-children)))

      ]]>

      <!-- Print only ................................................... --> 
      <![ %output.print; [

      ]]>

      <!-- Both sets of stylesheets ..................................... -->

      (define %section-autolabel%
        #t)

      (define %may-format-variablelist-as-table%
        #f)
      
      (define %indent-programlisting-lines%
        "    ")
 
      (define %indent-screen-lines%
        "    ")
      
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

      (define en-warning-label-title-sep ": ")
      (define en-caution-label-title-sep ": ")

      <!-- Tell the stylesheet about our local customisations -->
      
      (element hostid ($mono-seq$))
      (element username ($mono-seq$))
      (element devicename ($mono-seq$))
      (element maketarget ($mono-seq$))
      (element makevar ($mono-seq$))

      <!-- QAndASet ..................................................... -->

      <!-- Default to labelling Q/A with Q: and A: -->

      (define (qanda-defaultlabel)
        (normalize "qanda"))

      <!-- For the HTML version, display the questions in a bigger, bolder
           font. -->

      <![ %output.html [
      (element question
        (let* ((chlist   (children (current-node)))
               (firstch  (node-list-first chlist))
               (restch   (node-list-rest chlist)))
               (make element gi: "DIV"
                     attributes: (list (list "CLASS" (gi)))
                     (make element gi: "P" 
                           (make element gi: "BIG"
                                 (make element gi: "A"
                                       attributes: (list
                                                   (list "NAME" (element-id)))
                                       (empty-sosofo))
                                 (make element gi: "B"
                                       (literal (question-answer-label
                                                (current-node)) " ")
                                       (process-node-list (children firstch)))))
                    (process-node-list restch))))
      ]]>

    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="docbook.dsl">
</style-sheet>
