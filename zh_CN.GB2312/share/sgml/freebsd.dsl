<!-- $FreeBSD$ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>
<!ENTITY % lang.zhcn.dsssl "IGNORE">
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
      <![ %lang.zhcn.dsssl; [
	(define %gentext-language% "zhcn")
      ]]>

	<!-- Convert " ... " to “ ... ” in the HTML output. -->
	(element quote
	  (make sequence
	    (literal "“")
	    (process-children)
	    (literal "”")))
	<!-- Work around the issue that the current DSL doesn't translate -->
	(define (gentext-en-nav-prev prev)
	  (make sequence (literal "上一页")))
	(define (gentext-en-nav-next next)
	  (make sequence (literal "下一页")))
	(define (gentext-en-nav-up up)
	  (make sequence (literal "向上")))
	(define (gentext-en-nav-home home)
	  (make sequence (literal "首页")))
	(define (en-xref-strings)
	  (list (list (normalize "appendix")    (if %chapter-autolabel%
						    "附录 %n"
						    "附录 %t"))
		(list (normalize "article")     (string-append %gentext-en-start-quote%
							       "%t"
							       %gentext-en-end-quote%))
		(list (normalize "bibliography") "%t")
		(list (normalize "book")        "%t")
		(list (normalize "chapter")     (if %chapter-autolabel%
						    "第 %n 章"
						    "%t 这章"))
		(list (normalize "equation")    "公式 %n")
		(list (normalize "example")     "例 %n")
		(list (normalize "figure")      "图 %n")
		(list (normalize "glossary")    "%t")
		(list (normalize "index")       "%t")
		(list (normalize "listitem")    "%n")
		(list (normalize "part")        "第 %n 部分")
		(list (normalize "preface")     "%t")
		(list (normalize "procedure")   "过程 %n, %t")
		(list (normalize "reference")   "参考文献 %n, %t")
		(list (normalize "section")     (if %section-autolabel%
						    "第 %n 节"
						    "%t 小节"))
		(list (normalize "sect1")       (if %section-autolabel%
						    "第 %n 节"
						    "%t 小节"))
		(list (normalize "sect2")       (if %section-autolabel%
						    "第 %n 节"
						    "%t 小节"))
		(list (normalize "sect3")       (if %section-autolabel%
						    "第 %n 节"
						    "%t 小节"))
		(list (normalize "sect4")       (if %section-autolabel%
						    "第 %n 节"
						    "%t 小节"))
		(list (normalize "sect5")       (if %section-autolabel%
						    "第 %n 节"
						    "%t 小节"))
		(list (normalize "simplesect")  (if %section-autolabel%
						    "第 %n 节"
						    "%t 小节"))
		(list (normalize "sidebar")     "提示 %t")
		(list (normalize "step")        "第 %n 步")
		(list (normalize "table")       "表 %n")))
      (define %html-header-tags% '(("META" ("HTTP-EQUIV" "Content-Type") ("CONTENT" "text/html; charset=GB2312")))) 
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
