require './logo'

class Game

  def start
    show_logo
  end

  private

  def show_logo
    print logo.image
    gets
  end

  def logo
    @logo ||= Logo.new
  end

end

RSpec.describe Game do
  subject { described_class.new }

  describe '#start' do
    it "prints logo on the screen" do
      expect {subject.start}.to output(/Press any key to continue/).to_stdout
    end
    
    it "gets press any key" do
      allow(subject).to receive(:gets).and_return("~")
      expect(subject.start).to eq("~")
    end
  end
end
