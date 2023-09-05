require './logo'

class Game

  def start
    show_logo
  end

  private

  def show_logo
    print logo.image
    gets
  end

  def logo
    @logo ||= Logo.new
  end

end
