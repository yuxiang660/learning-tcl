<!-- TOC -->

- [Introduction](#introduction)
- [Tcl/Tk Features](#tcltk-features)
   - [Tck extensions](#tck-extensions)
   - [Overview](#overview)
      - [Goal](#goal)
      - [Tcl As an Extensible Interpreter](#tcl-as-an-extensible-interpreter)
      - [Tcl As an Embeddeable Interpreter](#tcl-as-an-embeddeable-interpreter)
- [The Mechanics of Using the Tcl and Tk Interpreters](#the-mechanics-of-using-the-tcl-and-tk-interpreters)
   - [Two nterpreters](#two-nterpreters)
- [Introduction to the Tcl Language](#introduction-to-the-tcl-language)
   - [Syntax](#syntax)
   - [Process Tcl Command](#process-tcl-command)
      - [Substitution](#substitution)
      - [Evaluation](#evaluation)
   - [Data Types](#data-types)
      - [Assigning Values to Variables<br>](#assigning-values-to-variablesbr)
      - [Strings](#strings)
      - [Lists](#lists)
      - [Associative Arrays](#associative-arrays)
      - [Handles](#handles)
   - [Arithmetic and Boolean Operations](#arithmetic-and-boolean-operations)
      - [Math Operations](#math-operations)
      - [Conditionals](#conditionals)
      - [Looping](#looping)
   - [Modularization](#modularization)
      - [Procedures](#procedures)
- [The File System, Disk I/O, and Sockets](#the-file-system-disk-io-and-sockets)
   - [Navigating the File System](#navigating-the-file-system)
   - [Input/Output in Tcl](#inputoutput-in-tcl)
      - [Output](#output)
      - [Input](#input)
      - [Creating a Channel](#creating-a-channel)
      - [Close a Channel](#close-a-channel)
   - [Sockets](#sockets)
      - [Using a Client Socket](#using-a-client-socket)
      - [Controlling Data Flow](#controlling-data-flow)
      - [Server Sockets](#server-sockets)
- [Using Strings and Lists](#using-strings-and-lists)
   - [Converting a String into a List](#converting-a-string-into-a-list)
   - [Examining the List with a for Loop](#examining-the-list-with-a-for-loop)
   - [Using the foreach Command](#using-the-foreach-command)
   - [Using string match Instead of string first](#using-string-match-instead-of-string-first)
   - [Variable Scope](#variable-scope)
      - [Global Information Variables](#global-information-variables)
- [Building Complex Data Structures with Lists and Arrays](#building-complex-data-structures-with-lists-and-arrays)
   - [Excepting Handling in Tcl](#excepting-handling-in-tcl)
   - [Examining the State of the Tcl Interpreter](#examining-the-state-of-the-tcl-interpreter)
   - [Loading Code from a Script File](#loading-code-from-a-script-file)
- [Procedure Techniques](#procedure-techniques)
   - [Arguments to Procedures](#arguments-to-procedures)
      - [Variable Number of Arguments to a Procedure](#variable-number-of-arguments-to-a-procedure)
      - [Default Values for Procedure Arguments](#default-values-for-procedure-arguments)
   - [Renaming or Deleting Commands](#renaming-or-deleting-commands)
   - [Getting Information About Procedures](#getting-information-about-procedures)
   - [Evaluating a String as a Tcl Command](#evaluating-a-string-as-a-tcl-command)
   - [Working with Global and Local Scopes](#working-with-global-and-local-scopes)
      - [Global and Local Scope](#global-and-local-scope)
   - [Making a Tcl Object](#making-a-tcl-object)

<!-- /TOC -->

# Introduction
Notes of book "Tcl/Tk A developer's guide"

# Tcl/Tk Features
## Tck extensions
   * Tk - Tool Kit
   * [incr Tcl]
      allow many complex tasks to be easily automated
   * BLT
      includes a very useful graph and bar-chart widget
   * TclX
      adds new programming tools to the base Tcl language
## Overview
Tcl stands for Tool Command Language, as a scripting language for gluing other applications together into a new application.
### Goal
   * create a language that could be embedded in other programs and easily extended with new functionality.
   * execute other programs in the manner of a shell scripting language.
### Tcl As an Extensible Interpreter
   * take the existing project libraries and turn them into commands with a Tcl interpreter
### Tcl As an Embeddeable Interpreter
   * use Tcl calls to interpret the configuration file for hard-coded values

# The Mechanics of Using the Tcl and Tk Interpreters
## Two nterpreters
   * tclsh
   * wish
      * wish interpreter includes the core Tcl interpreter, with all commands tclsh supports plus the Tk graphics extensions.

# Introduction to the Tcl Language
## Syntax
Tcl is a position-based language, not a keyword-based language. The first word of a Tcl command line must always be a Tcl command; either a built-in command, a procedure name, or an external command.
* Substitution Symbols
   * `$` <br>
   must be a variable name. Tcl will substitute the value assigned to that variable for the `$varName` string.
   * `[]` <br>
   the words between the square brackets must be a Tcl command string.

* Grouping Symbols
   * `""` <br>
   groups multiple words into a single string. Substitutions will occu within this string.
   * `{}` <br>
   groups multiple words into a single string. No substitution will occur.

* Other
   * `\` <br>
   continue a command across multiple lines
   * `;` <br>
   marks the end of a command

* Command Results
The Tcl interpreter will evaluate a command enclosed within square brackets immediately and replace that string with the value returned when the command is evaluated.

## Process Tcl Command
### Substitution
* command substitution: replace `[...]`
* variable substitution: replace `$`
```tcl
set x 2
set y 3
# output: The sum of $x and $y is returned by [expr $x+$y]
puts {The sum of $x and $y is returned by [expr $x+$y]}
# output: The sum of 2 and 3 is 5
puts "The sum of $x and $y is [expr $x+$y]"
# output: The sum of 2 and 3 is returned by [expr 2+3]
puts "The sum of $x and $y is returned by \[expr $x+$y\]"
# output: The sum of $x + $y is returned by "[expr $x+$y]"
puts "The sum of \$x + \$y is returned by \"\[expr \$x+\$y\]\""
```

### Evaluation
* `set x [expr [set a 3] + 4 + $a]`<br>
Scan the command from left to right, encounter the left square bracket, and reentered with that subset of the command
   * `expr [set a 3] + 4 + $a`<br>
   The command evaluator is called again
      * `set a 3`<br>
      No more levels of brackets and no substitutions to perform, so the command is evaluated. 3 replaces the bracketed command
      * `expr 3 + 4 + $a`<br>
       The variables are now substituted, and `$a` is replaced by 3
   * `expr 3 + 4 + 3`<br>
   Evaluate the string, the result (10) is returned. The substitution is performed
* `set x 10`
   Evaluate the string and x is set to 10.

## Data Types
### Assigning Values to Variables<br>
`set varName value` It allocates space for a variable and data and assigns the data to that variable.
### Strings
`string match pattern string`
```tcl
% set str "This is a test, it is only a test"
This is a test, it is only a test
% string match "*test*" $str
1
% string match {not present} $str
0
```
`string tolower string`

`string toupper string`

`string length string`

`string first substr string`

`string last substr string`

`string range string first last`

`format formatString ?data1? ?data2? ...`

`scan textString formatString ?varName1? ?varName2? ...`

### Lists

`list element1 ? element2? ... ?elementN?`

`lappend listName ?element? ... ?elementN?`

`split data ?splitChar?`

`join list ?separator?`

`llength list`

`lindex list index`

`linsert list position element1 ... ?elementN?`

`lreplace list first last element1 .. ?elementN?`

### Associative Arrays
```tcl
set fruit(apples) 10
set fruit(pears) 5
```

`array names arrayName ?pattern?`

`array set arrayName {index1 value1 ... indexN valueN}`

`array get arrayName`

### Handles
* channel<br>
A handle that references an I/O device such as a file, serial port, or TCP socket.
* graphic<br>
A handle that refers to a graphic object created by a wish command.
* http<br>
A handle that references data returned by an http::geturl operation.

## Arithmetic and Boolean Operations
### Math Operations
`expr mathExpression`
### Conditionals
* `if`

```tcl
if {testExpression1} {
   body1
} ?elseif {testExpression2} {
   body2
} ?else {
   body3
}
```

* `switch`

```tcl
switch ?option? string {
   pattern1 body1
   ?pattern2 body2?

   ?default defaultBody?
}
```

The options `-exact`, `-glob`(default), `-regexp` control how the string and pattern will be compared.

### Looping
   * `for` A numeric loop command
   * `while` A conditional loop command
   * `foreach` A list-oriented loop command
```tcl
for {set i 0} {$i < 2} {incr i} {
   puts "I is : $i"
}
```

```tcl
set x 0;
while {$x < 5} {
   set x [expr $x+$x+1]
   puts "X: $x"
}
```

```tcl
foreach num {1 2 3 4 5} {
   set total [expr $total + $num]
}
puts "The total is: $total"
```

## Modularization
* Subroutines (with the proc command)
* Multiple source files (with the source command)
* Libraries (with the package command)

### Procedures
```tcl
proc fib {num} {
   if {$num <= 2} {return 1}
   return [expr [fib [expr $num - 1]] + [fib [expr $num - 2]]]
}

for {set i 1} {$i < 6} {incr i} {
   puts "Fibonacci series element $i is : [fib $i]"
}
```

# The File System, Disk I/O, and Sockets
## Navigating the File System
* `glob`<br>
Search a path for items with names or types that match pattern.
```tcl
foreach fileName [glob *.c *.h] {
   puts "C Source: $fileName"
}
```

* `file subcommand arguments`<br>
```tcl
set path [file join "PB 1400" "program files" Tcl bin wish.exe]
puts "join: $path"
puts "dirname: [file dirname $path]"
puts "root: [file rootname $path]"
puts "tail: [file tail $path]"

# Outputs:
# join: PB 1400/program files/Tcl/bin/wish.exe
# dirname: PB 1400/program files/Tcl/bin
# root: PB 1400/program files/Tcl/bin/wish
# tail: wish.exe
```

## Input/Output in Tcl
All I/O in Tcl is done through channels. A channel is an I/O device abstraction similar to an I/O stream in C. Three channels are predefine in Tcl:
* stdin
* stdout
* stderr
### Output
`puts ?-nonewline? ?channel? outputString`
* ?channel? - If this argument is not used, send ot standard output.
### Input
`gets channelID ?varName?`

`read channelID numBytes`

`read ?-nonewline? channelID`

* Read data from a channel until an End-Of-File (EOF) condition.

### Creating a Channel
`open fileName ?access? ?permissions?`

### Close a Channel
`close channel`

## Sockets
Two types of sockets:
* Client socket (very much like a connection to a file or pipe)
* Server socket (waits for a client to connect to it)

### Using a Client Socket
[Example: echo-client.tcl](./code/socket/echo-client.tcl)
* Start server: `python3 echo-server.py`
* Start client: `tclsh echo-client.tcl`

### Controlling Data Flow
`fconfigure channelID ?name? ?value?`
* name
   * -blocking boolean
   * -buffering newValue

`flush channelID`

`fileevent channel direction script`

### Server Sockets
The server-side socket command registers a script to be evaluated when a client socket requests a connection to the server.

`socket -server script port`
* script<br>
This script will have three arguments appended to the script before it is evaluated:
   * channel
   * IP Address
   * port

[Example: echo-server.tcl](./code/socket/echo-server.tcl)
* `tclsh echo-server.tcl`
* `tclsh echo-client.tcl`
   * client send `COMMAND` to server, and server send back `COMMAND` to client

# Using Strings and Lists
## Converting a String into a List
`set urlList [split $urls "\n"]`

## Examining the List with a for Loop
```tcl
for {set pos 0} {$pos < [llength $urlList]} {incr pos} {
   if {[string first "Noumena" [lindex $urlList $pos]] >= 0} {
      puts "NOUMENA PAGE: \n [lindex $urlList $pos]"
   }
}
```

## Using the foreach Command
```tcl
foreach item $urlList {
   if {[string first "Noumena" $item] >= 0} {
      puts "NOUMENA PAGE: \n $item"
   }
}
```

## Using string match Instead of string first
```tcl
foreach item $urlList {
   if {[string match {*[Nn]oumena*} $item] >= 0} {
      puts "NOUMENA PAGE: \n $item"
   }
}
```

## Variable Scope
A variable declared and used within a proc can be accessed only within that proc, unless it is made global with the `global` command.
### Global Information Variables
* argv - A list of command line arguments.
* argc - The number of list elements in argv.
* env - An associative array of environment variables.
   * `puts $env(PATH)`
   * `array get env`

# Building Complex Data Structures with Lists and Arrays
## Excepting Handling in Tcl
`catch script ?varName?`

`error informationalString ?Info? ?Code?`

## Examining the State of the Tcl Interpreter
`info subCommand arguments`
Provide information about the interpreter state, refer to [example: info.tcl](./code/interpreter/info.tcl)
* subCommand
   * exists varName - Returns True if a variable has been defined.
   * proc globPattern - Returns a list of procedure names that match the glob pattern.
   * body procName - Returns the body of a procedure.
   * args procName - Returns the names of the arguments for a procedure.
   * nameofexecutable - Returns the full path name of the binary file from which the application was invoked.

## Loading Code from a Script File
The `source` command loads a file into an existing Tcl script. It is similar to the `#include` in C, the `source` in C-shell programming.

`source fileName`

# Procedure Techniques
Tcl supports the common programming concept of subroutines -- procedures that accept a given number of arguments and return one or more values.
Tcl also supports procedures with variable numbers of arguments and procedures with arguments that have default values.

## Arguments to Procedures
### Variable Number of Arguments to a Procedure
[Example: variable_args.tcl](./code/proc/variable_args.tcl)
* The last argument must be `args`
```tcl
proc showArgs {first args} {
   puts "first: $first"
   puts "args: $args"
}
```
### Default Values for Procedure Arguments
```tcl
proc showDefaults {firstArg {numberArg 0} {stringArg {default string}}} {
   puts "firstArg: $firstArg"
   puts "numberArg: $numberArg"
   puts "stringArg: $stringArg"
}
# Output:
# firstArg: firstArgument
# numberArg: 0
# stringArg: default string
showDefaults firstArgument
```

## Renaming or Deleting Commands
[Example: rename.tcl](./code/proc/rename.tcl)
```tcl
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
```

## Getting Information About Procedures
```tcl
# Check to see if md5 command is defined. If not, load a
# Tcl version
if {[string match [info commands md5] ""]} {
   source "md5.tcl"
}
```

## Evaluating a String as a Tcl Command
The `eval` command concatenates its arguments into a string and then evaluates that string as if it were text in a script file.
* the command that is evaluted by `eval` will lose one level of grouping.
```tcl
set cmd(0) {set a 1}
set cmd(1) {puts "start value of A is: $a"}
set cmd(2) {incr a 3}
set cmd(3) {puts "end value of A is: $a"}
for {set i 0} {$i < 4} {incr i} {
   eval $cmd($i)
}
# Script Output
# start value of A is: 1
# end value of A is: 4
```

## Working with Global and Local Scopes
The `upvar` and `uplevel` commands allow procedures to interact with higher-level scopes.
### Global and Local Scope
* `upvar ?level? varName1 localName ?Name2? ?localName2?`<br>
   The `upvar` command will link a local variable to one in a previous (higher) stack scope, refer to the [example](./code/proc/scope.tcl)
* `uplevel`<br>
   Refer to the [example](./code/proc/scope2.tcl)

## Making a Tcl Object
[Example:fruit.tcl](./code/object/fruit.tcl)
