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

RSpec.describe Card do
  subject { described_class.new(2, Card::SUITS.first) }
  
  it '#rank' do
    expect(subject.rank).to eq(2)
  end

  it '#suit' do
    expect(subject.suit).to eq(Card::SUITS.first)
  end

  describe '#info' do
    context 'when rank is 1' do
      subject { described_class.new(1, Card::SUITS.first) }

      it "prints A#{Card::SUITS.first}" do
        expect(subject.info).to eq("A#{Card::SUITS.first}")
      end
    end

    context 'when rank is 11' do
      subject { described_class.new(11, Card::SUITS.first) }

      it "prints J#{Card::SUITS.first}" do
        expect(subject.info).to eq("J#{Card::SUITS.first}")
      end
    end
    
    context 'when rank is 12' do
      subject { described_class.new(12, Card::SUITS.first) }

      it "prints Q#{Card::SUITS.first}" do
        expect(subject.info).to eq("Q#{Card::SUITS.first}")
      end
    end
    
    context 'when rank is 13' do
      subject { described_class.new(13, Card::SUITS.first) }

      it "prints K#{Card::SUITS.first}" do
        expect(subject.info).to eq("K#{Card::SUITS.first}")
      end
    end
    
    2.upto(10) do |rank|
      context "when rank is #{rank}" do
        subject { described_class.new(rank, Card::SUITS.first) }

        it "prints #{rank}#{Card::SUITS.first}" do
          expect(subject.info).to eq("#{rank}#{Card::SUITS.first}")
        end
      end
    end
  end
  
  describe '#weight' do
    context 'when rank is 1' do
      subject { described_class.new(1, Card::SUITS.first) }

      it "weight is 11" do
        expect(subject.weight).to eq(11)
      end
    end
    
    11.upto(13) do |rank|
      context "when rank is #{rank}" do
        subject { described_class.new(rank, Card::SUITS.first) }

        it "weight is 10" do
          expect(subject.weight).to eq(10)
        end
      end
    end
    
    2.upto(10) do |rank|
      context "when rank is #{rank}" do
        subject { described_class.new(rank, Card::SUITS.first) }

        it "weight is #{rank}" do
          expect(subject.weight).to eq(rank)
        end
      end
    end
  end
end

