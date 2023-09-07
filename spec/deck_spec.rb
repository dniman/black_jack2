require './deck'
require './card'

RSpec.describe Deck do
  it "has 52 cards" do
    expect(subject.cards.size).to eq(52)
  end
end
