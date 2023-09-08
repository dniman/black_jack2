require './dealer'
require './player'
require './deck'

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
end
