# frozen_string_literal: true

# Base class for both
# player and dealer
class Gamer
  SCORES_TO_WIN = 21

  attr_accessor :cash, :cards, :score

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

  def info; end

  def win?(gamer)
    (score > gamer.score && gamer.score <= SCORES_TO_WIN) ||
      (score <= SCORES_TO_WIN && gamer.score > SCORES_TO_WIN)
  end

  def lose?(gamer)
    (score < gamer.score && gamer.score <= SCORES_TO_WIN) ||
      (score > SCORES_TO_WIN && gamer.score <= SCORES_TO_WIN)
  end
end
