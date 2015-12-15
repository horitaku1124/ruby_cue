#!/bin/bash

command="ruby /usr/local/bin/ruby_cue/atq_command.rb $@"
scl enable ruby193 "$command"