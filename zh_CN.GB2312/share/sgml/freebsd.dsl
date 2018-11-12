<!--
     DocBook Language Specific Style Sheet for Localization (Simplified Chinese).

     Original Revision: 1.23
     $FreeBSD$
 -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>

<!ENTITY % freebsd.l10n PUBLIC "-//FreeBSD//ENTITIES DocBook Language Specific Entities//EN">
%freebsd.l10n;

<!ENTITY % output.html  "IGNORE">
<!ENTITY % output.print "IGNORE">
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
      <![ %output.html; [
	(define ($email-footer$)
          (make sequence
	    (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"
                (literal "���ĵ��������ĵ��ɴ��������أ�")
		(create-link
		  (list (list "HREF" "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                  (literal "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                (literal ".")))
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"
                (literal "�������FreeBSD�����⣬�����Ķ�")
		(create-link
		  (list (list "HREF" "http://www.FreeBSD.org/docs.html"))
                  (literal "�ĵ�"))
                (literal "���粻�ܽ������ϵ<")
		(create-link
		  (list (list "HREF" "mailto:questions@FreeBSD.org"))
                  (literal "questions@FreeBSD.org"))
                (literal ">.")
                (make empty-element gi: "br")
                (literal "���ڱ��ĵ��������뷢����ϵ <")
		(create-link (list (list "HREF" "mailto:doc@FreeBSD.org"))
                  (literal "doc@FreeBSD.org"))
	        (literal ">.")))))

;; ���¼�������ɲ���������ϰ�ߵ��½ںš�
;; ����֣���֪��������
;; /usr/local/share/sgml/docbook/dsssl/modular/common/dbl1zhcn.dsl
;; �е�zhcn-xref-stringsΪʲô�������á�
;; ��Google�����������������Է����ߴ��౧Թ�����¡�

;; toc-entry
;; �޸��� /usr/local/share/sgml/docbook/dsssl/modular/html/dbautoc.dsl
;; Id: dbautoc.dsl,v 1.3 2003/01/15 08:24:13 adicarlo Exp
;; ��Ŀ¼����ʾ��
;; �� 1 ��  XXXXXX
;;    1.1  XXXXXX (��)
;;    1.2  XXXXXX (��)
;; ��¼ A XXXXXXX
;;    A.1 XXXXXXX (��)
;;    A.2 XXXXXXX (��)

(define (toc-entry tocentry)
  (make element gi: "DT"
	(make sequence
	  (if (equal? (element-label tocentry) "")
	      (empty-sosofo)
	      (if (member (gi tocentry) (list (normalize "part") (normalize "chapter")))
	        (make sequence
                  (literal "��")
		  (literal (element-label tocentry))
		  (literal (gentext-element-name tocentry))
		  (literal (gentext-label-title-sep (gi tocentry)))
	        )
	        (if (equal? (gi tocentry) (normalize "appendix"))
	          (make sequence
	            (literal (gentext-element-name tocentry))
		    (literal (element-label tocentry))
		    (literal (gentext-label-title-sep (gi tocentry)))
	          )
	          (make sequence
		    (literal (element-label tocentry))
		    (literal (gentext-label-title-sep (gi tocentry)))
	          )
                )
	      )
	  )

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
;; �޸��� /usr/local/share/sgml/docbook/dsssl/modular/html/dbautoc.dsl
;; Id: dbautoc.dsl,v 1.3 2003/01/15 08:24:13 adicarlo Exp
;; �ڱ���嵥����ʾ��
;; �� xx-xx. ....
;; �ڲ�ͼ�嵥����ʾ��
;; ͼ xx-xx. ....
;; �ڷ����嵥����ʾ��
;; �� xx-xx. ....


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

;; �޸��� /usr/local/share/sgml/docbook/dsssl/modular/html/dbttlpg.dsl
;; Id: dbttlpg.dsl,v 1.10 2004/10/10 11:55:10 petere78 Exp
;; ʹÿ���ֵĿ�ͷҳ(��ΪTitle Page)��ʾ����xx���֡�

(mode part-titlepage-recto-mode
  (element title
    (let ((division (ancestor-member (current-node) (division-element-list))))
      (make element gi: "H1"
	    attributes: (list (list "CLASS" (gi)))
	    (if (string=? (element-label division) "")
		(empty-sosofo)
		(literal "��"
                         (element-label division)
                         (gentext-element-name division)
			 (gentext-label-title-sep (gi division))))
	    (with-mode title-mode
	      (process-children)))))
)


;; �޸���/usr/local/share/sgml/docbook/dsssl/modular/html/dbcompon.dsl
;; Id: dbcompon.dsl,v 1.8 2003/04/29 05:49:21 adicarlo Exp
;; ʹÿ�µ�һҳ����ʾ����xx�¡�

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
		  (if (equal? (gi) (normalize "chapter"))
		      (literal "��"
			   (element-label (current-node))
                           (gentext-element-name-space (gi))
			   (gentext-label-title-sep (gi))
 		      )
		      (literal (gentext-element-name-space (gi))
			   (element-label (current-node))
			   (gentext-label-title-sep (gi))
		      )
		  )
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

;; �޸���/usr/local/share/sgml/docbook/dsssl/modular/html/dbnavig.dsl
;; Id: dbnavig.dsl,v 1.3 2001/07/05 12:08:42 nwalsh Exp
;; ʹҳü����ʾ����xx�¡��ȵȡ�

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
		  (if (equal? (gi component) (normalize "chapter"))
		    (make sequence
                      (literal "��")
                      (element-label-sosofo component)
                      (literal (gentext-element-name-space (gi component)))
                    )
	            (make sequence
	              (literal (gentext-element-name-space (gi component)))
	              (element-label-sosofo component)
	            )
	          )
	      )
	      (literal (gentext-label-title-sep (gi component)))
	      (element-title-sosofo component))))))

