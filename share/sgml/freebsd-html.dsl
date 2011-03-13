<!-- $FreeBSD$ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY % output.html		"IGNORE">
<!ENTITY % output.html.images 	"IGNORE">

<!ENTITY % freebsd.l10n PUBLIC "-//FreeBSD//ENTITIES DocBook Language Specific Entities//EN">
%freebsd.l10n;
<!ENTITY % freebsd.l10n-common PUBLIC "-//FreeBSD//ENTITIES DocBook Language Neutral Entities//EN">
%freebsd.l10n-common;
]>

<style-sheet>
  <style-specification>
    <style-specification-body>

      (declare-flow-object-class formatting-instruction
        "UNREGISTERED::James Clark//Flow Object Class::formatting-instruction")

      <!-- HTML only .................................................... -->

      <![ %output.html; [
        <!-- Configure the stylesheet using documented variables -->

        (define %hyphenation% #f)        <!-- Silence a warning -->

        (define %html-header-tags% '(("META" ("HTTP-EQUIV" "Content-Type")
          ("CONTENT" "text/html; charset=&doc.html.charset;"))))

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

        (define %generate-legalnotice-link%
          ;; Should legal notices be a link to a separate file?
          ;;
          ;; Naturally, this has no effect if you're building one big
          ;; HTML file.
          #f)

        (define %generate-docformat-navi-link%
          ;; Create docformat navi link for HTML output?
          #f)

;; Taken from Norm's stylesheets; modified to add support for TITLE so
;; that we get a mouse over definition for acronyms in HTML output.

	(define ($acronym-seq$ #!optional (sosofo (process-children)))
	  (let* ((acronym-remark (select-elements
				  (children (current-node))
				  (normalize "remark"))))
	    (let* ((title (if (and acronym-remark
				   (equal? (attribute-string (normalize "role") acronym-remark) "acronym"))
			      (data acronym-remark)
			      "")))
	      (make element gi: "ACRONYM"
		    attributes: (list
				 (list "CLASS" (gi))
				 (list "TITLE" title))
		    sosofo))))

        (define (book-titlepage-recto-elements)
          (list (normalize "title")
                (normalize "subtitle")
                (normalize "graphic")
                (normalize "mediaobject")
                (normalize "corpauthor")
                (normalize "authorgroup")
                (normalize "author")
                (normalize "editor")
                (normalize "copyright")
                (normalize "abstract")
                (normalize "legalnotice")
                (normalize "isbn")))

        ;; Create a simple navigation link
        ;; if %generate-docformat-navi-link% defined.
        (define (make-docformat-navi tlist)
          (let ((rootgi (gi (sgml-root-element))))
            (make element gi: "DIV"
                  attributes: '(("CLASS" "DOCFORAMTNAVI"))
                  (literal "[ ")
                  (make-docformat-navi-link rootgi tlist)
                  (literal " ]"))))

        (define (make-docformat-navi-link rootgi tlist)
          (make sequence
            (cond
             ((null? tlist)               (empty-sosofo))
             ((null? (car tlist))         (empty-sosofo))
             ((not (symbol? (car tlist))) (empty-sosofo))
             ((equal? (car tlist) 'html-split)
              (make sequence
                (create-link (list (list "href" "./index.html"))
                             (literal "&docnavi.split-html;"))
                (if (not (null? (cdr tlist)))
                    (make sequence
                      (literal " / ")
                      (make-docformat-navi-link rootgi (cdr tlist)))
                    (empty-sosofo))))
             ((equal? (car tlist) 'html-single)
              (make sequence
                (create-link (list (list "href"
                                         (string-append "./" (case-fold-down rootgi) ".html")))
                             (literal "&docnavi.single-html;"))
                (if (not (null? (cdr tlist)))
                    (make sequence
                      (literal " / ")
                      (make-docformat-navi-link rootgi (cdr tlist)))
                    (empty-sosofo))))
             (else (empty-sosofo)))))

        (define (article-titlepage-separator side)
          (make sequence
            (if %generate-docformat-navi-link%
                (make-docformat-navi '(html-split html-single))
                (empty-sosofo))
            (make empty-element gi: "HR")))

        (define (book-titlepage-separator side)
          (if (equal? side 'recto)
              (make sequence
                (if %generate-docformat-navi-link%
                    (make-docformat-navi '(html-split html-single))
                    (empty-sosofo))
                (make empty-element gi: "HR"))
              (empty-sosofo)))

        <!-- This is the text to display at the bottom of each page.
             Defaults to nothing.  The individual stylesheets should
             redefine this as necessary. -->
        (define ($email-footer$)
          (empty-sosofo))

	(define html-index-filename
	  (if nochunks
	    "html.index"
	    "html-split.index"))

	(define %stylesheet%
	  "docbook.css")

        <!-- This code handles displaying $email-footer$ at the bottom
             of each page.

             If "nochunks" is turned on then we make sure that an <hr>
             is shown first.

             Then create a centered paragraph ("<p>"), and reduce the font
             size ("<small>").  Then run $email-footer$, which should
             create the text and links as necessary. -->
	(define ($html-body-end$)
          (if (equal? $email-footer$ (normalize ""))
            (empty-sosofo)
            (make sequence
              (if nochunks
                  (make empty-element gi: "hr")
                  (empty-sosofo))
              ($email-footer$))))

        (define %refentry-xref-link%
          ;; REFENTRY refentry-xref-link
          ;; PURP Generate URL links when cross-referencing RefEntrys?
          ;; DESC
          ;; If true, a web link will be generated, presumably
          ;; to an online man->HTML gateway.  The text of the link is
          ;; generated by the $create-refentry-xref-link$ function.
          ;; /DESC
          ;; AUTHOR N/A
          ;; /REFENTRY
          #t)

        <!-- Specify how to generate the man page link HREF -->
        (define ($create-refentry-xref-link$ #!optional (n (current-node)))
          (let* ((r (select-elements (children n) (normalize "refentrytitle")))
                 (m (select-elements (children n) (normalize "manvolnum")))
                 (v (attribute-string (normalize "vendor") n))
                 (u (string-append "http://www.FreeBSD.org/cgi/man.cgi?query="
                         (data r) "&" "amp;" "sektion=" (data m))))
            (case v
              (("current") (string-append u "&" "amp;" "manpath=FreeBSD+9-current"))
              (("xfree86") (string-append u "&" "amp;" "manpath=XFree86+4.7.0"))
              (("xorg")    (string-append u "&" "amp;" "manpath=X11R7.4"))
              (("netbsd")  (string-append u "&" "amp;" "manpath=NetBSD+5.1"))
              (("openbsd") (string-append u "&" "amp;" "manpath=OpenBSD+4.7"))
              (("ports")   (string-append u "&" "amp;" "manpath=FreeBSD+8.2-RELEASE+and+Ports"))
              (else u))))

        (element application ($bold-seq$))

        (element citerefentry
          (let ((href          ($create-refentry-xref-link$)))
            (if %refentry-xref-link%
              (create-link (list (list "HREF" href))
                (if %refentry-xref-italic%
                  ($italic-seq$)
                  ($charseq$)))
              (if %refentry-xref-italic%
                ($italic-seq$)
                ($charseq$)))))

	(element filename
	  (let*	((class		(attribute-string (normalize "role"))))
	    (cond
	     ((equal? class "package")
	      (let* ((urlurl	"http://www.FreeBSD.org/cgi/url.cgi")
		     (href	(string-append urlurl "?ports/"
					       (data (current-node))
					       "/pkg-descr")))
		(create-link (list (list "HREF" href)) ($mono-seq$))))
	     (else ($mono-seq$)))))

	;; Do not render email with mailto: when nolink role attribute
	;; is used or when the email address matches
	;; @example.{com|net|org}
	(element email
	  (let* ((class		(attribute-string (normalize "role"))))
	    (cond
	     ((or (equal? class "nolink")
		  (and (> (string-length (data (current-node)))
			  11)
		       (string=?
			(substring (data (current-node))
				   (- (string-length (data (current-node))) 11)
				   (- (string-length (data (current-node))) 4))
			"example")))
	      ($code-seq$
	       (make sequence
		 (literal "&#60;")
		 (process-children)
		 (literal "&#62;"))))
	     (else
	      (next-match)))))

	;; Ensure that we start with no preferred mediaobject notations,
	;; so that in the text-only case we don't choose any of the
	;; possible images, and fallback to the most appropriate
	;; textobject
        (define preferred-mediaobject-notations
	  '())

	<!-- Convert " ... " to `` ... '' in the HTML output. -->
	(element quote
	  (make sequence
	    (literal "&#8220;")
	    (process-children)
	    (literal "&#8221;")))

	;; The special FreeBSD version of the trademark tag handling.
	;; This function was more or less taken from the DocBook DSSSL
	;; stylesheets by Norman Walsh.
	(element trademark
	  (if (show-tm-symbol? (current-node))
	      (make sequence
		($charseq$)
		(cond
		 ((equal? (attribute-string "class") (normalize "copyright"))
		  (make entity-ref name: "copy"))
		 ((equal? (attribute-string "class") (normalize "registered"))
		  (make entity-ref name: "reg"))
		 ((equal? (attribute-string "class") (normalize "service"))
		  (make element gi: "SUP"
			(literal "SM")))
		 (else
		  (make entity-ref name: "#8482"))))
	      ($charseq$)))

	;; multiple copyright holders should be separated.
	(element (copyright holder)
	  (make sequence
	    ($charseq$)
	    (if (not (last-sibling? (current-node)))
	        (literal ", ")
	        (empty-sosofo))))
      ]]>

      <!-- HTML with images  ............................................ -->

      <![ %output.html.images [

; The new Cascading Style Sheets for the HTML output are very confused
; by our images when used with div class="mediaobject".  We can
; clear up the confusion by ignoring the whole mess and just
; displaying the image.

        (element mediaobject
          (make element gi: "P"
            ($mediaobject$)))

        (define %graphic-default-extension%
          "png")

        (define %callout-graphics%
          ;; Use graphics in callouts?
          #t)

        (define %callout-graphics-ext%
          ;; The extension to use for callout images.  This is an extension
          ;; to the stylesheets, they do not support this functionality
          ;; natively.
          ".png")

        (define %callout-graphics-number-limit%
          ;; Number of largest callout graphic
          15)

        (define %callout-graphics-path%
          ;; Path to callout graphics
          "./imagelib/callouts/")

        ;; Redefine $callout-bug$ to support the %callout-graphic-ext%
        ;; variable.
        (define ($callout-bug$ conumber)
	  (let ((number (if conumber (format-number conumber "1") "0")))
	    (if conumber
		(if %callout-graphics%
	            (if (<= conumber %callout-graphics-number-limit%)
		        (make empty-element gi: "IMG"
			      attributes: (list (list "SRC"
				                      (root-rel-path
					               (string-append
						        %callout-graphics-path%
							number
	                                                %callout-graphics-ext%)))
		                                (list "HSPACE" "0")
			                        (list "VSPACE" "0")
				                (list "BORDER" "0")
					        (list "ALT"
						      (string-append
	                                               "(" number ")"))))
		        (make element gi: "B"
			      (literal "(" (format-number conumber "1") ")")))
	            (make element gi: "B"
		          (literal "(" (format-number conumber "1") ")")))
	        (make element gi: "B"
	       (literal "(??)")))))
      ]]>

    </style-specification-body>
  </style-specification>
</style-sheet>
