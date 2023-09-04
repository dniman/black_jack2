class Card
  attr_reader :rank

  def initialize(rank)
    @rank = rank
  end

end

RSpec.describe Card do
  
  it '#rank' do
    card = Card.new(2)

    expect(card.rank).to eq(2)
  end

end

