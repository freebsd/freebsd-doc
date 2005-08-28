<!--
     DocBook Language Specific Style Sheet for Localization (Simplified Chinese).

     Original Revision: 1.20
     $FreeBSD$
 -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>

<!ENTITY % freebsd.l10n PUBLIC "-//FreeBSD//ENTITIES DocBook Language Specific Entities//EN">
%freebsd.l10n;

<!ENTITY % output.html  "IGNORE">
<!ENTITY % output.print "IGNORE">
<!ENTITY % output.print.niceheaders "IGNORE">
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
      <!-- HTML only .................................................... -->

      <![ %output.html; [

        <!-- Generate links to HTML man pages -->
        (define %refentry-xref-link% #t)

	(define ($email-footer$)
          (make sequence
	    (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"
                (literal "本文档和其它文档可从这里下载：")
		(create-link
		  (list (list "HREF" "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                  (literal "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                (literal ".")))
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"
                (literal "如果对于FreeBSD有问题，请先阅读")
		(create-link
		  (list (list "HREF" "http://www.FreeBSD.org/docs.html"))
                  (literal "文档"))
                (literal "，如不能解决再联系<")
		(create-link
		  (list (list "HREF" "mailto:questions@FreeBSD.org"))
                  (literal "questions@FreeBSD.org"))
                (literal ">.")
                (make empty-element gi: "br")
                (literal "关于本文档的问题请发信联系 <")
		(create-link (list (list "HREF" "mailto:doc@FreeBSD.org"))
                  (literal "doc@FreeBSD.org"))
	        (literal ">.")))))

;; 以下几个定义可产生出汉语习惯的章节号。
;; 很奇怪，不知道定义在
;; /usr/local/share/sgml/docbook/dsssl/modular/common/dbl1zhcn.dsl
;; 中的zhcn-xref-strings为什么不起作用。
;; 用Google可以搜索到其它语言翻译者此类抱怨的文章。

;; toc-entry
;; 修改自 /usr/local/share/sgml/docbook/dsssl/modular/html/dbautoc.dsl
;; 在目录中显示：
;; 第 xx 章
;; 第 xx.xx 节

(define (toc-entry tocentry)
  (make element gi: "DT"
	(make sequence
	  (if (equal? (element-label tocentry) "")
	      (empty-sosofo)
	      (make sequence
                (literal "第")
		(literal (element-label tocentry))
		(literal (gentext-element-name tocentry))
		(literal (gentext-label-title-sep
			  (gi tocentry)))))

	  ;; If the tocentry isn't in its own
	  ;; chunk, don't make a link...
	  (if (and #f (not (chunk? tocentry)))
	      (element-title-sosofo tocentry)
	      (make element gi: "A"
		    attributes: (list
				 (list "HREF"
				       (href-to tocentry)))
		    (element-title-sosofo tocentry)))

	  ;; Maybe annotate...
	  (if (and %annotate-toc%
		   (equal? (gi tocentry) (normalize "refentry")))
	      (make sequence
		(dingbat-sosofo "nbsp");
		(dingbat-sosofo "em-dash");
		(dingbat-sosofo "nbsp");
		(toc-annotation tocentry))
	      (empty-sosofo)))))

;; lot-entry
;; 修改自 /usr/local/share/sgml/docbook/dsssl/modular/html/dbautoc.dsl
;; 在表格清单中显示：
;; 表 xx-xx. ....
;; 在插图清单中显示：
;; 图 xx-xx. ....
;; 在范例清单中显示：
;; 例 xx-xx. ....


(define (lot-entry tocentry)
  (make element gi: "DT"
	(make sequence
	  (if (equal? (element-label tocentry) "")
	      (empty-sosofo)
	      (make sequence
		(literal (gentext-element-name tocentry))
		(literal (element-label tocentry))
		(literal (gentext-label-title-sep
			  (gi tocentry)))))

	  ;; If the tocentry isn't in its own
	  ;; chunk, don't make a link...
	  (if (and #f (not (chunk? tocentry)))
	      (element-title-sosofo tocentry)
	      (make element gi: "A"
		    attributes: (list
				 (list "HREF"
				       (href-to tocentry)))
		    (element-title-sosofo tocentry))))))

;; 修改自 /usr/local/share/sgml/docbook/dsssl/modular/html/dbttlpg.dsl
;; 使每部分的开头页(称为Title Page)显示“第xx部分”

(mode part-titlepage-recto-mode
  (element title
    (let ((division (ancestor-member (current-node) (division-element-list))))
      (make element gi: "H1"
	    attributes: (list (list "CLASS" (gi)))
	    (if (string=? (element-label division) "")
		(empty-sosofo)
		(literal "第"
                         (element-label division)
                         (gentext-element-name division)
			 (gentext-label-title-sep (gi division))))
	    (with-mode title-mode
	      (process-children)))))
)


;; 修改自/usr/local/share/sgml/docbook/dsssl/modular/html/dbcompon.dsl
;; 使每章第一页上显示“第xx章”

(define ($component-title$ #!optional (titlegi "H1") (subtitlegi "H2"))
  (let* ((info (cond
		((equal? (gi) (normalize "article"))
		 (node-list-filter-by-gi (children (current-node))
					 (list (normalize "artheader")
					       (normalize "articleinfo"))))
		((or
                  (equal? (gi) (normalize "appendix"))
                  (equal? (gi) (normalize "bibliography"))
                  (equal? (gi) (normalize "chapter"))
                  (equal? (gi) (normalize "glossary"))
                  (equal? (gi) (normalize "index"))
                  (equal? (gi) (normalize "preface"))
                  (equal? (gi) (normalize "reference"))
                  (equal? (gi) (normalize "setindex")))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		(else
		 (empty-node-list))))
	 (exp-children (if (node-list-empty? info)
			   (empty-node-list)
			   (expand-children (children info)
					    (list (normalize "bookbiblio")
						  (normalize "bibliomisc")
						  (normalize "biblioset")))))
	 (parent-titles (select-elements (children (current-node)) (normalize "title")))
	 (titles	(if (node-list-empty? parent-titles)
			    (select-elements exp-children (normalize "title"))
			    parent-titles))
	 (parent-subttl (select-elements (children (current-node)) (normalize "subtitle")))
	 (subtitles	(if (node-list-empty? parent-subttl)
			    (select-elements exp-children (normalize "subtitle"))
			    parent-subttl)))
    (make sequence
      (make element gi: titlegi
	    (make sequence
	      (make element gi: "A"
		  attributes: (list (list "NAME" (element-id)))
		  (empty-sosofo))
	      (if (and %chapter-autolabel%
		       (or (equal? (gi) (normalize "chapter"))
			   (equal? (gi) (normalize "appendix"))))
		  (literal "第"
			   (element-label (current-node))
                           (gentext-element-name-space (gi))
			   (gentext-label-title-sep (gi)))
		  (empty-sosofo))
	      (if (node-list-empty? titles)
		  (element-title-sosofo) ;; get a default!
		  (with-mode title-mode
		    (process-node-list titles)))))
      (if (node-list-empty? subtitles)
	  (empty-sosofo)
	  (with-mode subtitle-mode
	    (make element gi: subtitlegi
		  (process-node-list subtitles)))))))

;; 修改自/usr/local/share/sgml/docbook/dsssl/modular/html/dbnavig.dsl
;; 使页眉上显示“第xx章”等等。

(define (nav-context-sosofo elemnode)
  (let* ((component     (ancestor-member elemnode
					 (append (book-element-list)
						 (division-element-list)
						 (component-element-list))))
	 (context-text  (inherited-dbhtml-value elemnode "context-text")))
    (if (and context-text (not (string=? context-text "")))
	(literal context-text)
	(if (equal? (element-label component) "")
	    (make sequence
	      (element-title-sosofo component))
	    (make sequence
	      ;; Special case.  This is a bit of a hack.
	      ;; I need to revisit this aspect of 
	      ;; appendixes. 
	      (if (and (equal? (gi component) (normalize "appendix"))
		       (or (equal? (gi elemnode) (normalize "sect1"))
			   (equal? (gi elemnode) (normalize "section")))
		       (equal? (gi (parent component)) (normalize "article")))
		  (element-label-sosofo component)
		  (make sequence
                    (literal "第")
                    (element-label-sosofo component)
                    (literal (gentext-element-name-space (gi component)))
                  ))
	      (literal (gentext-label-title-sep (gi component)))
	      (element-title-sosofo component))))))


      ]]>

      <!-- More aesthetically pleasing chapter headers for print output -->

      <![ %output.print.niceheaders; [

      (define niceheader-rule-spacebefore (* (HSIZE 5) %head-before-factor%))
      (define niceheader-rule-spaceafter 0pt)

      (define ($component-title$)
	(let* ((info (cond
		((equal? (gi) (normalize "appendix"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "article"))
		 (node-list-filter-by-gi (children (current-node))
					 (list (normalize "artheader")
					       (normalize "articleinfo"))))
		((equal? (gi) (normalize "bibliography"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "chapter"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "dedication"))
		 (empty-node-list))
		((equal? (gi) (normalize "glossary"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "index"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "preface"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "reference"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		((equal? (gi) (normalize "setindex"))
		 (select-elements (children (current-node)) (normalize "docinfo")))
		(else
		 (empty-node-list))))
	 (exp-children (if (node-list-empty? info)
			   (empty-node-list)
			   (expand-children (children info)
					    (list (normalize "bookbiblio")
						  (normalize "bibliomisc")
						  (normalize "biblioset")))))
	 (parent-titles (select-elements (children (current-node)) (normalize "title")))
	 (info-titles   (select-elements exp-children (normalize "title")))
	 (titles        (if (node-list-empty? parent-titles)
			    info-titles
			    parent-titles))
	 (subtitles     (select-elements exp-children (normalize "subtitle"))))
    (make sequence
      (make paragraph
	font-family-name: %title-font-family%
	font-weight: 'bold
	font-size: (HSIZE 4)
	line-spacing: (* (HSIZE 4) %line-spacing-factor%)
	space-before: (* (HSIZE 4) %head-before-factor%)
	start-indent: 0pt
	first-line-start-indent: 0pt
	quadding: %component-title-quadding%
	heading-level: (if %generate-heading-level% 1 0)
	keep-with-next?: #t

	(if (string=? (element-label) "")
	    (empty-sosofo)
	    (literal (gentext-element-name-space (current-node))
		     (element-label)
		     (gentext-label-title-sep (gi)))))
      (make paragraph
	font-family-name: %title-font-family%
	font-weight: 'bold
	font-posture: 'italic
	font-size: (HSIZE 6)
	line-spacing: (* (HSIZE 6) %line-spacing-factor%)
;	space-before: (* (HSIZE 5) %head-before-factor%)
	start-indent: 0pt
	first-line-start-indent: 0pt
	quadding: %component-title-quadding%
	heading-level: (if %generate-heading-level% 1 0)
	keep-with-next?: #t

	(if (node-list-empty? titles)
	    (element-title-sosofo) ;; get a default!
	    (with-mode component-title-mode
	      (make sequence
		(process-node-list titles)))))

      (make paragraph
	font-family-name: %title-font-family%
	font-weight: 'bold
	font-posture: 'italic
	font-size: (HSIZE 3)
	line-spacing: (* (HSIZE 3) %line-spacing-factor%)
	space-before: (* 0.5 (* (HSIZE 3) %head-before-factor%))
	space-after: (* (HSIZE 4) %head-after-factor%)
	start-indent: 0pt
	first-line-start-indent: 0pt
	quadding: %component-subtitle-quadding%
	keep-with-next?: #t

	(with-mode component-title-mode
	  (make sequence
	    (process-node-list subtitles))))

      (if (equal? (gi) (normalize "index"))
	(empty-sosofo)
	(make rule
	  length: %body-width%
	  display-alignment: 'start
	  space-before: niceheader-rule-spacebefore
	  space-after: niceheader-rule-spaceafter
	  line-thickness: 0.5pt)))))

      (element authorgroup
        (empty-sosofo))

      ]]>

      <!-- Print only ................................................... -->

      <![ %output.print; [

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

      ]]>

      <!-- Both sets of stylesheets ..................................... -->

      (define (local-zhcn-label-title-sep)
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

<!-- 等同于 <book lang="zh_cn">  -->

      (define %default-language% "zh_cn")



    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
