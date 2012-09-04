# Description [![Build Status](https://secure.travis-ci.org/martinos/rubyc.png?branch=master)](http://travis-ci.org/martinos/rubyc)
Adds Ruby's power to the command line.
## Introduction
Sometimes I need to process filess at command line for parsing, filtering etc.  Unix offers many tool (grep, sed, awk) for doing those actions. However, I always have had a hard time to remember how to use them besause of their cryptic syntax.  They also use Unix regexes which are more limited than ruby's engine ones.

Since Ruby is my day to day tool, I tried to use it using the -n and -p option of ruby. But it's syntax is very cryptic too. Using gets, $_ etc.

For this reason I have created Rubyc, which stands for Ruby Command line.

Supports many enumerator methods applied to STDIN. The current line is represented by the "line" variable name or it's shorter alias 'l'.

To get help:
  rubyc help

## Examples
``` bash
$ ls | rubyc map 'line.upcase'
GEMFILE
RAILS_VERSION
README.RDOC
RAKEFILE
ACTIONMAILER
ACTIONPACK
...
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