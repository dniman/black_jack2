require './card'

class Deck
  attr_reader :cards

  RANKS = *(1..13)

  def initialize
    @cards = Card::SUITS.product(RANKS).map { |suit, rank| Card.new(rank, suit) }
  end

  def shuffle
  end
end
