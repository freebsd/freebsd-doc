<!-- $FreeBSD$ -->

<!--

The current generation of open source SGML aware spellcheckers are
insufficient for our needs.  They produce far too many false positives
since they just ignore the tags themselves but still spellcheck the
contents of all tags.  This stylesheet specifically omits the output
of tags that may contain data that should not be spellchecked.  For
example, the contents of <filename> tags should not be spellchecked.

-->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Stylesheet//EN" CDATA DSSSL>
<!ENTITY % output.print "IGNORE">
<!ENTITY % output.html		"IGNORE">

]>

<style-sheet>
  <style-specification use="docbook">
    <style-specification-body>

      <![ %output.html; [ 


<!--
	  (element programlisting
	    (if (equal? (normalize "pgpfingerprint") (attribute-string "role"))
		(empty-sosofo)
		(if (equal? (normalize "pgpkey") (attribute-string "role"))
		    (empty-sosofo)
		    (next-match))))
-->

	  (element command
	    (empty-sosofo))

	  (element devicename
	    (empty-sosofo))

	  (element filename
	    (empty-sosofo))

	  (element hostid
	    (empty-sosofo))

	  (element otheraddr
	    (empty-sosofo))

	  (element programlisting
	    (empty-sosofo))

	  (element screen
	    (empty-sosofo))

      ]]>
    </style-specification-body>
  </style-specification>

  <external-specification id="docbook" document="freebsd.dsl">
</style-sheet>