<!--
   �޸��� /usr/local/share/sgml/docbook/dsssl/modular/html/dbhtml.dsl
   Id: dbhtml.dsl,v 1.5 2004/10/10 11:55:10 petere78 Exp
   ��������дϰ�ߣ�ÿ�ο�ͷ�������
   ������ע�͡��б���ض�λ�ã���ȻҲʹ����SGML��<para></para>��ǣ�ȴ��Ӧ������
   ��ֻ��<para></para>����������һ��λ��ʱ������Ҫ������
-->

(define ($paragraph$ #!optional (para-wrapper "P"))
  (let ((footnotes (select-elements (descendants (current-node)) 
				    (normalize "footnote")))
	(tgroup (have-ancestor? (normalize "tgroup"))))
    (make sequence
      (make element gi: para-wrapper
	    attributes: (append
			 (if %default-quadding%
			     (list (list "ALIGN" %default-quadding%))
			     '()))
            (if (equal? (gi) (normalize "para"))
                (if (member (gi (parent (current-node)))
                        (list (normalize "article")
                              (normalize "book")
                              (normalize "abstract")
                              (normalize "chapter")
                              (normalize "sect1")
                              (normalize "sect2")
                              (normalize "sect3")
                              (normalize "sect4")
                              (normalize "sect5")
                        )
                    )
                 (literal "����")
                 (empty-sosofo)
                )
                (empty-sosofo)
            )
	    (process-children))
      (if (or %footnotes-at-end% tgroup (node-list-empty? footnotes))
	  (empty-sosofo)
	  (make element gi: "BLOCKQUOTE"
		attributes: (list
			     (list "CLASS" "FOOTNOTES"))
		(with-mode footnote-mode
		  (process-node-list footnotes)))))))

;; ����Ҫǿ���Ĳ��֣�����ϰ����ֻ�ô��壬б���ֲ�����Ŀ
;; �޸���/usr/local/share/sgml/docbook/dsssl/modular/html/dbinline.dsl
;; Id: dbinline.dsl,v 1.11 2004/09/14 14:47:10 petere78 Exp

(element emphasis
  (let* ((class (if (and (attribute-string (normalize "role"))
			 %emphasis-propagates-style%)
		    (attribute-string (normalize "role"))
		    "emphasis")))
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" class))
	      ($bold-seq$))))

      ]]>


      <![ %output.print; [

;; �޸���/usr/local/share/sgml/docbook/dsssl/modular/print/dbcompon.dsl
;; Id: dbcompon.dsl,v 1.5 2003/04/29 06:33:10 adicarlo Exp
;; ʹÿ�µı�����ʾΪ����XX�¡�
;; ����������ʽ����

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
	 (titles	(if (node-list-empty? parent-titles)
			    (select-elements exp-children (normalize "title"))
			    parent-titles))
	 (parent-subttl (select-elements (children (current-node)) (normalize "subtitle")))	    
	 (subtitles	(if (node-list-empty? parent-subttl)
			    (select-elements exp-children (normalize "subtitle"))
			    parent-subttl)))
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
	    (if (equal? (gi) (normalize "chapter"))
	        (literal "��" (element-label)
	                 (gentext-element-name-space (current-node))
		         (gentext-label-title-sep (gi))
	        )
	        (literal (gentext-element-name-space (current-node))
		         (element-label)
		         (gentext-label-title-sep (gi))
	        )
            ) ;; if�ṹ����
	)
      )

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
		(process-node-list titles))))
      )

      (make paragraph
	font-family-name: %title-font-family%
	font-weight: 'bold
	font-posture: 'italic
	font-size: (HSIZE 3)
	line-spacing: (* (HSIZE 3) %line-spacing-factor%)
	space-before: (* 0.5 (* (HSIZE 3) %head-before-factor%))
	space-after: 1pt
	start-indent: 0pt
	first-line-start-indent: 0pt
	quadding: %component-subtitle-quadding%
	keep-with-next?: #t

	(with-mode component-title-mode
	  (make sequence
	    (process-node-list subtitles)))
      )

      (if (equal? (gi) (normalize "index"))
	(empty-sosofo)
	(make rule
	  length: %body-width%
	  display-alignment: 'start
	  space-before: 0pt
	  space-after: 0pt
	  line-spacing: 1pt
	  line-thickness: 0.5pt))

)))

