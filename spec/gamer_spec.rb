# frozen_string_literal: true

require './gamer'
require './player'
require './card'
require './game'

RSpec.describe Gamer do
  subject { described_class.new }

  it 'has a cash' do
    expect(subject.cash).to eq(100)
  end

  it 'has cards' do
    expect(subject.cards).to be_empty
  end

  it 'has a score' do
    expect(subject.score).to be_zero
  end

  context 'get a card' do
    context 'when score less or equal 10' do
      it 'sums the score with the card weight' do
        cards = [Card.new(10, Card::SUITS.first), Card.new(1, Card::SUITS.first)]
        cards.each { |card| subject.take_card(card) }

        expect(subject.score).to eq(21)
      end
    end

    context 'when score is greater then 10' do
      context 'when the next card is ace' do
        it 'sums the score with the rank' do
          cards = [Card.new(1, Card::SUITS.first), Card.new(1, Card::SUITS.last)]
          cards.each { |card| subject.take_card(card) }

          expect(subject.score).to eq(12)
        end
      end

      context 'when the next card is not ace' do
        it 'sums the score with the card weight' do
          cards = [Card.new(1, Card::SUITS.first), Card.new(11, Card::SUITS.last)]
          cards.each { |card| subject.take_card(card) }

          expect(subject.score).to eq(21)
        end
      end
    end
  end

  describe '#bet' do
    let(:game) { instance_double('Game', bank: {}) }
    let(:bank) { game.bank }

    before(:each) { subject.bet(bank, Game::BET_SIZE) }

    context 'Player' do
      subject { Player.new('John') }

      it 'bets 10$ to the game bank' do
        expect(bank).to include(player: Game::BET_SIZE)
      end
    end

    context 'Dealer' do
      subject { Dealer.new }

      it 'bets 10$ to the game bank' do
        expect(bank).to include(dealer: Game::BET_SIZE)
      end
    end

    it 'decreases the cash' do
      expect(subject.cash).to eq(90)
    end
  end

  describe '#win?' do
    context 'when player\'s score is greater then other player\'s score' do
      context 'and player\'s score less or equal game\'s scores to win' do
        subject { Player.new('John') }
        let(:other) { instance_double('Dealer', score: 20) }

        it 'returns true' do
          allow(subject).to receive(:score).and_return(21)

          expect(subject.win?(other)).to be_truthy
        end
      end

      context 'and player\'s score greater game\'s scores to win' do
        subject { Player.new('John') }
        let(:other) { instance_double('Dealer', score: 22) }

        it 'returns false' do
          allow(subject).to receive(:score).and_return(23)

          expect(subject.win?(other)).to be_falsey
        end
      end
    end

    context 'when player\'s score less or equal game\'s scores to win' do
      context 'and other player\'s score greater then game\'s scores to win' do
        subject { Player.new('John') }
        let(:other) { instance_double('Dealer', score: 26) }

        it 'returns true' do
          allow(subject).to receive(:score).and_return(21)

          expect(subject.win?(other)).to be_truthy
        end
      end
    end
  end

  describe '#lose?' do
    context 'when player\'s score is less then other player\'s score' do
      context 'and player\'s score less or equal game\'s scores to win' do
        subject { Player.new('John') }
        let(:other) { instance_double('Dealer', score: 21) }

        it 'returns true' do
          allow(subject).to receive(:score).and_return(20)

          expect(subject.lose?(other)).to be_truthy
        end
      end

      context 'and player\'s score greater game\'s scores to win' do
        subject { Player.new('John') }
        let(:other) { instance_double('Dealer', score: 23) }

        it 'returns false' do
          allow(subject).to receive(:score).and_return(22)

          expect(subject.lose?(other)).to be_falsey
        end
      end
    end

    context "when player'\s score is greater then game\'s scores to win" do
      context 'and gamer\'s score is less or equal game\'s scores to win' do
        subject { Player.new('John') }
        let(:other) { instance_double('Dealer', score: 21) }

        it 'returns true' do
          allow(subject).to receive(:score).and_return(22)

          expect(subject.lose?(other)).to be_truthy
        end
      end
    end
  end
end
