# Description [![Build Status](https://secure.travis-ci.org/martinos/rubyc.png?branch=master)](http://travis-ci.org/martinos/rubyc)
Adds Ruby's power to the command line.
## Introduction
Sometimes we need to process files or stream at the bash prompt for filtering, parsing, calculating etc.  Unix offers many tools (grep, sed, awk etc.) for doing those actions. However, their usage are not easy to remember besause of their cryptic syntax. They also use Unix regexes which are more limited than ruby's ones.

The Ruby interpreter offers us many command line options for processing files or pipes. The -p, -n options allows us to process lines one at a time. But their syntaxes art not really easy to remember, since it uses non Rubyish syntax, using $_.

For this reason I have created Rubyc, which stands for Ruby Command line.

Supports many enumerator methods applied to STDIN. The current line is represented by the "line" variable name or it's shorter alias 'l'.

To get help:
  rubyc help

## Examples
### Problem 1
Capitalize stdin
``` bash
$ ls | awk '{print toupper($0)}'
$ ls | rubyc map 'line.upcase'
$ ls | ruby -pe '$_ = $_.upcase'
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