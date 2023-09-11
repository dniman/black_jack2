# frozen_string_literal: true

require './logo'
require './dealer'
require './player'
require 'byebug'

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
    deal_cards
    bet
    show_info
    player.action(dealer, input:, output:)
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
    [player, dealer]
  end

  def deal_cards
    2.times do
      players.each { |player| dealer.deal_card(player) }
    end
  end

  def bet
    players.each { |player| player.bet(bank, BET_SIZE) }
  end

  def show_info
    output.puts "Game bank: #{bank.values.inject(:+)}$"
    output.puts player.info.to_s
    output.puts dealer.info.to_s
  end
end
