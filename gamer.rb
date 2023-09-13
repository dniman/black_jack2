# frozen_string_literal: true

# Base class for both
# player and dealer
class Gamer
  SCORES_TO_WIN = 21

  attr_accessor :cash, :cards 

  def initialize
    @cash = 100
    @cards = []
  end

  def take_card(card)
    @cards << card
  end

  def score
    score = cards.map{|c| c.weight}.inject(:+) || 0
    cards.inject(score){|sum, c| sum -= 10 if c.ace? && sum > SCORES_TO_WIN; sum}
  end

  def bet(bank, value)
    bank[self.class.name.downcase.to_sym] = value

    self.cash = cash - value
  end

  def info; end

  def win?(gamer)
    (score > gamer.score && score <= SCORES_TO_WIN) ||
      (score <= SCORES_TO_WIN && gamer.score > SCORES_TO_WIN)
  end

  def lose?(gamer)
    (score < gamer.score && gamer.score <= SCORES_TO_WIN) ||
      (score > SCORES_TO_WIN && gamer.score <= SCORES_TO_WIN)
  end
end
