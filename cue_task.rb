
class CueTask
  attr_accessor :id
  @@name
  attr_reader :exe_at
  attr_reader :exe_path
  def initialize(timeStr, filePath)
    if timeStr =~ /\A(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})\z/
      @exe_at = Time.local(
        $1.to_i,
        $2.to_i,
        $3.to_i,
        $4.to_i,
        $5.to_i,
        $6.to_i
      )
      p @exe_at
    end
    @exe_path = filePath
  end
end