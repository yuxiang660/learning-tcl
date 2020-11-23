proc serverOpen {channel addr port} {
   puts "$channel $addr $port"
   fileevent $channel readable "readLine $channel"
}

proc readLine {channel} {
   set len [gets $channel line]
   if {($len <= 0) && [eof $channel]} {
      close $channel
   } else {
      puts $channel $line
      flush $channel
   }
}

set serverPort 2007
set server [socket -server serverOpen $serverPort]

# Initialize a variable and wait for it to change to keep tclsh from exiting.
set running 1
vwait running
