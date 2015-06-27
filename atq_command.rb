#!/usr/bin/env ruby
# coding: utf-8

require "socket"
require "Timeout"

HOST = "localhost"
PORT = 20000

Timeout.timeout(2, Timeout::Error) {
  sock = TCPSocket.open(HOST, PORT)
  sock.puts "GET"
  count = sock.gets.strip.to_i
  count.times do |i|
    p sock.gets
  end
}