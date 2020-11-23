proc alpha {} {
return "This is the alpha proc"
}
# Example Script
puts "Invocation of procedure alpha: [alpha]"
rename alpha beta
catch alpha rtn
puts "Invocation of alpha after rename: $rtn"
puts "Invocation of procedure beta: [beta]"
rename beta ""
beta

# Script Output
# Invocation of procedure alpha: This is the alpha proc
# Invocation of alpha after rename: invalid command name "alpha"
# Invocation of procedure beta: This is the alpha proc
# invalid command name "beta"