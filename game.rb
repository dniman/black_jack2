# frozen_string_literal: true

require './logo'
require './player'

class Game
  attr_reader :player

  def initialize(input: $stdio, output: $stdout)
    @input = input
    @output = output

    show_logo
    @player = Player.new(ask_user_name)
  end

  def start
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

  def ask_user_name
    gets.chomp
  end
end
