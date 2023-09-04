class Card
  # пики вини червы бубны
  SUITS = %w{ \u{2661} \u{2662} \u{2664} \u{2667} }.freeze

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

end

RSpec.describe Card do
  let(:card) { Card.new(2, Card::SUITS.first) }
  
  it '#rank' do
    expect(card.rank).to eq(2)
  end

  it '#suit' do
    expect(card.suit).to eq(Card::SUITS.first)
  end

end

