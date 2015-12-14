#!/usr/bin/env ruby
# coding: utf-8

require "socket"
#require "Timeout"

HOST = "localhost"
PORT = 20000

skip = 0
filePath = nil
arguments = []
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
    when "a" # Some aruguments here.
      arguments << ARGV[i + 1]
      skip = 1
    when "f" # Specify the location
      filePath = ARGV[i + 1]
      skip = 1
    when "t" # When que is fired
      if ARGV[i + 1] =~ /\A\d{10}\z/
        exeAt = ARGV[i + 1]
        skip = 1
      else
        raise "Illegal -t parameter."
      end
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
  # puts "ok"
  sock = nil
  begin
    #Timeout.timeout(2, Timeout::Error) {
      sock = TCPSocket.open(HOST, PORT)
      args = arguments.join(" ")
      sock.puts "POST 20#{exeAt}00 #{filePath} #{args}"
      # puts 'sock.get'
      res = sock.gets
      puts res
    #}
  rescue => e
    STDERR.puts e.message
    STDERR.puts "socket error"
  ensure
    if sock
      sock.close
      # p "closed"
    end
  end
elsif !filePath
  raise "-f option is missing"
elsif !exeAt
  raise "timestamp is missing => [[CC]YY]MMDDhhmm"
end