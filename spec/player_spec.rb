# frozen_string_literal: true

require './gamer'
require './player'
require 'byebug'

RSpec.describe Player do
  let(:name) { 'John' }
  subject { described_class.new(name) }

  it { is_expected.to be_kind_of(Gamer) }
  it { expect(subject).to respond_to(:cash) }
  it { expect(subject).to respond_to(:cards) }
  it { expect(subject).to respond_to(:score) }
  it { expect(subject).to respond_to(:take_card) }
  it { expect(subject).to respond_to(:bet) }

  it 'has a name' do
    expect(subject.name).to eq(name)
  end
end
