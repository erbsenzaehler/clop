#!/usr/bin/env tclsh

# THINGS YOU MUST MODIFY ACCORDING TO YOUR WISHES
# -----------------------------------------------
# path to program executable
set pname "/home/tobias/chess/engines/Stockfish/src/stockfish"

# name of opponent program to test against
set oname "/home/tobias/chess/engines/Stockfish/src/stockfish"   


# what does a null move look like: done when stalemated
set null "0000"   ;# uci says it should be 0000

# call it a draw after MAX_MOVES full moves + 5 for opening
set MAX_MOVES 120  

# level string to start search
# ----------------------------
set lev "go depth 5"
# set lev "go nodes 20000"

# NOTE - use underscore character to represent spaces in clop file
# e.g.
#  in clop file if you call a parameter: knight_value_opening
#  it will be passed to UCI program as:
#     setoption name knight value opening value X
# 
# 
# ----- end of user configurable section -----


#  Arguments are:
#   #1: processor id (symbolic name, typically a machine name to ssh to)
#   #2: seed (integer)
#   #3: parameter id of first parameter (symbolic name)
#   #4: value of first parameter (float)
#   #5: parameter id of second parameter (optional)
#   #6: value of second parameter (optional)
#   ...

#  This script should write the game outcome to its output:
#   W = win
#   L = loss
#   D = draw

#  For instance:
#   $ ./DummyScript.py node-01 4 param 0.2
#   W
# """


# set lst [lassign $argv id seed]
set id [lindex $argv 0]
set seed [lindex $argv 1]
set lst [lrange $argv 2 end]


# start up programs
# ------------------------
set p0 [open "|$pname" r+]
set p1 [open "|$oname" r+]

fconfigure $p0 -buffering line
fconfigure $p1 -buffering line

puts $p0 "uci"
puts $p1 "uci"
while { [gets $p0 s] >= 0 } {
    if { $s == "uciok" } {
	break;
    }
}

while { [gets $p1 s] >= 0 } {
    if { $s == "uciok" } {
	break;
    }
}


# ------------------------------------------
# determine which program is black and white
# and which is komodo
# ------------------------------------------
if { $seed & 1 } {
    set w $p1
    set b $p0
    set k $b
} else {
    set w $p0
    set b $p1
    set k $w
}


foreach {par val} $lst {
    regsub -all _ $par " " s
    puts $k "setoption name $s value $val"
}


# --------------------------
# read opening based on seed
# --------------------------
set f [open "/home/tobias/Downloads/chessScript.02/autobook.txt"]
set n [expr ($seed / 2) % 7316]
set open ""

set c 0
while { [gets $f s] >= 0 } {
    if { $c == $n } {
	set opn $s
	break
    }
    incr c
}
close $f
set mvs "position startpos moves $opn"


set res "D"
set count 0
while { 1 } {
    puts $w $mvs
    puts $w $lev   ;# start search
    while { [gets $w s] >= 0 } {
	if { [regexp {^bestmove (\S+)} $s dmy move] } {
	    set mv $move
	    break
	}
	if { [regexp { score cp (\S+)} $s dmy score] } {
	    set sc $score
	}

	if { [regexp { score mate (\S+)} $s dmy score] } {
	    if { $score > 0 } {
		set sc 9999
	    }
	}
    }

    if {$mv == $null} { set sc 0 ; break }

    append mvs " $mv"
    set sc 0

    puts $b $mvs
    puts $b $lev   ;# start search

    while { [gets $b s] >= 0 } {
	if { [regexp {^bestmove (\S+)} $s dmy move] } {
	    set mv $move
	    break
	}
	if { [regexp { score cp (\S+)} $s dmy score] } {
	    set sc [expr $score * -1]
	}
	if { [regexp { score mate (\S+)} $s dmy score] } {
	    if { $score > 0 } {
		set sc -9999
	    }
	}
    }

    if {$mv == $null} { set sc 0 ; break }

    append mvs " $mv"

    if { $sc >  2000 } { break }
    if { $sc < -2000 } { break }

    incr count
    if { $count > $MAX_MOVES } {
	break
    }
}

puts $w "quit"
puts $b "quit"

catch {close $w}
catch {close $b}


if { $seed & 1 } {
    set sc [expr $sc * -1]
}    

if { abs($sc) <= 2000 } {
    puts "D"
    exit 0
}

if { $sc > 2000 } {
    puts "W"
    exit 0
}

if { $sc < -2000 } {
    puts "L"
}









