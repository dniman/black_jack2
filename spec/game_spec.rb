require './game'
require './player'
require './logo'
require './deck'
require 'stringio'

RSpec.describe Game do
  let(:input) { $stdin }
  subject(:game) { described_class.new(input: input, output: StringIO.new) }

  before(:each) do
    allow(input).to receive(:gets).and_return("\n")
    allow(input).to receive(:gets).and_return("John")
  end

  it "has a deck" do
    expect(game.deck).to be_an_instance_of(Deck)
  end

  it "has a player" do
    expect(game.player.name).to eq("John")
  end

  describe "#start" do
  end
end
