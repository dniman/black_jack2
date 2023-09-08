require './game'
require './player'
require './logo'
require './dealer'
require 'stringio'

RSpec.describe Game do
  let(:input) { $stdin }
  subject(:game) { described_class.new(input: input, output: StringIO.new) }

  before(:each) do
    allow(input).to receive(:gets).and_return("\n")
    allow(input).to receive(:gets).and_return("John")
  end

  let(:dealer) { game.dealer }
  let(:player) { game.player }

  it "has a dealer" do
    expect(dealer).to be_an_instance_of(Dealer)
  end

  it "has a player" do
    expect(player.name).to eq("John")
  end

  describe "#start" do
    context "dealer" do
      it "deals cards to players" do
        expect(dealer).to receive(:deal_cards).with(player)
        dealer.deal_cards(player)
      end
    end
  end
end
