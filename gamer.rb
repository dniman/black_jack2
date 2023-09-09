# frozen_string_literal: true

# Base class for both
# player and dealer
class Gamer
  attr_reader :cash, :cards, :score

  def initialize
    @cash = 100
    @cards = []
    @score = 0
  end

  def take_card(card)
    @cards << card

    @score += if @score > 10 && card.ace?
                card.rank
              else
                card.weight
              end
  end

  def bet(bank, value)
    bank[self.class.name.downcase.to_sym] = value

    self.cash = cash - value
  end

  def info

  end

  private

  attr_writer :cash
end
