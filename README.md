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
### Problem 1
How do you capitalize all lines that comes from stdin?
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