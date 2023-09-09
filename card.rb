# frozen_string_literal: true

# Карта
class Card
  SUITS = %w[♡ ♢ ♤ ♧].freeze

  attr_reader :rank, :suit, :weight

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @weight = default_weight(rank)
  end

  def info
    case rank
    when 1 then "A#{suit}"
    when 11 then "J#{suit}"
    when 12 then "Q#{suit}"
    when 13 then "K#{suit}"
    else
      "#{rank}#{suit}"
    end
  end

  def ==(other)
    rank == other.rank && suit == other.suit
  end

  def ace?
    rank == 1
  end

  private

  def default_weight(value)
    return 10 if face_card?
    return 11 if ace?

    value
  end

  def face_card?
    rank > 10
  end
end
