require './dealer'
require './player'
require './deck'
require './card'

RSpec.describe Dealer do
  subject { described_class.new }

  it 'has a cash' do
    expect(subject.cash).to eq(100)
  end

  it 'has cards' do
    expect(subject.cards).to be_empty
  end

  it 'has a deck' do
    expect(subject.deck).to be_an_instance_of(Deck) 
  end

  it 'has a score' do
    expect(subject.score). to be_zero
  end

  describe "#deal_cards" do
    let(:player) { Player.new("John") }

    it 'gives two cards to the player' do
      subject.deal_cards(player)
      expect(player.cards.size).to eq(2)
    end

    it 'takes two cards' do
      subject.deal_cards(player)
      expect(subject.cards.size).to eq(2)
    end
  end

  context "get a card" do
    context "when score less or equal 10" do
      it "sums the score with the card weight" do
        cards = [Card.new(10, Card::SUITS.first), Card.new(1, Card::SUITS.first)]
        cards.each {|card| subject.take_card(card) }
        
        expect(subject.score).to eq(21)
      end
    end
    
    context "when score is greater then 10" do
      context "when the next card is ace" do
        it "sums the score with the rank" do
          cards = [Card.new(1, Card::SUITS.first), Card.new(1, Card::SUITS.last)]
          cards.each {|card| subject.take_card(card) }
          
          expect(subject.score).to eq(12)
        end
      end
    
      context "when the next card is not ace" do
        it "sums the score with the card weight" do
          cards = [Card.new(1, Card::SUITS.first), Card.new(11, Card::SUITS.last)]
          cards.each {|card| subject.take_card(card) }
          
          expect(subject.score).to eq(21)
        end
      end
    end
  end
end
