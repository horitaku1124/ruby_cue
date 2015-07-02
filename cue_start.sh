#!/bin/bash

cd /usr/local/bin/ruby_cue
/usr/bin/ruby start_test.rb >> /var/log/ruby_cue/server.log &
