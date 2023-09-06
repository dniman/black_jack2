require './game'
require 'stringio'
require 'byebug'

RSpec.describe Game do
  subject { described_class.new }

  describe '#initialize' do
    it "prints logo on the screen" do
      expect {described_class.new}.to output(/Press enter to continue/).to_stdout
    end

    describe "waits press enter" do
      context "when press enter" do
        it "continues execution" do
          allow($stdin).to receive(:gets).and_return("\n")
          symbol = $stdin.gets

          expect(symbol).to eq("\n")
          expect(described_class).to receive(an_instance_of)
        end
      end

      context "when press another key" do
        it "asks again 'Press enter to continue'" do
          allow($stdin).to receive(:gets).and_return("~")
          symbol = $stdin.gets

          expect(symbol).to eq("~")
          expect {subject}.to output(/Press enter to continue/).to_stdout
        end
      end

    end
  end

end
