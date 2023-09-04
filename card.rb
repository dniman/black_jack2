# frozen_string_literal: true

# Карта
class Card
  # червы бубны пики вини
  SUITS = %W[\u{2661} \u{2662} \u{2664} \u{2667}].freeze

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

  private

  def default_weight(value)
    return 10 if face_card?
    return 11 if ace?

    value 
  end

  def ace?
    rank == 1
  end

  def face_card?
    rank > 10
  end
end
