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
end
