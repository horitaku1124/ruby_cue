#!/usr/bin/env ruby
# coding: utf-8

require "socket"
require "Timeout"

HOST = "localhost"
PORT = 20000


skip = 0
atId = nil
ARGV.length.times do |i|
  if skip > 0 then
    skip -= 1
    next
  end
  option = ARGV[i]

  if option =~ /\A(\d+)\z/
    atId = $1.downcase
  else
    raise "unrecognized option => #{option}"
  end
end

if atId
  Timeout.timeout(2, Timeout::Error) {
    sock = TCPSocket.open(HOST, PORT)
    sock.puts "DELETE #{atId}"
  }
else
    raise "identify number"
end