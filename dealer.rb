# frozen_string_literal: true
require './deck'

class Dealer
  attr_reader :cash, :cards, :deck, :score

  def initialize
    @cash = 100
    @cards = []
    @deck = Deck.new
    @score = 0
  end

  def deal_cards(user)
    2.times do
      [user, self].each do |player|
        player.cards << deck.draw
      end
    end
  end
end
