# frozen_string_literal: true
require './deck'

class Dealer
  attr_reader :cash, :cards, :deck

  def initialize
    @cash = 100
    @cards = []
    @deck = Deck.new
  end

  def deal_cards(user)
    2.times do
      [user, self].each do |player|
        player.cards << deck.draw
      end
    end
  end
end
