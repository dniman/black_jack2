# frozen_string_literal: true

require './gamer'
require './deck'

class Dealer < Gamer
  attr_reader :deck

  def initialize
    super()
    @deck = Deck.new
  end

  def deal_cards(user)
    2.times do
      [user, self].each do |player|
        player.take_card(deck.draw)
      end
    end
  end

  def info
    "\e[4m#Dealer\e[0m: #{''.ljust(15, ' ')} - #{cash.to_s.concat('$').ljust(4, ' ')}\t\
        Cards: #{Array.new(cards.count, '*').join(' ').ljust(15, ' ')}\t\
        Score: ??"
  end
end
