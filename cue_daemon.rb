#!/usr/bin/ruby


if ARGV.length == 0
  puts "Usage:) pidfile"
  exit(1)
end
pifile = ARGV[0];

Process.exit if Process.fork

Process.setsid 

Process.exit if Process.fork

Dir::chdir("/")
File::umask(0)
STDIN.reopen("/dev/null")
STDOUT.reopen("/dev/null", "w")
STDERR.reopen("/dev/null", "w")

sid = Process.pid
f = open(pifile, "w")
f.print sid
f.close

server = CueServer.new
server.run
