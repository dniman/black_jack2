# frozen_string_literal: true

require './logo'
require './player'

class Game
  attr_reader :player

  def initialize(input: $stdio, output: $stdout)
    @input = input
    @output = output
    @player = Player.new

    system('clear')
    show_logo
  end

  def start
    player.ask_name
  end

  private
  attr_reader :input, :output

  def show_logo
    output.print logo.image
    input.gets
  end

  def logo
    @logo ||= Logo.new
  end

  def enter?
    input.gets == "\n"
  end
end
