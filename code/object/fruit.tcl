# Define a set of fruit names and colors
set fruitList [list {apples {red yellow green}} {bananas yellow} {grapes {green purple}}]

foreach fruitDefinition $fruitList {
   # 1) Extract the name and possible colors from the
   # fruit definition.
   foreach {fruitName fruitColors} $fruitDefinition {break;}
   # 2) Create a global variable named for the fruit, with
   # the fruit colors as a value
   set $fruitName $fruitColors
   # 3) Define a procedure with the name of the fruit
   # being checked. The default value for "name" is
   # also the name of the fruit, which is also the name
   # of the global variable with the list of fruit colors.
   proc $fruitName [list color [list name $fruitName]] {
      upvar #0 $name fruit
      if {[lsearch $fruit $color] >= 0} {
         return "Correct, $name can be $color"
      } else {
         return "No, $name are $fruit"
      }
   }
}
# 4) Loop through the fruits, and ask the user for a color.
# Read the input from the keyboard.
# Evaluate the appropriate function to check for correctness.
foreach fruit [list apples bananas grapes ] {
   puts "What color are $fruit?"
   gets stdin answer
   puts [$fruit $answer]
}