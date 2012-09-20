# Rubyc [![Build Status](https://secure.travis-ci.org/martinos/rubyc.png?branch=master)](http://travis-ci.org/martinos/rubyc)
## Description
Adds Ruby's power to the command line.
## Introduction
Sometimes we need to process files or streams at the bash prompt for filtering, parsing, calculating etc.  Unix offers many tools for doing those actions: grep, sed, awk etc. However, their usage are not easy to remember besause of their cryptic syntax. They also use Unix regexes which are more limited than Ruby's ones.

The Ruby interpreter offers us some command line options for processing files or pipes. The -p, -n options in combination of the -e option, allows us to process lines one at a time. Personnaly I never remember how to use them.

For this reason, I have created Rubyc, which stands for Ruby Command line.
## Installation
```
gem install rubyc
```
## Usage
Rubys supports some Enumerable methods applied to each line to the stdin stream. 

Rubyc gives you the __line__ variable and ıts shorter alias __l__ to represent the current line on which Rubyc is iterating. 

The __index__ and __lnum__ variables are also available to you. The __index__ variable represents the index of the line starting at 0 whereas __lnum__ is the line number which starts at 1. 
## Examples
### Use Case: Upcasing
Upcase what is comming from stdin.

The awk way:
``` bash
$ ls | awk '{print toupper($0)}'
```
The Ruby interpreter with options way:
``` bash
$ ls | ruby -pe '$_ = $_.upcase'
```
The Rubyc way:
``` bash
ls | rubyc map 'line.upcase'
```
### Use Case: CSV File Processing
Extract columns 2 and 3 of a csv file that has columns containing commas. Note that, in that case the "cut" shell command does not work.

The shell way
``` bash
$ ???
```
The Ruby interpreter with options way:
``` bash
$ cat file1.csv | ruby -r csv -pe 'csv = CSV.parse_line($_); $_ = [csv[1], csv[2]].to_s + "\n"'
```
The Rubyc way:
``` bash
$ cat file1.csv | rubyc map -r csv 'csv = CSV.parse_line(l); [csv[1], csv[2]]'
```
NOTE: -r is an alias for the --require= option indicates the gems needed for the exectution of the script. Note that for multiple require, gems must me separated with a :.

### Use Case: Colorize Stderr
The shell way:
``` bash
$ rake 2> >(while read line;do echo -e "\033[31m$line\033[0m";done)
```
The Rubyc way:
``` bash
$ rake 2> >(rubyc map -r colorize 'l.red')
```
### Use Case: Counting insertion in database tables
Extract the number of insertions per table in a rails log file.

The shell way:
``` bash
$ cat development.log | grep "INSERT INTO" | sed 's/\(.*\)INSERT INTO..\([a-z]*\).*/ \2 /' | sort | uniq -c
```
The Rubyc way:
``` bash
$ cat development.log | rubyc count_by 'l =~ /INSERT INTO \"(\w+)\"/; $1'
--- 
users: 14
adresses: 18
objects: 102191
phone_numbers: 47
```


Here are the currently supported methods:
```
compact      # Remove empty lines
count_by     # Count the number of lines that have the same property. The property is defined by the return value of the given the block.
grep         # Enumerable#grep the first argument is the pattern matcher and the second is the block executed on each line.
map          # Apply Enumerable#map on each line and outputs the results of the block by calling to_s on the returned object.
merge        # Merge consecutive lines
scan         # String#scan
select       # Enumerable#select
sort_by      # Emumerable#sort_by
sum          # Rails Enumerable#sum
uniq         # uniq
```
