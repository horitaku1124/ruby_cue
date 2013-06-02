require "socket"
require "./cue_worker.rb"

class CueServer
  def run

    tcp = TCPServer.open(20000)
    Signal.trap(:INT) do
      puts "Shutting down...."
      tcp.close
      exit(0)
    end
    puts "start server"
    while true

      sock = tcp.accept
      puts " accepted."
      worder = CueWorker.new(sock)
      worder.start
    end
  end
end