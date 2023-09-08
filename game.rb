# frozen_string_literal: true

require './logo'
require './dealer'
require './player'
require './dealer'

class Game
  attr_reader :dealer, :player

  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
    @dealer = Dealer.new

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
    output.print "Enter your name: "
    input.gets.chomp
  end
end
