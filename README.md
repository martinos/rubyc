# Description [![Build Status](https://secure.travis-ci.org/martinos/rubyc.png?branch=master)](http://travis-ci.org/martinos/rubyc)
Adds Ruby's power to the command line.
## Introduction
Sometimes we need to process files or streams at the bash prompt for filtering, parsing, calculating etc.  Unix offers many tools for doing those actions: grep, sed, awk etc. However, their usage are not easy to remember besause of their cryptic syntax. They also use Unix regexes which are more limited than ruby's ones.

The Ruby interpreter offers us many command line options for processing files or pipes. The -p, -n options allows us to process lines one at a time. But their syntaxes are not really easy to remember, since it uses non Rubyish syntax, using $_, gets and print kernel methods.

For this reason, I have created Rubyc, which stands for Ruby Command line. Rubyc supports many enumerator methods applied to STDIN. The current line is represented by the "line" variable name or it's shorter alias 'l.
## Installation
```
gem install rubyc
```
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
### Use Case: CSV
Extract columns 2 and 3 of a csv file that has columns containing commas. Note that, in that case the "cut" shell command does not work.

The shell way
``` bash
$ ???
```
The Ruby interpreter with options way:
``` bash
$ cat file1.csv | ruby -pe 'require "csv";csv = CSV.parse_line($_); $_ = [csv[2], csv[4]].to_s + "\n"'
```
The Rubyc way:
``` bash
$ cat file1.csv | rubyc map -r csv 'csv = CSV.parse_line(l); [csv[2], csv[3]]'
```
NOTE: -r is an alias for the --require= option which 
### Problem 3 Colorize Stderr
``` bash
$ rake > >(???)
```
The Rubyc way:
``` bash
$ rake > >(rubyc map -r colorize 'l.red')
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
