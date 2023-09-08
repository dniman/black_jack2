require './player'

RSpec.describe Player do
  let(:name) { "John" }
  subject { described_class.new(name) }

  it 'has a name' do
    expect(subject.name).to eq(name)
  end

  it 'has a cash' do
    expect(subject.cash). to eq(100)
  end

  it 'has cards' do
    expect(subject.cards).to be_empty
  end

  it 'has a score' do
    expect(subject.score).to be_zero
  end
end
