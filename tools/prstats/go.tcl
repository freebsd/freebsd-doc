#!/usr/local/bin/tclsh8.3
#
# $FreeBSD$
#

set fo [open _ w]
proc PR {fn} {
	global fo

	set n [lrange [split $fn /] end end]
	set fi [open $fn]
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

foreach pr [glob {/c/gnats/*/[1-9]*}] {
	PR $pr
}
