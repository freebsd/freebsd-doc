<!--
     DocBook Language Specific Style Sheet for Localization (Simplified Chinese).

     Original Revision: 1.23
     $FreeBSD$
 -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>

;; 修改自/usr/local/share/xml/docbook/dsssl/modular/print/dbcompon.dsl
;; Id: dbcompon.dsl,v 1.5 2003/04/29 06:33:10 adicarlo Exp
;; 使每章的标题显示为“第XX章”
;; 其它容器格式不变

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
	        (literal "第" (element-label)
	                 (gentext-element-name-space (current-node))
		         (gentext-label-title-sep (gi))
	        )
	        (literal (gentext-element-name-space (current-node))
		         (element-label)
		         (gentext-label-title-sep (gi))
	        )
            ) ;; if结构结束
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

;; 修改自/usr/local/share/xml/docbook/dsssl/modular/print/dbcompon.dsl
;; Id: dbcompon.dsl,v 1.5 2003/04/29 06:33:10 adicarlo Exp
;; 使页眉显示“第XX章”
;; 其它容器格式不变

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
		    (literal "第" (element-label component)
		        (gentext-element-name-space component)
		        (gentext-label-title-sep (gi component)))
		    (literal (gentext-element-name-space component)
		        (element-label component)
		        (gentext-label-title-sep (gi component)))
		) ;; if结构结束
		(empty-sosofo))
	    (process-children-trim))
	  (empty-sosofo))))

  (element titleabbrev
    (if %chap-app-running-heads%
	(make sequence
	  (if (or (have-ancestor? (normalize "chapter"))
		  (have-ancestor? (normalize "appendix")))
	      (if (have-ancestor? (normalize "chapter"))
	          (literal "第" (element-label (parent))
		           (gentext-element-name-space (parent))
		           (gentext-label-title-sep (gi (parent))))
	          (literal (gentext-element-name-space (parent))
		           (element-label (parent))
		           (gentext-label-title-sep (gi (parent))))
	      ) ;; if结构结束
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
   修改自 /usr/local/share/xml/docbook/dsssl/modular/print/dbprint.dsl
   Id: dbprint.dsl,v 1.6 2004/10/09 19:46:33 petere78 Exp
   按中文书写习惯，每段开头须空两格。
   但是在注释、列表等特定位置，虽然也使用了SGML的<para></para>标记，却不应空两格。
   故只有<para></para>处于文章内一般位置时，才需要空两格。
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
             (literal "　　")
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
             (literal "　　")
             (empty-sosofo)
            )
            (empty-sosofo)
        )
	(process-children-trim))))

;; 对于要强调的部分，中文习惯于只用粗体，斜体字不够醒目
;; 修改自/usr/local/share/xml/docbook/dsssl/modular/print/dbinline.dsl
;; Id: dbinline.dsl,v 1.7 2003/03/25 19:53:56 adicarlo Exp
(element emphasis
      ($bold-seq$)
)

      (define (local-zhcn-label-title-sep)
        (list
          (list (normalize "warning")		": ")
	  (list (normalize "caution")		": ")
          (list (normalize "chapter")           "　")
          (list (normalize "sect1")             "  ")
          (list (normalize "sect2")             "  ")
          (list (normalize "sect3")             "  ")
          (list (normalize "sect4")             "  ")
          (list (normalize "sect5")             "  ")
          ))

<!-- 等同于 <book lang="zh_cn">  -->

      (define %default-language% "zh_cn")


;; 中文专有的开关：output.for.print
;; 在输出打印格式时和在为打印格式生成索引表时均被使能
;; 目前使用该开关的场合：
;; 1. legalnotice.sgml内控制中文字体许可证的显示
;; 2. freebsd.dsl内控制索引文件名
;; 实现该开关的场合：
;;    share/mk/doc.local.mk   在目标print.index的实现代码中和PRINTFLAGS赋值
;;    share/xml/l10n.ent     定义该开关

      <![ %output.for.print; [
	(define html-index-filename "print.index")
      ]]>


;; 指定RTF中的中文字体，以迁就OpenOffice。否则，OpenOffice不显示标记为
;; Arial, Times New Roman, Courier New 等西文字体的汉字。
;; Microsoft Word (Viewer)有较强的自适应能力，即使按照指定字体名找不到字型，
;; 也会自动寻找替代字型。

;; 复制自/usr/local/share/xml/docbook/dsssl/modular/print/dbparam.dsl
;; Jade/OpenJade的命令行参数"-V rtf-backend"更优先的决定此开关值。
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
