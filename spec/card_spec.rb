class Card
  # червы бубны пики вини 
  SUITS = %W{ \u{2661} \u{2662} \u{2664} \u{2667} }.freeze

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
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

end

RSpec.describe Card do
  let(:card) { Card.new(2, Card::SUITS.first) }
  
  it '#rank' do
    expect(card.rank).to eq(2)
  end

  it '#suit' do
    expect(card.suit).to eq(Card::SUITS.first)
  end


  describe '#info' do
    context 'when rank is 1' do
      it "prints A#{Card::SUITS.first}" do
        card = Card.new(1, Card::SUITS.first)
        expect(card.info).to eq("A#{Card::SUITS.first}")
      end
    end

    context 'when rank is 11' do
      it "prints J#{Card::SUITS.first}" do
        card = Card.new(11, Card::SUITS.first)
        expect(card.info).to eq("J#{Card::SUITS.first}")
      end
    end
    
    context 'when rank is 12' do
      it "prints Q#{Card::SUITS.first}" do
        card = Card.new(12, Card::SUITS.first)
        expect(card.info).to eq("Q#{Card::SUITS.first}")
      end
    end
    
    context 'when rank is 13' do
      it "prints K#{Card::SUITS.first}" do
        card = Card.new(13, Card::SUITS.first)
        expect(card.info).to eq("K#{Card::SUITS.first}")
      end
    end
    
    context 'when rank from 2 till 10' do
      2.upto(10) do |rank|
        card = Card.new(rank, Card::SUITS.first)
        it "prints #{rank}#{Card::SUITS.first}" do
          expect(card.info).to eq("#{rank}#{Card::SUITS.first}")
        end
      end
    end
  end

end

