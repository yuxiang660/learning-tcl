# Create a namespace.
namespace eval uniqueNumber {
   # staticVar is a variable that will be retained between
   # evaluations. This declaration defines the variable
   # and its initial value.
   variable staticVar 0;
   # allow getUnique to be imported into other scopes
   namespace export getUnique
   # return a unique number by incrementing staticVar
   proc getUnique {} {
      # This declaration of staticVar is the equivalent of a
      # global - if it were not here, then a staticVar
      # in the local procedure scope would be created.
      variable staticVar;
      return [incr staticVar];
   }
}

# Example Script
# Display the currently visible namespaces:
puts "Visible namespaces from the global scope are:"
puts " [namespace children]\n"

# Display "get*" commands that are visible in the global
# scope before import
puts "Before import, global scope has these \"get*\" commands:"
puts " [info commands get*]\n"

# Import all exported members of the namespace uniqueNumber
namespace import ::uniqueNumber::*
# Display "get*" commands that are visible in the global
# scope after importing
puts "After import, global scope has these \"get*\" commands:"
puts " [info commands get*] \n"

# Run getUnique a couple times to prove it works
puts "first Unique val: [getUnique]"
puts "second Unique val: [getUnique]"

# Display the current value of the staticVar variable
puts "staticVar: [namespace eval uniqueNumber {set staticVar}]"
puts "staticVar: [set uniqueNumber::staticVar]"
puts "staticVar: $uniqueNumber::staticVar"

# The next line generates an error condition because
# staticVar does not exist in the global scope.
puts "staticVar is: $staticVar"