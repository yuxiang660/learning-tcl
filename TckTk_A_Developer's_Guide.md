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
* [Example](./code/socket/echo-client.tcl)
* Start server: `python3 echo-server.py`
* Start client: `tclsh echo-client.tcl`
