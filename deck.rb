require './card'
require 'byebug'

class Deck
  attr_reader :cards

  RANKS = *(1..13)

  def self.build
    Card::SUITS.product(RANKS).map { |suit, rank| Card.new(rank, suit) }
  end

  def initialize
    @cards = self.class.build.shuffle
  end

  def ==(other)
    if other.nil? || !other.instance_of?(Deck)
      return false
    else
      index = 0
      while index < cards.size do
        return unless cards[index].rank == other.cards[index].rank && cards[index].suit == other.cards[index].suit
        index += 1
      end

      true
    end
  end
end
