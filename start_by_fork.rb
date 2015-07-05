#!/usr/bin/ruby

require "./cue_server.rb"

touch_pid = ARGV[0]
if !touch_pid
  raise 'missing arguement about PID file path.'
end

File.open(touch_pid, "w") do |file|
  pid = fork do
    server = CueServer.new
    server.run
  end
  file.write(pid)
end