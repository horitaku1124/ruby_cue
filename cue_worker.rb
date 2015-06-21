
class CueWorker
  @@ownThread
  @@schedule = []
  def initialize()
  end
  def addTask(taks)
    @@schedule << taks
  end
  def start
    @@ownThread = Thread.new do
      puts "Hello\r\n"
      begin
        while true
          sleep 1
          len = @@schedule.length
          #puts "check #{len}"
          @@schedule.length.times do |i|
            task = @@schedule[i]
            if task != nil && task.exe_at < Time.now
              work = Thread.new do
                p task.exe_at
                sh = task.exe_path
                p `#{sh}`
              end
              @@schedule[i] = nil
            end
          end
        end
      rescue => e
        p e
      end
    end
  end
end