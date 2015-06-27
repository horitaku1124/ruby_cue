# coding: utf-8

class CueWorker
  @@ownThread
  @@schedule = []
  @@mutex
  @@uniqueId
  def initialize
    @@mutex = Mutex.new
    @@uniqueId = 0
  end
  def nextId
    @@uniqueId
  end
  def addTask(taks)
    id = 0
    @@mutex.synchronize {
      @@schedule << taks
      @@uniqueId += 1
      id = @@uniqueId
    }
    id
  end
  def start
    @@ownThread = Thread.new do
      puts "Hello Worker\r\n"
      begin
        while true
          sleep 1
          @@mutex.synchronize {
            tick
          }
        end
      rescue => e
        p e
      end
    end
  end
  def tick
    len = @@schedule.length
    len.times do |i|
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
end