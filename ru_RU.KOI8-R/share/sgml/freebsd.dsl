<!--
     The FreeBSD Russian Documentation Project

     $FreeBSD$
     $FreeBSDru: frdp/doc/ru_RU.KOI8-R/share/sgml/freebsd.dsl,v 1.18 2006/08/08 07:49:39 marck Exp $

     Original revision: 1.22
-->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>
<!ENTITY % lang.ru.dsssl "IGNORE">                                             

<!ENTITY % freebsd.l10n PUBLIC "-//FreeBSD//ENTITIES DocBook Language Specific Entities//EN">
%freebsd.l10n;

<!ENTITY % output.html  "IGNORE"> 
<!ENTITY % output.print "IGNORE">
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>

      <![ %output.html; [ 

      <![ %lang.ru.dsssl; [
        (define %gentext-language% "ru")
      ]]>

	(define ($email-footer$)
          (make sequence
	    (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"
                (literal "Этот, и другие документы, могут быть скачаны с ")
		(create-link
		  (list (list "HREF" "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                  (literal "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                (literal ".")))
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"  
                (literal "По вопросам, связанным с FreeBSD, прочитайте ")
		(create-link
		  (list (list "HREF" "http://www.FreeBSD.org/ru/docs.html"))
                  (literal "документацию"))
                (literal " прежде чем писать в <")
		(create-link
		  (list (list "HREF" "mailto:questions@FreeBSD.org"))
                  (literal "questions@FreeBSD.org"))
                (literal ">.")
                (make empty-element gi: "br")
                (literal "По вопросам, связанным с этой документацией, пишите <")
		(create-link (list (list "HREF" "mailto:doc@FreeBSD.org"))
                  (literal "doc@FreeBSD.org"))
	        (literal ">.")
                (make empty-element gi: "br")
                (literal "По вопросам, связанным с русским переводом документации, пишите в рассылку <")
		(create-link (list (list "HREF" "mailto:frdp@FreeBSD.org.ua"))
                  (literal "frdp@FreeBSD.org.ua"))
	        (literal ">.")
                (make empty-element gi: "br")
                (literal "Информация по подписке на эту рассылку находится на ")
		(create-link
		  (list (list "HREF" "http://www.FreeBSD.org.ua/resources.html"))
                  (literal "сайте проекта перевода"))
                (literal ".")))))
      ]]>

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
;; version is in share/sgml/docbook/dsssl/modular/common/dbcommon.dsl).

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
