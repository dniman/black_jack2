require './game'
require './player'


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
          # тут нужен некий тест, который проверяет, что объект создался
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

  describe '#start' do
    it "asks player name" do
      expect_any_instance_of(Player).to receive(:ask_name) 
      subject.start
    end
  end

end
