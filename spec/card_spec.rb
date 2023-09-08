require './card'

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

  context 'equality' do
    describe 'comparing with the same card' do
      let(:card) { subject.clone }

      it 'is equal' do
        expect(subject).to eq(card)
      end
    end

    describe 'comparing with different card' do
      let(:card) { described_class.new(3, Card::SUITS.first) }

      it 'is not equal' do
        expect(subject).to_not eq(card)
      end
    end

  end
end

