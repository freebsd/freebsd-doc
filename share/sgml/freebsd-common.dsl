<!-- $FreeBSD$ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY % freebsd.l10n PUBLIC "-//FreeBSD//ENTITIES DocBook Language Specific Entities//EN">
%freebsd.l10n;
<!ENTITY % freebsd.l10n-common PUBLIC "-//FreeBSD//ENTITIES DocBook Language Neutral Entities//EN">
%freebsd.l10n-common;

<!ENTITY % output.html  "IGNORE"> 
<!ENTITY % output.print "IGNORE">
]>

<style-sheet>
  <style-specification>
    <style-specification-body>

      (declare-flow-object-class formatting-instruction
        "UNREGISTERED::James Clark//Flow Object Class::formatting-instruction")

      (define %section-autolabel%
        #t)

      (define %label-preface-sections%
        #f)

      (define %may-format-variablelist-as-table%
        #f)

      (define %indent-programlisting-lines%
        #f)

      (define %indent-screen-lines%
        #f)

      (define (article-titlepage-recto-elements)
        (list (normalize "title")
              (normalize "subtitle")
              (normalize "corpauthor")
              (normalize "authorgroup")
              (normalize "author")
              (normalize "releaseinfo")
              (normalize "copyright")
              (normalize "pubdate")
              (normalize "revhistory")
              (normalize "legalnotice")
              (normalize "abstract")))

      (define %admon-graphics%
        ;; Use graphics in admonitions?
        #f)

      (define %admon-graphics-path%
        ;; Path to admonition images
        "./imagelib/admon/")

      (define ($admon-graphic$ #!optional (nd (current-node)))
        ;; Admonition graphic file
        (string-append %admon-graphics-path% (case-fold-down (gi nd)) ".png"))

      (define %show-all-trademark-symbols%
        ;; Show all the trademark symbols, not just the required
        ;; symbols.
        #f)

      <!-- Slightly deeper customisations -->

      <!-- We would like the author attributions to show up in line
           with the section they refer to.  Authors who made the same
           contribution should be listed in a single <authorgroup> and
           only one of the <author> elements should contain a <contrib>
           element that describes what the whole authorgroup was
           responsible for.  For example:

           <chapterinfo>
             <authorgroup>
               <author>
                 <firstname>Bob</firstname>
                 <surname>Jones</surname>
                 <contrib>Contributed by </contrib>
               </author>
               <author>
                 <firstname>Sarah</firstname>
                 <surname>Lee</surname>
               </author>
             </authorgroup>
           </chapterinfo>

           Would show up as "Contributed by Bob Jones and Sarah Lee".  Each
           authorgroup shows up as a separate sentence. -->


      (element chapterinfo
        (process-children))
      (element sect1info
        (process-children))
      (element sect2info
        (process-children))
      (element sect3info
        (process-children))
      (element sect4info
        (process-children))
      (element sect5info
        (process-children))
      (element (chapterinfo authorgroup author)
        (literal (author-list-string)))
      (element (sect1info authorgroup author)
        (literal (author-list-string)))
      (element (sect2info authorgroup author)
        (literal (author-list-string)))
      (element (sect3info authorgroup author)
        (literal (author-list-string)))
      (element (sect4info authorgroup author)
        (literal (author-list-string)))
      (element (sect5info authorgroup author)
        (literal (author-list-string)))

      (define (custom-authorgroup)
        ($italic-seq$
          (make sequence
            (process-node-list (select-elements (descendants (current-node))
                                  (normalize "contrib")))
            (process-children)
            (literal ".  "))))

      (element (chapterinfo authorgroup)
        (custom-authorgroup))
      (element (sect1info authorgroup)
        (custom-authorgroup))
      (element (sect2info authorgroup)
        (custom-authorgroup))
      (element (sect3info authorgroup)
        (custom-authorgroup))
      (element (sect4info authorgroup)
        (custom-authorgroup))
      (element (sect5info authorgroup)
        (custom-authorgroup))

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

      <!-- Add double quotes around <errorname> text. -->

      (element errorname
        (make sequence
          <![ %output.html;  [ (literal "&#8220;") ]]>
          ($mono-seq$ (process-children))
          <![ %output.html;  [ (literal "&#8221;") ]]>
          ))

      <!-- John Fieber's 'instant' translation specification had
           '<command>' rendered in a mono-space font, and '<application>'
           rendered in bold.

           Norm's stylesheet doesn't do this (although '<command>' is
           rendered in bold).

           Configure the stylesheet to behave more like John's. -->

      (element command ($mono-seq$))
      (element envar ($mono-seq$))

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

      <!-- Tell the stylesheet about our local customisations -->

      (element hostid
        (if %hyphenation%
          (urlwrap)
          ($mono-seq$)))
      (element username ($mono-seq$))
      (element groupname ($mono-seq$))
      (element devicename ($mono-seq$))
      (element maketarget ($mono-seq$))
      (element makevar ($mono-seq$))

      <!-- Override generate-anchor.  This is used to generate a unique ID for
           each element that can be linked to.  The element-id function calls
           this one if there's no ID attribute that it can use.  Normally, we
           would just use the current element number.  However, if it's a
           a question then use the question's number, as determined by the
           question-answer-label function.

           This generates anchors of the form "Qx.y.", where x.y is the
           question label.  This will probably break if question-answer-label
           is changed to generate something that might be the same for two
           different questions (for example, if question numbering restarts
           for each qandaset. -->
      (define (generate-anchor #!optional (nd (current-node)))
        (cond
          ((equal? (gi nd) (normalize "question"))
            (string-append "Q" (question-answer-label)))
          (else
            (string-append "AEN" (number->string (all-element-number nd))))))

      (define (xref-biblioentry target)
        (let* ((abbrev (node-list-first
                        (node-list-filter-out-pis (children target))))
               (label  (attribute-string (normalize "xreflabel") target)))

          (if biblio-xref-title
              (let* ((citetitles (select-elements (descendants target)
                                                  (normalize "citetitle")))
                     (titles     (select-elements (descendants target)
                                                  (normalize "title")))
                     (isbn       (select-elements (descendants target)
                                                  (normalize "isbn")))
                     (publisher  (select-elements (descendants target)
                                                  (normalize "publishername")))
                     (title      (if (node-list-empty? citetitles)
                                     (node-list-first titles)
                                     (node-list-first citetitles))))
                (with-mode xref-title-mode
                  (make sequence
                    (process-node-list title))))
              (if biblio-number
                  (make sequence
                    (literal "[" (number->string (bibentry-number target)) "]"))
                  (if label
                      (make sequence
                        (literal "[" label "]"))
                      (if (equal? (gi abbrev) (normalize "abbrev"))
                          (make sequence
                            (process-node-list abbrev))
                          (make sequence
                            (literal "[" (id target) "]"))))))))

       <!-- The (create-link) procedure should be used by all FreeBSD
 	   stylesheets to create links.  It calls (can-link-here) to
 	   determine whether it's okay to make a link in the current
 	   position.

 	   This check is necessary because links aren't allowed in,
 	   for example, <question> tags since the latter cause links
 	   to be created by themselves.  Obviously, nested links lead
 	   to all kinds of evil.  This normally wouldn't be a problem
 	   since no one in their right mind will put a <ulink> or
 	   <link> in a <question>, but it comes up when someone uses,
 	   say, a man page entity (e.g., &man.ls.1;); the latter may
 	   cause a link to be created, but its use inside a <question>
 	   is perfectly legal.

 	   The (can-link-here) routine isn't perfect; in fact, it's a
 	   hack and an ugly one at that.  Ideally, it would detect if
 	   the currect output would wind up in an <a> tag and return
 	   #f if that's the case.  Slightly less ideally it would
 	   check the current mode and return #f if, say, we're
 	   currently in TOC mode.  Right now, it makes a best guess
 	   attempt at guessing which tags might cause links to be
 	   generated.  -->
      (define (can-link-here)
 	(cond ((has-ancestor-member? (current-node)
				     '("TITLE" "QUESTION")) #f)
 	      (#t #t)))

      (define (create-link attrlist target)
 	(if (can-link-here)
 	    (make element gi: "A"
 		  attributes: attrlist
 		  target)
	    target))

      ;; Standard boolean XNOR (NOT Exclusive OR).
      (define (xnor x y)
	(or (and x y)
	    (and (not x) (not y))))

      ;; Standard boolean XOR (Exclusive OR).
      (define (xor x y)
	(not (xnor x y)))

      ;; Determine if a given node is in a title.
      (define (is-in-title? node)
	(has-ancestor-member? node (list (normalize "title"))))

      ;; Number of references to a trademark before the current
      ;; reference in each chunk.  Trademarks in title tags, and
      ;; trademarks in normal text (actually just text that is not in
      ;; title tags) are counted separately.
      (define ($chunk-trademark-number$ trademark)
	(let* ((trademarks (select-elements
			    (descendants (chunk-parent trademark))
			    (normalize "trademark"))))
	  (let loop ((nl trademarks) (num 1))
	    (if (node-list-empty? nl)
		num
		(if (node-list=? (node-list-first nl) trademark)
		    num
		    (if (and (string=? (data trademark)
				       (data (node-list-first nl)))
			     (xnor (is-in-title? trademark)
				   (is-in-title? (node-list-first nl))))
			(loop (node-list-rest nl) (+ num 1))
			(loop (node-list-rest nl) num)))))))

      ;; Determine if we should show a trademark symbol.  Either in
      ;; first occurrence in the proper context, if the role
      ;; attribute is set to force, or if %show-all-trademark-symbols%
      ;; is set to true.
      (define (show-tm-symbol? trademark)
	(or %show-all-trademark-symbols%
	    (= ($chunk-trademark-number$ trademark) 1)
	    (equal? (attribute-string (normalize "role") trademark) "force")))

	(element (acronym remark)
	  (let* ((role (attribute-string (normalize "role"))))
	    (if (not (equal? role "acronym"))
		($charseq$)
		(empty-sosofo))))

      (define (local-en-label-title-sep)
        (list
          (list (normalize "warning")		": ")
	  (list (normalize "caution")		": ")
          (list (normalize "chapter")           "  ")
          (list (normalize "sect1")             "  ")
          (list (normalize "sect2")             "  ")
          (list (normalize "sect3")             "  ")
          (list (normalize "sect4")             "  ")
          (list (normalize "sect5")             "  ")
          ))

    </style-specification-body>
  </style-specification>
</style-sheet>
