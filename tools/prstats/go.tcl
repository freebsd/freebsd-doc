#!/usr/local/bin/tclsh8.3
#
# $FreeBSD: www/tools/prstats/go.tcl,v 1.2 2001/11/18 16:11:34 murray Exp $
#
# This script expects the directory of a GNATS database as its sole argument.

set gnatsdir [lindex $argv 0]
set fo [open _ w]
proc PR {fn} {
	global fo

	set n [lrange [split $fn /] end end]
	set openrc [catch {set fi [open $fn]} openerr]
	if {$openrc != 0} {return $openrc}
	while {[gets $fi a] >= 0} {
		if {[string range $a 0 12]      == "State-Changed"} {
			if {[lindex $a 0] == "State-Changed-When:"} {
				set t [clock scan [lrange $a 1 end]]
				#puts "* $t"
			}
			if {[lindex $a 0] == "State-Changed-From-To:"} {
				regsub {\->*[	 ]*} [lrange $a 1 end] { } d
				set b [lindex $d 1]
				set c [lindex $d 0]
				if {$b == "" || $c == ""} {
					puts stderr "$n <$a> <$d> <$b> <$c>"
					break
				}
				#puts "* - $c + $b"
			}
			if {[lindex $a 0] == "State-Changed-Why:"} {
				puts $fo "$t $n {incr $c -1 ; incr $b}"
			}
		} elseif {[string range $a 0 13] == ">Arrival-Date:"} {
			#puts "* $a"
			puts $fo "[clock scan [lrange $a 1 end]] $n {incr open}"
		} else {
			#puts $a
		}
	}
	close $fi
}


append gnatsdir {/*/*[0-9]}
foreach pr [glob $gnatsdir] {
	PR $pr
}
