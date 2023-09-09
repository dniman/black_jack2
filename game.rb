# frozen_string_literal: true

require './logo'
require './dealer'
require './player'

class Game
  BET_SIZE = 10

  attr_reader :dealer, :player, :bank

  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
    @dealer = Dealer.new

    show_logo
    @player = Player.new(ask_user_name)
    @bank = {}
  end

  def start
    dealer.deal_cards(player)
    players.each { |player| player.bet(bank, BET_SIZE) }
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
    output.print 'Enter your name: '
    input.gets.chomp
  end

  def players
    [dealer, player]
  end
end
