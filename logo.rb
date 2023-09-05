class Logo
  attr_reader :image

  class << self
    def load
      File.read(file_path)
    rescue Errno::ENOENT
      raise "Файл #{file_name} не найден"
    end

    private

    def file_path
      File.expand_path(file_name, Dir.pwd)
    end

    def file_name
      "logo.txt"
    end
  end

  def initialize
    @image = self.class.load
  end

end
