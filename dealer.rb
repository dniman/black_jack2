# frozen_string_literal: true
require './deck'
require 'byebug'

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
        player.take_card(deck.draw)
      end
    end
  end

  def take_card(card)
    @cards << card

    if @score > 10 && card.ace?
      @score += card.rank
    else
      @score += card.weight
    end
  end

  def bet(bank, value)
    bank[:dealer] = value

    self.cash = cash - value
  end

  private
  
  attr_writer :cash
end
