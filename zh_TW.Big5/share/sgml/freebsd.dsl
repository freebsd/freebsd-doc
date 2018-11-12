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
                (literal "����Ψ�L���A�i�Ѧ��U���G")
		(create-link
		  (list (list "HREF" "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                  (literal "ftp://ftp.FreeBSD.org/pub/FreeBSD/doc/"))
                (literal "�C")))
            (make element gi: "p"
                  attributes: (list (list "align" "center"))
              (make element gi: "small"  
                (literal "�Y�� FreeBSD �譱�ðݡA�Х��\Ū ")
		(create-link
		  (list (list "HREF" "http://www.FreeBSD.org/docs.html"))
                  (literal "FreeBSD �������"))
                (literal "�A�p����ѨM���ܡA�A���� <")
		(create-link
		  (list (list "HREF" "mailto:questions@FreeBSD.org"))
                  (literal "questions@FreeBSD.org"))
                (literal ">�C")
                (make empty-element gi: "br")
                (literal "���󥻤�󪺰��D�A�Ь��� <")
		(create-link (list (list "HREF" "mailto:doc@FreeBSD.org"))
                  (literal "doc@FreeBSD.org"))
	        (literal ">�C")))))

;; ���n�j�ժ������A����D�β���A�������r�������ءA�B��ê�\Ū�A
;; �ק�� /usr/local/share/sgml/docbook/dsssl/modular/html/dbinline.dsl
;; Id: dbinline.dsl,v 1.11 2004/09/14 14:47:10 petere78 Exp
;; chinsan: �o�q���� zh_CN ���G :p

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
