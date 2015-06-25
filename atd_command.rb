#!/usr/bin/env ruby

require "socket"
require "Timeout"

HOST = "localhost"
PORT = 20000

skip = 0
filePath = nil
exeAt = nil
ARGV.length.times do |i|
  if skip > 0 then
    skip -= 1
    next
  end
  option = ARGV[i]

  if option =~ /\A\-([a-zA-Z])\z/
    mode = $1.downcase

    case mode
    when "f"
      filePath = ARGV[i + 1]
      skip = 1
    else
      raise "-#{mode} is undefined"
    end
  elsif option =~ /\A\d{10}\z/
    exeAt = option
  else
    raise "unrecognized option => #{option}"
  end
end

if filePath && exeAt
  puts "ok"
  sock = nil
  begin
    Timeout.timeout(2, Timeout::Error) {
      sock = TCPSocket.open(HOST, PORT)
      sock.puts "POST 20#{exeAt}00 #{filePath}"
      puts 'sock.get'
      res = sock.gets
      p res
    }
  rescue => e
    puts "timed out"
  ensure
    if sock
      sock.close
      p "closed"
    end
  end
elsif !filePath
  raise "-f option is missing"
elsif !exeAt
  raise "timestamp is missing => [[CC]YY]MMDDhhmm"
end