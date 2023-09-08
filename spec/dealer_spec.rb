require './dealer'

RSpec.describe Dealer do
  subject { described_class.new }

  it 'has a cash' do
    expect(subject.cash).to eq(100)
  end
end
