require './game'
require './player'
require './logo'
require 'stringio'

RSpec.describe Game do
  subject(:game) { described_class.new(input: StringIO.new, output: StringIO.new) }
  
  let(:player) { Player.new }

  describe '#start' do
    it "asks player name" do
      allow(game).to receive(:player).and_return(player)

      expect(player).to receive(:ask_name)
      game.start
    end
  end

  describe '#player' do
    it 'returns an instance of class Player' do
      allow(game).to receive(:player).and_return(player)
      expect(player).to be_an_instance_of(Player)
    end
  end

end
