require './logo'

class Game
  def initialize
    system("clear")
    self.show_logo
  end

  private

  def show_logo
    loop do
      print logo.image
      break if enter?
    end
  end

  def logo
    @logo ||= Logo.new
  end

  def enter?
    gets == "\n"
  end
end
