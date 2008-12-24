<!-- $FreeBSD$ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY % output.rtf.images 	"IGNORE">
<!ENTITY % output.print 	"IGNORE">
<!ENTITY % output.print.pdf 	"IGNORE">
<!ENTITY % output.print.justify	"IGNORE">
<!ENTITY % output.print.twoside	"IGNORE">

<!ENTITY % freebsd.l10n PUBLIC "-//FreeBSD//ENTITIES DocBook Language Specific Entities//EN">
%freebsd.l10n;
<!ENTITY % freebsd.l10n-common PUBLIC "-//FreeBSD//ENTITIES DocBook Language Neutral Entities//EN">
%freebsd.l10n-common;
]]>
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

      <!-- Two-sided Print output ....................................... -->
      <![ %output.print.twoside; [

      ;; From an email by Ian Castle to the DocBook-apps list

      (define ($component$)
        (make simple-page-sequence
          page-n-columns: %page-n-columns%
          page-number-restart?: (or %page-number-restart%
;			      (book-start?)
				    (first-chapter?))
          page-number-format: ($page-number-format$)
          use: default-text-style
          left-header:   ($left-header$)
          center-header: ($center-header$)
          right-header:  ($right-header$)
          left-footer:   ($left-footer$)
          center-footer: ($center-footer$)
          right-footer:  ($right-footer$)
          start-indent: %body-start-indent%
          input-whitespace-treatment: 'collapse
          quadding: %default-quadding%
          (make sequence
	    ($component-title$)
	    (process-children))
          (make-endnotes)))

      ;; From an email by Ian Castle to the DocBook-apps list

      (define (first-part?)
        (let* ((book (ancestor (normalize "book")))
	       (nd   (ancestor-member (current-node)
				      (append
				       (component-element-list)
				       (division-element-list))))
	       (bookch (children book)))
        (let loop ((nl bookch))
	  (if (node-list-empty? nl)
	      #f
	      (if (equal? (gi (node-list-first nl)) (normalize "part"))
		  (if (node-list=? (node-list-first nl) nd)
		      #t
		      #f)
		  (loop (node-list-rest nl)))))))


      ;; From an email by Ian Castle to the DocBook-apps list

      (define (first-chapter?)
      ;; Returns #t if the current-node is in the first chapter of a book
        (if (has-ancestor-member? (current-node) (division-element-list))
          #f
         (let* ((book (ancestor (normalize "book")))
                (nd   (ancestor-member (current-node)
				       (append (component-element-list)
					       (division-element-list))))
		(bookch (children book))
		(bookcomp (expand-children bookch (list (normalize "part")))))
	   (let loop ((nl bookcomp))
	     (if (node-list-empty? nl)
		 #f
		 (if (equal? (gi (node-list-first nl)) (normalize "chapter"))
		     (if (node-list=? (node-list-first nl) nd)
			 #t
			 #f)
		     (loop (node-list-rest nl))))))))


      ; By default, the Part I title page will be given a roman numeral,
      ; which is wrong so we have to fix it

      (define (part-titlepage elements #!optional (side 'recto))
        (let ((nodelist (titlepage-nodelist
			 (if (equal? side 'recto)
			     (part-titlepage-recto-elements)
			     (part-titlepage-verso-elements))
			 elements))
	      ;; partintro is a special case...
	      (partintro (node-list-first
			  (node-list-filter-by-gi elements (list (normalize "partintro"))))))
          (if (part-titlepage-content? elements side)
	      (make simple-page-sequence
		page-n-columns: %titlepage-n-columns%
		;; Make sure that page number format is correct.
		page-number-format: ($page-number-format$)
		;; Make sure that the page number is set to 1 if this is the first part
		;; in the book
		page-number-restart?: (first-part?)
		input-whitespace-treatment: 'collapse
		use: default-text-style

		;; This hack is required for the RTF backend. If an
		;; external-graphic is the first thing on the page,
		;; RTF doesn't seem to do the right thing (the graphic
		;; winds up on the baseline of the first line of the
		;; page, left justified).  This "one point rule" fixes
		;; that problem.

		(make paragraph
		  line-spacing: 1pt
		  (literal ""))

		(let loop ((nl nodelist) (lastnode (empty-node-list)))
		  (if (node-list-empty? nl)
		      (empty-sosofo)
		      (make sequence
			(if (or (node-list-empty? lastnode)
				(not (equal? (gi (node-list-first nl))
					     (gi lastnode))))
			    (part-titlepage-before (node-list-first nl) side)
			    (empty-sosofo))
			(cond
			 ((equal? (gi (node-list-first nl)) (normalize "subtitle"))
			  (part-titlepage-subtitle (node-list-first nl) side))
			 ((equal? (gi (node-list-first nl)) (normalize "title"))
			  (part-titlepage-title (node-list-first nl) side))
			 (else
			  (part-titlepage-default (node-list-first nl) side)))
			(loop (node-list-rest nl) (node-list-first nl)))))
		(if (and %generate-part-toc%
			 %generate-part-toc-on-titlepage%
			 (equal? side 'recto))
		    (make display-group
		      (build-toc (current-node)
				 (toc-depth (current-node))))
		    (empty-sosofo))

		;; PartIntro is a special case
		(if (and (equal? side 'recto)
			 (not (node-list-empty? partintro))
			 %generate-partintro-on-titlepage%)
		    ($process-partintro$ partintro #f)
		    (empty-sosofo)))
	      (empty-sosofo))))

      ]]>

      <!-- Print with justification ..................................... -->
      <![ %output.print.justify; [

        (define %default-quadding%
          'justify)

        (define %hyphenation%
          #t)


        ;; The url.sty package is making all of the links purple/pink.
        ;; Someone please fix this!

        (define (urlwrap)
          (let ((%factor% (if %verbatim-size-factor%
			      %verbatim-size-factor%
			      1.0)))
          (make sequence
	    font-family-name: %mono-font-family%
	    font-size: (* (inherited-font-size) %factor%)
	    (make formatting-instruction data:
		  (string-append
		   "\\url|"
		   (data (current-node))
		   "|")))))

        (define (pathwrap)
          (let ((%factor% (if %verbatim-size-factor%
			      %verbatim-size-factor%
			      1.0)))
          (make sequence
	    font-family-name: %mono-font-family%
	    font-size: (* (inherited-font-size) %factor%)
	    (make formatting-instruction data:
		  (string-append
		   "\\path|"
		   (data (current-node))
		   "|")))))

        ;; Some others may check the value of %hyphenation% and be
        ;; specified below

;        (element email
;          (make sequence
;            (literal "<")
;            (urlwrap)
;            (literal ">")))

        (element filename
	    (pathwrap))

        (element varname
	    (pathwrap))

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

        ;; When selecting a filename to use, don't append the default
        ;; extension, instead, just use the bare filename, and let TeX
        ;; work it out.  jadetex will use the .eps file, while pdfjadetex
        ;; will use the .png file automatically.
        (define (graphic-file filename)
          (let ((ext (file-extension filename)))
            (if (or tex-backend   ;; TeX can work this out itself
                    (not filename)
                    (not %graphic-default-extension%)
                    (member ext %graphic-extensions%))
                 filename
                 (string-append filename "." %graphic-default-extension%))))

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

      ]]>

      <![ %output.print.pdf; [

      ]]>

    </style-specification-body>
  </style-specification>
</style-sheet>
