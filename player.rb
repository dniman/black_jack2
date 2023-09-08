# frozen_string_literal: true

class Player
  attr_reader :name, :cash, :cards, :score

  def initialize(name)
    @name = name
    @cash = 100
    @cards = []
    @score = 0
  end

  def take_card(card)
    @cards << card

    if @score > 10 && card.ace?
      @score += card.rank
    else
      @score += card.weight
    end
  end
end
