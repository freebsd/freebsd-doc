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

	<!-- Convert " ... " to ¡° ... ¡± in the HTML output. -->
	(element quote
	  (make sequence
	    (literal "¡°")
	    (process-children)
	    (literal "¡±")))
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
