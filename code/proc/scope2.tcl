
# Create procedure stack1 with a local variable x.
# display the value of x, call stack2, and redisplay the
# value of x
proc stack1 {} {
   set x 1;
   puts "X in stack1 starts as $x"
   stack2
   puts "X in stack1 ends as $x"
   puts ""
}

# Create procedure stack2 with a local variable x.
# display the value of x, call stack3, and redisplay the
# value of x
proc stack2 {} {
   set x 2;
   puts "X in stack2 starts as $x"
   stack3
   puts "X in stack2 ends as $x"
}

proc stack3 {} {
   set x 3;
   puts "X in stack3 starts as $x"
   puts ""
   # display the value of x at stack levels relative to the current level.
   for {set i 1} {$i <= 3} {incr i} {
      upvar $i x localX
      puts "X at upvar $i is $localX"
   }

   puts "\nx is being modified from procedure stack3\n"
   # Evaluate a command in the scope of procedures above the current call level.
   # Add 10 to the value of x in the proc that called stack3 (stack2)
   uplevel 1 {incr x 10}
   # Add 100 to the value of x in the proc that called stack2 (stack1)
   uplevel 2 {incr x 100}
   # Add 200 to the value of x in the global scope.
   uplevel #0 {incr x 200}
   puts ""

   # display the value of x at absolute stack levels
   for {set i 0} {$i <= 3} {incr i} {
      set absolute_stack_level $i
      upvar #$absolute_stack_level x localX_absolute_stack_level
      puts "X at upvar #$absolute_stack_level is $localX_absolute_stack_level"

      set relative_stack_level [expr 3 - $i]
      upvar $relative_stack_level x localX_relative_stack_level
      puts "X at upvar $relative_stack_level is $localX_relative_stack_level"
   }
   puts ""
}

set x 0;
puts "X in global scope is $x"
stack1
puts "X in global scope ends as $x"

# Script Output
# X in global scope is 0
# X in stack1 starts as 1
# X in stack2 starts as 2
# X in stack3 starts as 3
# X at upvar 1 is 2
# X at upvar 2 is 1
# X at upvar 3 is 0
# x is being modified from procedure stack3
# X at upvar #0 is 200
# X at upvar 3 is 200
# X at upvar #1 is 101
# X at upvar 2 is 101
# X at upvar #2 is 12
# X at upvar 1 is 12
# X at upvar #3 is 3
# X at upvar 0 is 3
# X in stack2 ends as 12
# X in stack1 ends as 101
# X in global scope ends as 200
