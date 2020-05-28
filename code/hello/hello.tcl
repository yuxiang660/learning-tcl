#! /usr/bin/env wish
proc factorial {val} {
    set result 1
    while {$val > 0} {
        set result [expr $result * $val]
        incr val -1
    }
    return $result
}

entry .value -width 6 -relief sunken -textvariable value
label .description -text "factorial is"
label .result -textvariable result
button .calculate -text "Calculate" -command {set result [factorial $value]}

# bind calculate action with "Enter" button
bind .value <Return> {
    # button component command
    .calculate flash
    # invoke command of ".calculate" button
    .calculate invoke
}

# padding 1mm empty space
grid .value .description .result -padx 1m -pady 1m
grid .calculate - - -padx 1m -pady 1m
