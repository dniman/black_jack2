# frozen_string_literal: true

require './gamer'
require './dealer'
require './player'
require './deck'
require './card'
require './game'

RSpec.describe Dealer do
  subject { described_class.new }
  let(:player) do
    instance_double('Player', action: true, info: '123', cards: [1, 2, 3], score: 21, cash: 100, "cash=": true)
  end

  let(:bank) { { dealer: 10, player: 10 } }

  let(:bank_info) { "Game bank: #{bank.values.inject(:+)}$" }

  let(:info) do
    "\e[4m#Dealer\e[0m: #{''.ljust(15, ' ')} - #{subject.cash.to_s.concat('$').ljust(4, ' ')}\t\
        Cards: #{Array.new(subject.cards.count, '*').join(' ').ljust(15, ' ')}\t\
        Score: ??"
  end

  let(:full_info) do
    "\e[4m#Dealer\e[0m: #{''.ljust(15, ' ')} - #{subject.cash.to_s.concat('$').ljust(4, ' ')}\t\
        Cards: #{subject.cards.map(&:info).join(' ').ljust(15, ' ')}\t\
        Score: #{subject.score}"
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

  describe '#deal_card' do
    let(:player) { Player.new('John') }

    it 'gives one cards to the player' do
      subject.deal_card(player)
      expect(player.cards.size).to eq(1)
    end

    it 'takes the card' do
      subject.deal_card(subject)
      expect(subject.cards.size).to eq(1)
    end
  end

  it 'prints dealers info' do
    expect(subject.info).to eq(info)
  end

  it 'prints dealers full_info' do
    expect(subject.full_info).to eq(full_info)
  end

  describe '#action' do
    let(:input) { StringIO.new }
    let(:output) { StringIO.new }

    context "when dealer's score greater or equal 17" do
      it 'skips the turn' do
        allow(subject).to receive(:score).and_return(17)

        expect(player).to receive(:action).with(subject, bank, input:, output:)

        subject.action(player, bank, input:, output:)
      end
    end

    context "when dealer's score less then 17" do
      before(:each) do
        allow(subject).to receive(:score).and_return(15)
      end

      it 'takes a card' do
        expect(subject).to receive(:deal_card).with(subject)

        subject.action(player, bank, input:, output:)
      end

      it 'prints bank info' do
        allow(subject).to receive(:deal_card).with(subject)

        subject.action(player, bank, input:, output:)

        expect(output.string).to match(/#{Regexp.quote(bank_info)}/)
      end

      it "prints player's info" do
        allow(subject).to receive(:deal_card).with(subject)

        subject.action(player, bank, input:, output:)

        expect(output.string).to match(/123/)
      end

      it "prints dealer's info" do
        allow(subject).to receive(:deal_card).with(subject)

        subject.action(player, bank, input:, output:)

        expect(output.string).to match(/#{Regexp.quote(info)}/)
      end

      it 'moves turn to player' do
        expect(player).to receive(:action).with(subject, bank, input:, output:)

        player.action(subject, bank, input:, output:)
      end
    end

    context "when dealers's cards count equal 3 and player's cards count greater or equal 3" do
      let(:cards) { [Card.new(10, Card::SUITS.last), Card.new(2, Card::SUITS.last), Card.new(8, Card::SUITS.last)] }

      before(:each) do
        allow(subject).to receive(:cards).and_return(cards)
      end

      it 'prints bank info' do
        allow(subject).to receive(:deal_card).with(subject)

        subject.action(player, bank, input:, output:)

        expect(output.string).to match(/#{Regexp.quote(bank_info)}/)
      end

      it "prints player's info" do
        subject.action(player, bank, input:, output:)

        expect(output.string).to match(/123/)
      end

      it "prints dealer's full info" do
        subject.action(player, bank, input:, output:)

        expect(output.string).to match(/#{Regexp.quote(full_info)}/)
      end

      context 'and win' do
        let(:player) do
          instance_double('Player', action: true, info: '123', cards:, score: 20, cash: 100, "cash=": true)
        end

        it 'says to player he lose' do
          allow(subject).to receive(:score).and_return(21)

          subject.action(player, bank, input:, output:)

          expect(output.string).to match(/Sorry, you lose.../)
        end

        it 'says to player he win' do
          allow(subject).to receive(:score).and_return(19)

          subject.action(player, bank, input:, output:)

          expect(output.string).to match(/Congrats, you win!/)
        end

        it 'says draw' do
          allow(subject).to receive(:score).and_return(20)

          subject.action(player, bank, input:, output:)

          expect(output.string).to match(/Draw!/)
        end
      end
    end
  end
end
