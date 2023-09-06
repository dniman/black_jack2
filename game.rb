# frozen_string_literal: true

require './logo'
require './player'

class Game
  def initialize
    system('clear')
    show_logo
  end

  def start
    player = Player.new
    player.ask_name
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