;; �޸���/usr/local/share/sgml/docbook/dsssl/modular/print/dbcompon.dsl
;; Id: dbcompon.dsl,v 1.5 2003/04/29 06:33:10 adicarlo Exp
;; ʹҳü��ʾ����XX�¡�
;; ����������ʽ����

(mode hf-mode
  (element title
    (let* ((component (ancestor-member (current-node) 
				       (component-element-list)))
	   (chaporapp (or (equal? (gi component) (normalize "chapter"))
			  (equal? (gi component) (normalize "appendix")))))
      (if %chap-app-running-heads%
	  (make sequence
	    (if (and chaporapp
		     %chapter-autolabel%
		     (or %chap-app-running-head-autolabel%
			 (attribute-string (normalize "label") component)))
		(if (equal? (gi component) (normalize "chapter"))
		    (literal "��" (element-label component)
		        (gentext-element-name-space component)
		        (gentext-label-title-sep (gi component)))
		    (literal (gentext-element-name-space component)
		        (element-label component)
		        (gentext-label-title-sep (gi component)))
		) ;; if�ṹ����
		(empty-sosofo))
	    (process-children-trim))
	  (empty-sosofo))))

  (element titleabbrev
    (if %chap-app-running-heads%
	(make sequence
	  (if (or (have-ancestor? (normalize "chapter"))
		  (have-ancestor? (normalize "appendix")))
	      (if (have-ancestor? (normalize "chapter"))
	          (literal "��" (element-label (parent))
		           (gentext-element-name-space (parent))
		           (gentext-label-title-sep (gi (parent))))
	          (literal (gentext-element-name-space (parent))
		           (element-label (parent))
		           (gentext-label-title-sep (gi (parent))))
	      ) ;; if�ṹ����
	      (empty-sosofo))
	  (process-children-trim))
	(empty-sosofo)))

  (element refentrytitle
    (if %chap-app-running-heads%
	(process-children-trim)
	(empty-sosofo)))

  (element refdescriptor
    (if %chap-app-running-heads%
	(process-children-trim)
	(empty-sosofo)))

  (element refname
    (if %chap-app-running-heads%
	(process-children-trim)
	(empty-sosofo)))

  ;; Graphics aren't allowed in headers and footers...
  (element graphic
    (empty-sosofo))

  (element inlinegraphic
    (empty-sosofo))
)

<!--
   �޸��� /usr/local/share/sgml/docbook/dsssl/modular/print/dbprint.dsl
   Id: dbprint.dsl,v 1.6 2004/10/09 19:46:33 petere78 Exp
   ��������дϰ�ߣ�ÿ�ο�ͷ�������
   ������ע�͡��б���ض�λ�ã���ȻҲʹ����SGML��<para></para>��ǣ�ȴ��Ӧ������
   ��ֻ��<para></para>����������һ��λ��ʱ������Ҫ������
-->

