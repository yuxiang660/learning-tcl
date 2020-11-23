proc showArgs {first args} {
   puts "first: $first"
   puts "args: $args"
}

proc showArgs2 {first others} {
   puts "first: $first"
   puts "others: $args"
}

puts "Called showArgs with one arg"
showArgs oneArgument

puts "Called showArgs with two arg"
showArgs oneArgument twoArgument

puts "Called showArgs with three arg"
showArgs oneArgument twoArgument threeArgument

# Output: wrong # args: should be "showArgs2 first others"
# puts "Called showArgs2 with three arg"
# showArgs2 oneArgument twoArgument threeArgument
