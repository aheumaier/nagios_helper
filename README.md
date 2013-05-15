nagios_helper
===========

Provides a simple helper lib to easily write nagios conform checks in Ruby

Features
--------

* FIXME (list of features and unsolved problems)

Examples
--------

require 'nagios_helper'

# Initialize nagios plugin helper
check = NagiosHelper::Plugin.new()

# Load check commandline arguments (optional)
check.parse_argv()

# Execute runner method - this had to be overwritten from NagiosHelper::Plugins.run
check.run

Requirements
------------

compliant to ruby/core 1.9.3

Install
-------

sudo gem install nagios_helper

Author
------

Original author: A. Heumaier

License
-------

(The MIT License)

Copyright (c) 2013 A. Heumaier

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
