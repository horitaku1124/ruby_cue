#!/usr/bin/ruby

require "./cue_server.rb"


touch_pid = ARGV[0]

File.write(touch_pid, Process.pid)

server = CueServer.new
server.run
