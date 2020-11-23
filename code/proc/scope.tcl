proc top {topArg} {
   set localArg [expr $topArg+1]
   puts "Before calling bottom localArg is: $localArg"
   bottom localArg
   puts "After calling bottom, localArg is: $localArg"
}

proc bottom {bottomArg} {
   # The value of $bottomArg is localArg, but we cannot use localArg here because
   # the bottom procedure doesn't know top local variable localArg
   # arg is similar to reference in C
   upvar $bottomArg arg
   puts "bottom is passed $bottomArg with a value of $arg"
   incr arg
}

top 2

# Output:
# Before calling bottom localArg is: 3
# bottom is passed localArg with a value of 3
# After calling bottom, localArg is: 4
