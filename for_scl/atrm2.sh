#!/bin/bash

command="ruby /usr/local/bin/ruby_cue/atrm_commnad.rb $@"
scl enable ruby193 "$command"