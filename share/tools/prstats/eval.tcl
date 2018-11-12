#!/usr/local/bin/tclsh8.3
#
# $FreeBSD$
#

set fi [open "|sort -n _"]
set fo [open "__" w]
set v {open feedback analyzed suspended patched closed }

foreach i $v {
	set $i 0
}
set m 0
while {[gets $fi a] >= 0} {
	if {![regexp {^[0-9]*$} [lindex $a 1]]} {
		puts "Bogus: $a"
		continue
	}
	if {[catch {eval [string tolower [lindex $a 2]]}]} {
		puts $a
	}
	if {[lindex $a 1] > $m} {
		set m [lindex $a 1].0
	}
	puts -nonewline $fo [clock format [lindex $a 0] -format "%Y/%m/%d %H:%M" -gmt true]
	puts -nonewline $fo " [lindex $a 0]"
	foreach i $v {
		set j [set $i]
		#puts -nonewline $fo " [expr $j / $m]"
		puts -nonewline $fo " $j"
	}
	puts $fo ""
}
