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

# Output: info commands put*: puts
puts "info commands put*: [info commands put*]"

# Output: info procs put*: 
puts "info procs put*: [info procs put*]"

# Output: info commands hello: hello
puts "info commands hello: [info commands hello]"

# Output: info proc hello*: hello hello2
puts "info proc hello*: [info proc hello*]"

# Output: info procs hello*: hello hello2
puts "info procs hello*: [info procs hello*]"

# Output: info body hello: 
#   puts "hello, $name"
puts "info body hello: [info body hello]"

# Output: info args hello: name
puts "info args hello: [info args hello]"

# Output: info nameofexecutable: /opt/ActiveTcl-8.6/bin/tclsh
puts "info nameofexecutable: [info nameofexecutable]"
