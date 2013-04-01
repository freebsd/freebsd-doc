<!-- $FreeBSD$ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY % output.rtf.images 	"IGNORE">
<!ENTITY % output.print 	"IGNORE">
]>

<style-sheet>
  <style-specification>
    <style-specification-body>

      (declare-flow-object-class formatting-instruction
        "UNREGISTERED::James Clark//Flow Object Class::formatting-instruction")

      <!-- RTF with images  ............................................ -->

      <![ %output.rtf.images [

	(define %graphic-default-extension%
	  "png")

	(define %callout-graphics%
	  ;; Use graphics in callouts?
	  #f)
      ]]>

      <!-- Print only ................................................... -->
      <![ %output.print; [
        (define withpgpkeys
          #f)

        ;; If a link is entered as "file://localhost/usr/ports" in the docs
        ;; then we only want to display "/usr/ports" in printed form.

        (define (fix-url url)
          (if (and (> (string-length url) 15)
		   (string=? (substring url 0 16) "file://localhost"))
              (substring url 16 (string-length url))
              url))


        (element (primaryie ulink)
          (indexentry-link (current-node)))
        (element (secondaryie ulink)
          (indexentry-link (current-node)))
        (element (tertiaryie ulink)
          (indexentry-link (current-node)))

	;; Override the count-footnote? definition from dbblock.dsl
	;; to fix a bug.  Basically, the original procedure would count
	;; all ulink elements when doing %footnote-ulinks%.  It's
	;; actually harder than that, because ulink elements with no
	;; content shouldn't generate footnotes (the ulink element
	;; definition just inserts the url attribute in-line, thus there
	;; is no need for a footnote with the url).  So, when we figure
	;; out which footnotes to count for the purpose of determining
	;; footnote numbers, we only count the ulink elements containing
	;; content.
	(define (count-footnote? footnote)
	  ;; don't count footnotes in comments (unless you're showing comments)
	  ;; or footnotes in tables which are handled locally in the table
	  (if (or (and (has-ancestor-member? footnote (list (normalize "comment")))
		       (not %show-comments%))
		  (has-ancestor-member? footnote (list (normalize "tgroup")))
		  (and (has-ancestor-member? footnote (list (normalize "ulink")))
		       (node-list-empty? (children footnote))))
	      #f
	      #t))

        (element ulink
          (make sequence
            (if (node-list-empty? (children (current-node)))
   	      (literal (fix-url (attribute-string (normalize "url"))))
  	      (make sequence
	        ($charseq$)
	        (if %footnote-ulinks%
		    (if (and (equal? (print-backend) 'tex) bop-footnotes)
		      (make sequence
			    ($ss-seq$ + (literal (footnote-number (current-node))))
			    (make page-footnote
			          (make paragraph
			font-size: (* %footnote-size-factor% %bf-size%)
			font-posture: 'upright
			quadding: %default-quadding%
			line-spacing: (* (* %footnote-size-factor% %bf-size%)
					 %line-spacing-factor%)
			space-before: %para-sep%
			space-after: %para-sep%
			start-indent: %footnote-field-width%
			first-line-start-indent: (- %footnote-field-width%)
			(make line-field
			  field-width: %footnote-field-width%
			  (literal (footnote-number (current-node))
				   (gentext-label-title-sep (normalize "footnote"))))
			(literal (fix-url (attribute-string (normalize "url")))))))
		      ($ss-seq$ + (literal (footnote-number (current-node)))))
	            (if (and %show-ulinks%
		             (not (equal? (fix-url (attribute-string (normalize "url")))
				          (data-of (current-node)))))
  	   	        (make sequence
		          (literal " (")
			  (if %hyphenation%
			      (make formatting-instruction data:
				    (string-append "\\url{"
						   (fix-url (attribute-string
							     (normalize "url")))
						   "}"))
			      (literal (fix-url (attribute-string (normalize "url")))))
		          (literal ")"))
		        (empty-sosofo)))))))


        (define (toc-depth nd)
          (if (string=? (gi nd) (normalize "book"))
              3
              1))

        (element programlisting
          (if (and (equal? (attribute-string (normalize "role")) "pgpkey")
		   (not withpgpkeys))
              (empty-sosofo)
              (next-match)))

        (element legalnotice
          (if (equal? (attribute-string (normalize "role")) "trademarks")
	      (make sequence
	          (process-children))
              (next-match)))

        (define %body-start-indent%
          0pi)

        (define (book-titlepage-verso-elements)
          (list (normalize "title")
                (normalize "subtitle")
                (normalize "corpauthor")
                (normalize "authorgroup")
                (normalize "author")
                (normalize "editor")
                (normalize "edition")
                (normalize "pubdate")
                (normalize "copyright")
                (normalize "abstract")
                (normalize "legalnotice")
                (normalize "revhistory")
                (normalize "isbn")))

        ;; Norm's stylesheets are smart about working out what sort of
        ;; object to display.  But this bites us.  Since we know that the
        ;; first item is going to be displayable, always use that.
        (define (find-displayable-object objlist notlist extlist)
          (let loop ((nl objlist))
            (if (node-list-empty? nl)
              (empty-node-list)
                (let* ((objdata  (node-list-filter-by-gi
                                  (children (node-list-first nl))
                                  (list (normalize "videodata")
                                        (normalize "audiodata")
                                        (normalize "imagedata"))))
                       (filename (data-filename objdata))
                       (extension (file-extension filename))
                       (notation (attribute-string (normalize "format") objdata)))
                  (node-list-first nl)))))

        ;; Printed formats always use .eps images.
        (define %graphic-default-extension%
          "eps")


        ;; Including bitmaps in the PS and PDF output tends to scale them
        ;; horribly.  The solution is to scale them down by 50%.
        ;;
        ;; You could do this with 'imagedata scale="50"'  in the source,
        ;; but that will affect all the output formats that we use (because
        ;; there is only one 'imagedata' per image).
        ;;
        ;; Solution is to have the authors include the "FORMAT" attribute,
        ;; set to PNG or EPS as appropriate, but to omit the extension.
	;; If we're using the tex-backend, and the FORMAT is PNG, and the
        ;; author hasn't already set a scale, then set scale to 0.5.
        ;; Otherwise, use the supplied scale, or 1, as appropriate.
        (define ($graphic$ fileref
                           #!optional (display #f) (format #f)
                                      (scale #f)   (align #f))
          (let* ((graphic-format (if format format ""))
                 (graphic-scale  (if scale
                                     (/  (string->number scale) 100)
                                     (if (and tex-backend
                                              (equal? graphic-format "PNG"))
                                          0.5 1)))
                 (graphic-align  (cond ((equal? align (normalize "center"))
                                        'center)
                                       ((equal? align (normalize "right"))
                                        'end)
                                       (else
                                        'start))))
           (make external-graphic
              entity-system-id: (graphic-file fileref)
              notation-system-id: graphic-format
              scale: graphic-scale
              display?: display
              display-alignment: graphic-align)))

	;; Display TeX and LaTeX properly by sending direct formatting
	;; commands to the TeX backend.

	(element application
	  (if (equal? "TeX" (data (current-node)))
	    (make formatting-instruction data:
		"\\TeX{}")
	      (if (equal? "LaTeX" (data (current-node)))
		  (make formatting-instruction data:
		      "\\LaTeX{}")
			($bold-seq$))))

	;; The special FreeBSD version of the trademark tag handling.
	;; This function was more or less taken from the DocBook DSSSL
	;; stylesheets by Norman Walsh.
	(element trademark
	  (if (show-tm-symbol? (current-node))
	      (make sequence
		($charseq$)
		(cond
		 ((equal? (attribute-string "class") (normalize "copyright"))
		  (literal "\copyright-sign;"))
		 ((equal? (attribute-string "class") (normalize "registered"))
		  (literal "\registered-sign;"))
		 ((equal? (attribute-string "class") (normalize "service"))
		  ($ss-seq$ + (literal "SM")))
		 (else
		  (literal "\trade-mark-sign;"))))
	      ($charseq$)))

	;; Make the trademark functions think print output has chunks.
	(define (chunk-parent nd)
	  (sgml-root-element nd))

      (define minimal-section-labels #f)
      (define max-section-level-labels
        (if minimal-section-labels 3 10))

      (define ($section-title$)
        (let* ((sect (current-node))
      	       (info (info-element))
	       (exp-children (if (node-list-empty? info)
		 	         (empty-node-list)
			         (expand-children (children info)
					          (list (normalize "bookbiblio")
						        (normalize "bibliomisc")
						        (normalize "biblioset")))))
	       (parent-titles (select-elements (children sect) (normalize "title")))
  	       (info-titles   (select-elements exp-children (normalize "title")))
	       (titles        (if (node-list-empty? parent-titles)
		   	          info-titles
			          parent-titles))
	       (subtitles     (select-elements exp-children (normalize "subtitle")))
	       (renderas (inherited-attribute-string (normalize "renderas") sect))
	       (hlevel                          ;; the apparent section level;
	        (if renderas                    ;; if not real section level,
  	            (string->number             ;;   then get the apparent level
	             (substring renderas 4 5))  ;;   from "renderas",
	            (SECTLEVEL)))               ;; else use the real level
	       (hs (HSIZE (- 4 hlevel))))

          (make sequence
            (make paragraph
 	      font-family-name: %title-font-family%
	      font-weight:  (if (< hlevel 5) 'bold 'medium)
	      font-posture: (if (< hlevel 5) 'upright 'italic)
	      font-size: hs
	      line-spacing: (* hs %line-spacing-factor%)
	      space-before: (* hs %head-before-factor%)
	      space-after: (if (node-list-empty? subtitles)
	    	  	       (* hs %head-after-factor%)
	 	  	       0pt)
	      start-indent: (if (or (>= hlevel 3)
			            (member (gi) (list (normalize "refsynopsisdiv")
					    	       (normalize "refsect1")
						       (normalize "refsect2")
						       (normalize "refsect3"))))
	 		        %body-start-indent%
			        0pt)
	      first-line-start-indent: 0pt
	      quadding: %section-title-quadding%
	      keep-with-next?: #t
	      heading-level: (if %generate-heading-level% (+ hlevel 1) 0)
  	      ;; SimpleSects are never AUTO numbered...they aren't hierarchical
	      (if (> hlevel (- max-section-level-labels 1))
	          (empty-sosofo)
	          (if (string=? (element-label (current-node)) "")
	  	      (empty-sosofo)
		      (literal (element-label (current-node))
			       (gentext-label-title-sep (gi sect)))))
	      (element-title-sosofo (current-node)))
            (with-mode section-title-mode
	      (process-node-list subtitles))
            ($section-info$ info))))

	;; Expand a literal tab character to spaces in elements like
	;; programlisting.
	(define %default-tab-spacing% 8)

	(define ($verbatim-display$ indent line-numbers?)
	  (let* ((width-in-chars (if (attribute-string (normalize "width"))
				     (string->number
				       (attribute-string (normalize "width")))
				     %verbatim-default-width%))
		 (fsize (lambda () (if (or (attribute-string (normalize "width"))
					   (not %verbatim-size-factor%))
				       (/ (/ (- %text-width%
						(inherited-start-indent))
					     width-in-chars)
					  0.7)
				       (* (inherited-font-size)
					  %verbatim-size-factor%))))
		 (vspace-before (if (INBLOCK?)
				    0pt
				    (if (INLIST?)
					%para-sep%
					%block-sep%)))
		 (vspace-after (if (INBLOCK?)
				   0pt
				   (if (INLIST?)
				       0pt
				       %block-sep%))))
		(make paragraph
			use: verbatim-style
			space-before: (if (and (string=? (gi (parent))
							 (normalize "entry"))
					       (absolute-first-sibling?))
					0pt
					vspace-before)
			space-after:  (if (and (string=? (gi (parent))
							 (normalize "entry"))
					       (absolute-last-sibling?))
					0pt
					vspace-after)
			font-size: (fsize)
			line-spacing: (* (fsize) %line-spacing-factor%)
			start-indent: (if (INBLOCK?)
					(inherited-start-indent)
					(+ %block-start-indent%
					   (inherited-start-indent)))
		 (if (or indent line-numbers?)
			($linespecific-line-by-line$ indent line-numbers?)
			(let loop ((kl (children (current-node)))
				   (tabsp %default-tab-spacing%)
				   (res (empty-sosofo)))
			  (if (node-list-empty? kl)
			      res
			      (loop
			       (node-list-rest kl)
			       (cond
				((char=? (node-property
					  'char (node-list-first kl)
					  default: #\U-0000) #\U-0009)
				 %default-tab-spacing%)
				((char=? (node-property
					  'char (node-list-first kl)
					  default: #\U-0000) #\U-000D)
				 %default-tab-spacing%)
				(#t ;; normal char or element node
				 (- (if (= (modulo tabsp %default-tab-spacing%) 0)
					%default-tab-spacing%
					(modulo tabsp %default-tab-spacing%))
				    (modulo (string-length (data (node-list-first kl)))
					    %default-tab-spacing%))))
			       (let ((c (node-list-first kl)))
				 (if (char=? (node-property
					      'char c
					      default: #\U-0000) #\U-0009)
				     (sosofo-append res
						    (let sploop
							((spc
							  (if (= tabsp 0)
							      %default-tab-spacing%
							      tabsp)))
						      (if (> spc 0)
							  (sosofo-append
							   (literal " ")
							   (sploop (- spc 1)))
							  (empty-sosofo))))
				     (sosofo-append res
						    (process-node-list c)))))))))))
      ]]>

    </style-specification-body>
  </style-specification>
</style-sheet>
