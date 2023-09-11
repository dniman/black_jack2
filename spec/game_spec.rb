# frozen_string_literal: true

require './game'
require './player'
require './logo'
require './dealer'
require 'stringio'

RSpec.describe Game do
  let(:input) { StringIO.new }
  let(:output) { StringIO.new }
  subject(:game) { described_class.new(input:, output:) }

  before(:each) do
    allow(input).to receive(:gets).and_return("\n")
    allow(input).to receive(:gets).and_return('John')
  end

  let(:dealer) { game.dealer }
  let(:player) { game.player }

  it 'has a dealer' do
    expect(dealer).to be_an_instance_of(Dealer)
  end

  it 'has a player' do
    expect(player.name).to eq('John')
  end

  it 'has a bank' do
    expect(game.bank).to eq({})
  end

  describe '#start' do
    context 'dealer' do
      before(:each) do
        allow(player).to receive(:action).with(dealer, input:, output:)
        allow(game).to receive(:send).and_return(true)
      end

      it 'deals cards to players' do
        expect(dealer).to receive(:deal_card).with(player).twice
        expect(dealer).to receive(:deal_card).with(dealer).twice

        game.start
      end

      it 'makes a stake' do
        expect(dealer).to receive(:bet).with(game.bank, 10)

        game.start
      end
    end

    context 'player' do
      before(:each) do
        allow(player).to receive(:action).with(dealer, input:, output:)
        allow(game).to receive(:send).and_return(true)
      end

      it 'makes a stake' do
        expect(player).to receive(:bet).with(game.bank, 10)

        game.start
      end
    end

    context 'game info' do
      before(:each) do
        allow(player).to receive(:action).with(dealer, input:, output:)
        allow(game).to receive(:send).and_return(true)
      end

      it 'shows game bank' do
        game.start

        expect(output.string).to match(/Game bank: 20/)
      end

      it 'shows player info' do
        game.start

        expect(output.string).to match(/#Player/)
      end

      it 'shows dealer info' do
        game.start

        expect(output.string).to match(/#Dealer/)
      end
    end

    context "when player's moves first" do
      it 'gets them the move' do
        expect(player).to receive(:action).with(dealer, input:, output:)

        game.start
      end
    end
  end
end
