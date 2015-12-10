#!/bin/bash

cd /usr/local/bin/ruby_cue
sudo -u $2 scl enable ruby193 '/opt/rh/ruby193/root/usr/bin/ruby cue_start.rb '$1' >> /var/log/ruby_cue/server.log &'