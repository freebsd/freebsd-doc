<!-- $FreeBSD$ -->

<!DOCTYPE style-sheet PUBLIC "-//James Clark//DTD DSSSL Style Sheet//EN" [
<!ENTITY docbook.dsl PUBLIC "-//Norman Walsh//DOCUMENT DocBook Print Stylesheet//EN" CDATA DSSSL>
<!ENTITY freebsd.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Print Stylesheet//EN" CDATA DSSSL>
<!ENTITY freebsd-common.dsl PUBLIC "-//FreeBSD//DOCUMENT DocBook Common Stylesheet//EN" CDATA DSSSL>
]>

<style-sheet>
  <style-specification use="freebsd freebsd-common docbook">
    <style-specification-body>

      (declare-flow-object-class formatting-instruction
        "UNREGISTERED::James Clark//Flow Object Class::formatting-instruction")

    </style-specification-body>
  </style-specification>

  <external-specification id="freebsd" document="freebsd.dsl">
  <external-specification id="freebsd-common" document="freebsd-common.dsl">
  <external-specification id="docbook" document="docbook.dsl">
</style-sheet>
