<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$
     $FreeBSDru: frdp/doc/ru_RU.KOI8-R/share/xml/freebsd.dsl,v 1.18 2006/08/08 07:49:39 marck Exp $

     Original revision: r26925
-->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>

      <!-- Convert " ... " to '' ... '' in the HTML output. -->
      (element quote
	(make sequence
	  (literal "''")
	  (process-children)
	  (literal "''")))

	<!-- Fix a problem with the Russian localization (dbl1ru.dsl). -->
	(define (local-ru-label-title-sep)
	(list
	  (list (normalize "warning")           ": ")
	  (list (normalize "caution")           ": ")
	))

;; Fix punctuation for authors list in russian localization (original
;; version is in share/xml/docbook/dsssl/modular/common/dbcommon.dsl).

(define (author-list-string #!optional (author (current-node)))

  (let* ((author-node-list (select-elements
			    (descendants
			     (ancestor (normalize "authorgroup") author))
			    (normalize "author")))
	 (corpauthor-node-list (select-elements
				(descendants
				 (ancestor (normalize "authorgroup") author))
				(normalize "corpauthor")))
	 (othercredit-node-list (select-elements
				 (descendants
				  (ancestor (normalize "authorgroup") author))
				 (normalize "othercredit")))
	 (editor-node-list (select-elements
			    (descendants
			     (ancestor (normalize "authorgroup")))
			    (normalize "editor")))
	 (author-count (if (have-ancestor? (normalize "authorgroup") author)
			   (+ (node-list-length author-node-list)
			      (node-list-length corpauthor-node-list)
			      (node-list-length othercredit-node-list)
			      (node-list-length editor-node-list))
			   1))
	 (this-count (if (have-ancestor? (normalize "authorgroup") author)
			 (+ (node-list-length (preced author)) 1)
			 1)))
    (string-append

     (author-string author)

     (if (> author-count 1)
	 (if (> (- author-count this-count) 1)
	     (gentext-listcomma)
	     (if (= (- author-count this-count) 1)
		 (gentext-lastlistcomma)
		 ""))
	 "")
     (if (and (> author-count 1)
	      (not (last-sibling? author)))
	 " "
	 ""))))

    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
