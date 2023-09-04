class Card
  # червы бубны пики вини 
  SUITS = %W{ \u{2661} \u{2662} \u{2664} \u{2667} }.freeze

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

  def default_weight(rank)
    case rank
    when 1 then 11
    when 11 then 10
    when 12 then 10
    when 13 then 10
    else
      rank
    end
  end
  
  def ace?
    rank == 1
  end
end
