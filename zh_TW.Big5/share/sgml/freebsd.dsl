<!-- $FreeBSD$ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Language Neutral Stylesheet//EN" CDATA DSSSL>

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
                (literal "本文及其他文件，可由此下載：")
		(create-link
		  (list (list "HREF" "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                  (literal "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                (literal "。")))
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"  
                (literal "若有 FreeBSD 方面疑問，請先閱讀 ")
		(create-link
		  (list (list "HREF" "http://www.FreeBSD.org/docs.html"))
                  (literal "FreeBSD 相關文件"))
                (literal "，如不能解決的話，再洽詢 <")
		(create-link
		  (list (list "HREF" "mailto:questions@FreeBSD.org"))
                  (literal "questions@FreeBSD.org"))
                (literal ">。")
                (make empty-element gi: "br")
                (literal "關於本文件的問題，請洽詢 <")
		(create-link (list (list "HREF" "mailto:doc@FreeBSD.org"))
                  (literal "doc@FreeBSD.org"))
	        (literal ">。")))))

;; 對於要強調的部分，中文慣用粗體，中文斜體字不夠醒目，且妨礙閱讀，
;; 修改自 /usr/local/share/sgml/docbook/dsssl/modular/html/dbinline.dsl
;; Id: dbinline.dsl,v 1.11 2004/09/14 14:47:10 petere78 Exp
;; chinsan: 這段取自 zh_CN 成果 :p

(element emphasis
  (let* ((class (if (and (attribute-string (normalize "role"))
			 %emphasis-propagates-style%)
		    (attribute-string (normalize "role"))
		    "emphasis")))
    (make element gi: "SPAN"
	  attributes: (list (list "CLASS" class))
	      ($bold-seq$))))

      ]]>
    </style-specification-body>
  </style-specification>
    
  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
