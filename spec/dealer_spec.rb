# frozen_string_literal: true

require './gamer'
require './dealer'
require './player'
require './deck'
require './card'
require './game'

RSpec.describe Dealer do
  subject { described_class.new }

  let(:info) do
    "\e[4m#Dealer\e[0m: #{''.ljust(15, ' ')} - #{subject.cash.to_s.concat('$').ljust(4, ' ')}\t\
        Cards: #{Array.new(subject.cards.count, '*').join(' ').ljust(15, ' ')}\t\
        Score: ??"
  end

  it { is_expected.to be_kind_of(Gamer) }
  it { expect(subject).to respond_to(:cash) }
  it { expect(subject).to respond_to(:cards) }
  it { expect(subject).to respond_to(:score) }
  it { expect(subject).to respond_to(:take_card) }
  it { expect(subject).to respond_to(:bet) }

  it 'has a deck' do
    expect(subject.deck).to be_an_instance_of(Deck)
  end

  describe '#deal_cards' do
    let(:player) { Player.new('John') }

    it 'gives two cards to the player' do
      subject.deal_cards(player)
      expect(player.cards.size).to eq(2)
    end

    it 'takes two cards' do
      subject.deal_cards(player)
      expect(subject.cards.size).to eq(2)
    end
  end

  it 'prints dealers info' do
    expect(subject.info).to eq(info)
  end
end
