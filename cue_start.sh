#!/bin/bash

cd /usr/local/bin/ruby_cue
/usr/bin/ruby start_test.rb $1 >> /var/log/ruby_cue/server.log &
