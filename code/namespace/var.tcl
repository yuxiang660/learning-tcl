# Create a namespace named ‘demo’
namespace eval demo {
   # name1 has no initial value
   variable name1
   # name2 and name3 are initialized
   variable name2 initial2 name3 initial3

   proc echo {name} {
      puts "hello $name"
   }
}

# Error: can't read "demo::name1": no such variable
# demo::echo $demo::name1
demo::echo $demo::name2
demo::echo $demo::name3