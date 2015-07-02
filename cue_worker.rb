# coding: utf-8

class CueWorker
  @@ownThread
  @@schedule = []
  @@mutex
  @@uniqueId
  @@logDist
  def initialize(logDist)
    @@mutex = Mutex.new
    @@uniqueId = 0
    @@logDist = logDist
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
          begin
            log = File.open(@@logDist + "/cue_#{task.id}", "w")
            sh = task.exe_path

            log.puts task.exe_at
            log.puts sh

            log.puts `#{sh}`
          rescue => e
            p e
          ensure
            if log
              log.puts "end"
              log.close
            end
          end
        end
        @@schedule[i] = nil
      end
    end
  end
  def waintingQue
    str = []
    len = @@schedule.length
    len.times do |i|
      task = @@schedule[i]
      if task != nil && task.exe_at > Time.now
        str << "#{task.id} - #{task.exe_at}\n"
      end
    end
    str
  end

  def deleteTask(atId)
    @@mutex.synchronize {
      len = @@schedule.length
      len.times do |i|
        task = @@schedule[i]
        if task == nil then next end
        if task.id == atId
          @@schedule[i] = nil
        end
      end
    }
  end
end