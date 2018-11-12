<!--
     The FreeBSD Documentation Project
     The FreeBSD Japanese Documentation Project

     Original revision: 1.5
     $FreeBSD$
-->

<!-- Local DSSSL file for the Porter's Handbook.  This is so we can include
     a link to the -ports mailing list at the bottom of the HTML files, 
     rather than the -questions mailing list. -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl SYSTEM "../../share/sgml/freebsd.dsl" CDATA DSSSL>
<!ENTITY % output.html  "IGNORE"> 
]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>
 
      <![ %output.html; [ 
	(define ($email-footer$)
          (make sequence
            (literal "FreeBSD ports �����ƥ�˴ؤ������ϡ�(�Ѹ��) <")
            (create-link (list (list "HREF" "mailto:ports@FreeBSD.org"))
              (literal "ports@FreeBSD.org"))
            (literal "> �ء�")
            (make empty-element gi: "br")
            (literal "����ʸ��θ�ʸ�˴ؤ��뤪�䤤��碌�ϡ�(�Ѹ��) <")
             (create-link (list (list "HREF" "mailto:doc@FreeBSD.org"))
               (literal "doc@FreeBSD.org"))
	     (literal "> �ޤǤ��ꤤ���ޤ���")))

	<!-- Convert " ... " to `` ... '' in the HTML output. -->
	(element quote
	  (make sequence
	    (literal "``")
	    (process-children)
	    (literal "''")))
      ]]>
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
