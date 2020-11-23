proc hello {name} {
   puts "hello, $name"
}

proc hello2 {name} {
   puts "hello2, $name"
}

set myName "ABC"

# Output: hello, ABC
hello $myName

# Output: info exists myName: 1
puts "info exists myName: [info exists myName]"

# Output: info proc hello*: hello hello2
puts "info proc hello*: [info proc hello*]"

# Output: info body hello: 
#   puts "hello, $name"
puts "info body hello: [info body hello]"

# Output: info args hello: name
puts "info args hello: [info args hello]"

# Output: info nameofexecutable: /opt/ActiveTcl-8.6/bin/tclsh
puts "info nameofexecutable: [info nameofexecutable]"
