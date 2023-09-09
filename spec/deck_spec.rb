# frozen_string_literal: true

require './deck'
require './card'

RSpec.describe Deck do
  subject { described_class.new }

  describe '.build' do
    it 'creates array of 52 cards' do
      expect(described_class.build.size).to eq(52)
    end
  end

  it 'has shuffled cards' do
    expect_any_instance_of(Array).to receive(:shuffle)
    subject
  end

  context 'equality' do
    let(:deck) { described_class.new }

    describe 'comparing with the same deck' do
      it 'is equal' do
        cards = deck.cards.clone.map(&:clone)
        allow(subject).to receive(:cards).and_return(cards)

        expect(subject).to eq(deck)
      end
    end

    describe 'comparing with different deck' do
      it 'is not equal' do
        expect(subject).to_not eq(deck)
      end
    end
  end

  describe '#draw' do
    it 'one card less in the deck' do
      subject.draw
      expect(subject.cards.size).to eq(51)
    end
  end
end
