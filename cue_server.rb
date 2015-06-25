require "socket"
require "./cue_worker.rb"
require "./cue_task.rb"

class CueServer
  def run
    tcp = TCPServer.open(20000)
    Signal.trap(:INT) do
      puts "Shutting down...."
      tcp.close
      exit(0)
    end
    puts "start server"
    worker = CueWorker.new
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
            if mode == "post"
              task = CueTask.new(timeStr, filePath)
              task.id = worker.addTask(task)
              sock.puts "job at #{task.id}"
              puts "*added."
              break
            else
              sock.write("command error\n")
              puts "*error."
            end
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