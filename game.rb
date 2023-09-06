require './logo'
require 'byebug'

class Game
  def initialize
    system("clear")
    self.show_logo
  end

  private

  def show_logo
    loop do
      print logo.image
      break if gets == "\n"
    end
  end

  def logo
    @logo ||= Logo.new
  end

end