(define ($paragraph$)
  (if (or (equal? (print-backend) 'tex)
	  (equal? (print-backend) #f))
      ;; avoid using country: characteristic because of a JadeTeX bug...
      (make paragraph
	first-line-start-indent: 0pt
	space-before: %para-sep%
	space-after: (if (INLIST?)
			 0pt
			 %para-sep%)
	quadding: %default-quadding%
	hyphenate?: %hyphenation%
	language: (dsssl-language-code)
        (if (equal? (gi) (normalize "para"))
            (if (member (gi (parent (current-node)))
                    (list (normalize "article")
                          (normalize "book")
                          (normalize "abstract")
                          (normalize "chapter")
                          (normalize "sect1")
                          (normalize "sect2")
                          (normalize "sect3")
                          (normalize "sect4")
                          (normalize "sect5")
                    )
                )
             (literal "����")
             (empty-sosofo)
            )
            (empty-sosofo)
        )
	(process-children-trim))
      (make paragraph
	first-line-start-indent: 0pt
	space-before: %para-sep%
	space-after: (if (INLIST?)
			 0pt
			 %para-sep%)
	quadding: %default-quadding%
	hyphenate?: %hyphenation%
	language: (dsssl-language-code)
	country: (dsssl-country-code)
        (if (equal? (gi) (normalize "para"))
            (if (member (gi (parent (current-node)))
                    (list (normalize "article")
                          (normalize "book")
                          (normalize "abstract")
                          (normalize "chapter")
                          (normalize "sect1")
                          (normalize "sect2")
                          (normalize "sect3")
                          (normalize "sect4")
                          (normalize "sect5")
                    )
                )
             (literal "����")
             (empty-sosofo)
            )
            (empty-sosofo)
        )
	(process-children-trim))))

;; ����Ҫǿ���Ĳ��֣�����ϰ����ֻ�ô��壬б���ֲ�����Ŀ
;; �޸���/usr/local/share/sgml/docbook/dsssl/modular/print/dbinline.dsl
;; Id: dbinline.dsl,v 1.7 2003/03/25 19:53:56 adicarlo Exp
(element emphasis
      ($bold-seq$)
)

      ]]>

      <!-- Both sets of stylesheets ..................................... -->

      (define (local-zhcn-label-title-sep)
        (list
          (list (normalize "warning")		": ")
	  (list (normalize "caution")		": ")
          (list (normalize "chapter")           "��")
          (list (normalize "sect1")             "  ")
          (list (normalize "sect2")             "  ")
          (list (normalize "sect3")             "  ")
          (list (normalize "sect4")             "  ")
          (list (normalize "sect5")             "  ")
          ))

<!-- ��ͬ�� <book lang="zh_cn">  -->

      (define %default-language% "zh_cn")


;; ����ר�еĿ��أ�output.for.print
;; �������ӡ��ʽʱ����Ϊ��ӡ��ʽ����������ʱ����ʹ��
;; Ŀǰʹ�øÿ��صĳ��ϣ�
;; 1. legalnotice.sgml�ڿ��������������֤����ʾ
;; 2. freebsd.dsl�ڿ��������ļ���
;; ʵ�ָÿ��صĳ��ϣ�
;;    share/mk/doc.local.mk   ��Ŀ��print.index��ʵ�ִ����к�PRINTFLAGS��ֵ
;;    share/sgml/l10n.ent     ����ÿ���

      <![ %output.for.print; [
	(define html-index-filename "print.index")
      ]]>


;; ָ��RTF�е��������壬��Ǩ��OpenOffice������OpenOffice����ʾ���Ϊ
;; Arial, Times New Roman, Courier New ����������ĺ��֡�
;; Microsoft Word (Viewer)�н�ǿ������Ӧ��������ʹ����ָ���������Ҳ������ͣ�
;; Ҳ���Զ�Ѱ��������͡�

;; ������/usr/local/share/sgml/docbook/dsssl/modular/print/dbparam.dsl
;; Jade/OpenJade�������в���"-V rtf-backend"�����ȵľ����˿���ֵ��
(define rtf-backend #f)

(declare-initial-value font-family-name
  (cond
    (rtf-backend "AR PL New Sung")
    (else "Times New Roman")
  )
)

(define %refentry-name-font-family%
  (cond
    (rtf-backend "AR PL New Sung")
    (else "Courier New")
  )
)

(define %title-font-family% 
  (cond
    (rtf-backend "AR PL New Sung")
    (else "Arial")
  )
)

(define %body-font-family%
  (cond
    (rtf-backend "AR PL New Sung")
    (else "Times New Roman")
  )
)

(define %mono-font-family% 
  (cond
    (rtf-backend "AR PL New Sung")
    (else "Courier New")
  )
)

(define %admon-font-family% 
  (cond
    (rtf-backend "AR PL New Sung")
    (else "Arial")
  )
)

(define %guilabel-font-family%
  (cond
    (rtf-backend "AR PL New Sung")
    (else "Arial")
  )
)

    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
