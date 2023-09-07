# frozen_string_literal: true

require './logo'
require './player'
require './deck'
require 'byebug'

class Game
  attr_reader :deck, :player

  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
    @deck = Deck.new

    show_logo
    @player = Player.new(ask_user_name)
  end

  def start
    deck.shuffle
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
