# frozen_string_literal: true

require './card'

class Deck
  attr_reader :cards

  RANKS = (1..13).to_a.freeze

  def self.build
    Card::SUITS.product(RANKS).map { |suit, rank| Card.new(rank, suit) }
  end

  def initialize
    @cards = self.class.build.shuffle
  end

  def ==(other)
    return false if other.nil? || !other.instance_of?(Deck)

    index = 0
    while index < cards.size
      return unless cards[index] == other.cards[index]

      index += 1
    end

    true
  end

  def draw
    cards.pop
  end
end
