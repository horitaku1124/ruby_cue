# coding: utf-8

require "socket"
require "./cue_worker.rb"
require "./cue_task.rb"

HOST = "localhost"
PORT = 20000
LOG_DIST = "/var/log/ruby_cue"

class CueServer
  def run
    tcp = TCPServer.open(PORT)
    Signal.trap(:INT) do
      puts "Shutting down...."
      tcp.close
      exit(0)
    end
    puts "start server"
    worker = CueWorker.new LOG_DIST
    worker.start

    while true
      sock = tcp.accept
      puts "*accepted."
      begin
        while buf = sock.gets
          command = buf.strip
          p command
          if command == "\04" then break end

          if command =~ /\A(POST) (\d{14}) (.+)\z/
            mode = $1.downcase
            timeStr = $2
            filePath = $3
            task = CueTask.new(timeStr, filePath)
            task.id = worker.addTask(task)
            sock.puts "job #{task.id} at #{timeStr}"
            puts "*added."
            break
          elsif command =~ /\A(GET)\z/
            mode = $1.downcase
            list = worker.waintingQue
            sock.puts list.length
            list.length.times do |i|
              sock.puts list[i]
            end
          elsif command =~ /\A(DELETE) (\d+)\z/
            mode = $1.downcase
            atId = $2.to_i
            worker.deleteTask atId
          else
            sock.write("command error.\n")
            puts "*error."
            break
          end
        end
        sock.flush
        sock.close
        puts "*closed."
      rescue => e
        p e
        p e.backtrace
      end
    end
  end
end