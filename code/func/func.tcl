proc memPlacement {num} {
  set f [open "data.txt"]
  while {[gets $f line] >= 0} {
    if {[regexp "genblk1\\\[$num\\\]" $line]} {
      regexp {\s*\w* \s*\w* \s*\w* \s*\w* \s*(\w*)} $line -> mem
      return $mem
    }
  }
  close $f
}

for {set i 0} {$i < 32} {incr i} {
  set mem [memPlacement $i]
  puts "${i}($mem)"
}

puts {mem#(physical) = <value>, <read>}
for {set i 0} {$i < 32} {incr i} {
  set mem [memPlacement $i]
  puts "${i}($mem)"
}
