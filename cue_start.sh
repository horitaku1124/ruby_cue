#!/bin/bash

pid=$1
user=$2
cd /usr/local/bin/ruby_cue
sudo -u $user sh -c '/usr/bin/ruby cue_start.rb '$pid' >> /var/log/ruby_cue/server.log &