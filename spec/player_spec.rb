# frozen_string_literal: true

require './gamer'
require './player'
require './game'

RSpec.describe Player do
  let(:name) { 'John' }
  subject { described_class.new(name) }
  let(:dealer) { instance_double('Dealer', action: true, deal_card: true, info: '123', full_info: '1234') }
  let(:bank) { { dealer: 10, player: 10 } }
  let(:bank_info) { "Game bank: #{bank.values.inject(:+)}$" }

  let(:full_menu) do
    <<~MENU
      Your move. What will you do?
        1. Reveal cards
        2. Skip a turn
        3. Take a card
      Choose an action 1/2/3:
    MENU
  end
  
  let(:menu) do
    <<~MENU
      Your move. What will you do?
        1. Reveal cards
        2. Skip a turn
      Choose an action 1/2:
    MENU
  end

  let(:info) do
    "\e[4m#Player\e[0m: #{subject.name.ljust(15, ' ')} - #{subject.cash.to_s.concat('$').ljust(4, ' ')}\t\
        Cards: #{subject.cards.map(&:info).join(' ').ljust(15, ' ')}\t\
        Score: #{subject.score}"
  end

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
    let(:input) { StringIO.new("2\n") }
    let(:output) { StringIO.new }

    it 'prints full players menu' do
      subject.action(dealer, bank, input:, output:)

      expect(output.string).to match(/#{Regexp.quote(full_menu.chomp)}/)
    end

    context 'when action range 1..3' do
      context 'and pressed 1' do
        let(:input) { StringIO.new("1\n") }
        let(:args) { [dealer, bank] }
        let(:kwargs) { {input: input, output: output} }

        it 'reveals the cards' do
          expect(subject).to receive(:send).with(:reveal_cards_action, *args, **kwargs)

          subject.action(dealer, bank, input:, output:)
        end
      end

      context 'and pressed 2' do
        let(:input) { StringIO.new("2\n") }
        let(:args) { [dealer, bank] }
        let(:kwargs) { {input: input, output: output} }

        it 'skips the turn' do
          expect(subject).to receive(:send).with(:skip_turn_action, *args, **kwargs)

          subject.action(dealer, bank, input:, output:)
        end
      end

      context 'and pressed 3' do
        let(:input) { StringIO.new("3\n") }
        let(:args) { [dealer, bank] }
        let(:kwargs) { {input: input, output: output} }

        it 'takes a card' do
          expect(subject).to receive(:send).with(:take_card_action, *args, **kwargs)

          subject.action(dealer, bank, input:, output:)
        end
      end
    end

    context 'when action range 1..2' do
      let(:actions) { { reveal_cards_action: "Reveal cards", skip_turn_action: "Skip a turn" } }

      before { allow(subject).to receive(:actions).and_return(actions) }

      it 'prints players menu' do
        subject.action(dealer, bank, input:, output:)

        expect(output.string).to match(/#{Regexp.quote(menu.chomp)}/)
      end

      context 'and pressed 1' do
        let(:input) { StringIO.new("1\n") }
        let(:args) { [dealer, bank] }
        let(:kwargs) { {input: input, output: output} }

        it 'reveals the cards' do
          expect(subject).to receive(:send).with(:reveal_cards_action, *args, **kwargs)

          subject.action(dealer, bank, input:, output:)
        end
      end

      context 'and pressed 2' do
        let(:input) { StringIO.new("2\n") }
        let(:args) { [dealer, bank] }
        let(:kwargs) { {input: input, output: output} }

        it 'skips the turn' do
          expect(subject).to receive(:send).with(:skip_turn_action, *args, **kwargs)

          subject.action(dealer, bank, input:, output:)
        end
      end
    end

    context 'when pressed key not from the range 1..3' do
      let(:input) { StringIO.new("a\n") }

      it 'asks again' do
        expect(subject).to receive(:action).with(dealer, bank, input:, output:)

        subject.action(dealer, bank, input:, output:)
      end
    end
    
    context 'when pressed key not from the range 1..2' do
      let(:input) { StringIO.new("a\n") }
      let(:actions) { { reveal_cards_action: "Reveal cards", skip_turn_action: "Skip a turn" } }

      before { allow(subject).to receive(:actions).and_return(actions) }

      it 'asks again' do
        expect(subject).to receive(:action).with(dealer, bank, input:, output:)

        subject.action(dealer, bank, input:, output:)
      end
    end
  end

  describe '#reveal_cards_action' do
    let(:input) { StringIO.new("1\n") }
    let(:output) { StringIO.new }
    let(:dealer) do
      instance_double('Dealer', action: true, deal_card: true, info: '123', full_info: '1234', score: 20, cash: 100,
                                "cash=": true)
    end

    it 'prints bank info' do
      allow(dealer).to receive(:deal_card).with(subject)

      subject.action(dealer, bank, input:, output:)

      expect(output.string).to match(/#{Regexp.quote(bank_info)}/)
    end

    it "prints player's info" do
      subject.action(dealer, bank, input:, output:)

      expect(output.string).to match(/#{Regexp.quote(info)}/)
    end

    it "prints dealer's full info" do
      subject.action(dealer, bank, input:, output:)

      expect(output.string).to match(/1234/)
    end

    context 'when win' do
      it 'says you win' do
        allow(subject).to receive(:score).and_return(21)

        subject.action(dealer, bank, input:, output:)

        expect(output.string).to match(/Congrats, you win!/)
      end

      it 'says you lose' do
        allow(subject).to receive(:score).and_return(19)

        subject.action(dealer, bank, input:, output:)

        expect(output.string).to match(/Sorry, you lose.../)
      end

      it 'says draw' do
        allow(subject).to receive(:score).and_return(20)

        subject.action(dealer, bank, input:, output:)

        expect(output.string).to match(/Draw!/)
      end
    end

  end

  describe '#skip_turn_action' do
    let(:input) { StringIO.new("2\n") }
    let(:output) { StringIO.new }

    it 'skips the turn' do
      expect(dealer).to receive(:action).with(subject, bank, input:, output:)

      subject.action(dealer, bank, input:, output:)
    end
  end

  describe '#take_card_action' do
    let(:input) { StringIO.new("3\n") }
    let(:output) { StringIO.new }

    it 'takes a card' do
      expect(dealer).to receive(:deal_card).with(subject)

      subject.action(dealer, bank, input:, output:)
    end

    it 'prints bank info' do
      allow(dealer).to receive(:deal_card).with(subject)

      subject.action(dealer, bank, input:, output:)

      expect(output.string).to match(/#{Regexp.quote(bank_info)}/)
    end

    it "prints player's info" do
      allow(dealer).to receive(:deal_card).with(subject)

      subject.action(dealer, bank, input:, output:)

      expect(output.string).to match(/#{Regexp.quote(info)}/)
    end

    it "prints dealer's info" do
      allow(dealer).to receive(:deal_card).with(subject)

      subject.action(dealer, bank, input:, output:)

      expect(output.string).to match(/123/)
    end

    it 'moves turn to dealer' do
      expect(dealer).to receive(:action).with(subject, bank, input:, output:)

      subject.action(dealer, bank, input:, output:)
    end
  end
end
