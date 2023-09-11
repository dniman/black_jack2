# frozen_string_literal: true

require './gamer'
require './player'
require './game'

RSpec.describe Player do
  let(:name) { 'John' }
  let(:info) do
    "\e[4m#Player\e[0m: #{subject.name.ljust(15, ' ')} - #{subject.cash.to_s.concat('$').ljust(4, ' ')}\t\
        Cards: #{subject.cards.map(&:info).join(' ').ljust(15, ' ')}\t\
        Score: #{subject.score}"
  end

  let(:menu) do
    <<~MENU
      Your move. What will you do?
        1. Skip a turn
        2. Take a card
        3. Reveal cards
      Choose an action 1/2/3:
    MENU
  end

  subject { described_class.new(name) }
  let(:dealer) { instance_double('Dealer', action: true, deal_card: true, info: '123', full_info: '1234') }

  it { is_expected.to be_kind_of(Gamer) }
  it { expect(subject).to respond_to(:cash) }
  it { expect(subject).to respond_to(:cards) }
  it { expect(subject).to respond_to(:score) }
  it { expect(subject).to respond_to(:take_card) }
  it { expect(subject).to respond_to(:bet) }

  it 'has a name' do
    expect(subject.name).to eq(name)
  end

  it 'prints players info' do
    expect(subject.info).to eq(info)
  end

  describe '#action' do
    let(:input) { StringIO.new("1\n") }
    let(:output) { StringIO.new }

    it 'prints players menu' do
      subject.action(dealer, input:, output:)

      expect(output.string).to eq(menu)
    end

    context 'when pressed key from the range 1..3' do
      context 'and pressed 1' do
        it 'skips the turn' do
          expect(dealer).to receive(:action).with(subject, input:, output:)

          subject.action(dealer, input:, output:)
        end
      end

      context 'and pressed 2' do
        it 'takes a card' do
          input = StringIO.new("2\n")

          expect(dealer).to receive(:deal_card).with(subject)

          subject.action(dealer, input:, output:)
        end

        it "prints player's info" do
          input = StringIO.new("2\n")

          allow(dealer).to receive(:deal_card).with(subject)

          subject.action(dealer, input:, output:)

          expect(output.string).to match(/#{Regexp.quote(info)}/)
        end

        it "prints dealer's info" do
          input = StringIO.new("2\n")

          allow(dealer).to receive(:deal_card).with(subject)

          subject.action(dealer, input:, output:)

          expect(output.string).to match(/123/)
        end

        it 'moves turn to dealer' do
          input = StringIO.new("2\n")

          expect(dealer).to receive(:action).with(subject, input:, output:)

          subject.action(dealer, input:, output:)
        end
      end

      context 'and pressed 3' do
        it "prints player's info" do
          input = StringIO.new("3\n")

          subject.action(dealer, input:, output:)

          expect(output.string).to match(/#{Regexp.quote(info)}/)
        end

        it "prints dealer's full info" do
          input = StringIO.new("3\n")

          subject.action(dealer, input:, output:)

          expect(output.string).to match(/1234/)
        end
      end
    end

    context 'when pressed key not from the range 1..3' do
      let(:input) { StringIO.new("a\n") }

      it 'asks again' do
        expect(subject).to receive(:action).with(dealer, input:, output:)

        subject.action(dealer, input:, output:)
      end
    end
  end
end
