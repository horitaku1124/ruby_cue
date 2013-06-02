
class CueWorker
  @@socket
  @@ownThread
  def initialize(socket)
    @@socket = socket
  end
  def start
    @@ownThread = Thread.new(@@socket) do |sock|
      sock.puts "Hello\r\n"
      
      while buf = sock.gets
        buf = buf.gsub(/\r|\n/, "")
        if buf == "quit"
          sock.puts "Bye."
          break
        end
        sock.print system(buf)
      end

      sock.close
    end
  end
end