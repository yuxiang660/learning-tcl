set server "localhost"
set port "2007"

set connection [socket $server $port]
puts $connection "COMMAND"
flush $connection
puts [gets $connection result]
puts $result
