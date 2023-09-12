# frozen_string_literal: true

require './game'
require './player'
require './logo'
require './dealer'
require './deck'
require 'stringio'

RSpec.describe Game do
  let(:input) { StringIO.new("\nJohn\n3\nn\n") }
  let(:output) { StringIO.new }
  subject { described_class.new(input:, output:) }

  let(:bank) { subject.bank }
  let(:dealer) { subject.dealer }
  let(:player) { subject.player }

  it 'has a dealer' do
    expect(dealer).to be_an_instance_of(Dealer)
  end

  it 'has a player' do
    expect(player.name).to eq('John')
  end

  it 'has a bank' do
    expect(bank).to eq({})
  end

  describe '#start' do
    context 'dealer' do
      it 'deals cards to players' do
        subject.start

        expect(dealer.cards.size).to eq(2)
        expect(player.cards.size).to eq(2)
      end

      it 'makes a stake' do
        subject.start

        expect(bank).to include(dealer: 10)
      end
    end

    context 'player' do
      it 'makes a stake' do
        subject.start

        expect(bank).to include(player: 10)
      end
    end

    context "player's moves first" do
      it 'gets them the move' do
        expect(player).to receive(:action).with(dealer, bank, input:, output:).and_call_original

        subject.start
      end
    end

    context 'replay' do
      let(:input) { StringIO.new("\nJohn\n3\ny\n3\nn\n") }
      subject { described_class.new(input:, output:) }

      context 'resets values' do
        context 'game' do
          it 'empty bank' do
            expect(subject.bank).to be_empty

            subject.start
          end
        end

        context 'player' do
          it 'empty cards' do
            expect(player.cards).to be_empty

            subject.start
          end

          it 'score be zero' do
            expect(player.score).to be_zero

            subject.start
          end
        end
        
        context 'dealer' do
          let(:deck) { Deck.new }

          it 'empty cards' do
            expect(dealer.cards).to be_empty

            subject.start
          end

          it 'score be zero' do
            expect(dealer.score).to be_zero

            subject.start
          end

          it 'takes new deck' do
            expect(Deck).to receive(:new).twice.and_return(deck)

            expect(dealer.deck).to eq(deck)
            subject.start

          end
        end
      end

      it 'starts again' do
        expect(subject).to receive(:start)

        subject.start
      end
    end
  end
end
