# frozen_string_literal: true

require './gamer'
require './player'
require 'byebug'

RSpec.describe Player do
  let(:name) { 'John' }
  let(:info) {
    "\e[4m#Player\e[0m: #{ subject.name.ljust(15, ' ')} - #{ subject.cash.to_s.concat('$').ljust(4, ' ')}\t\
        Cards: #{ subject.cards.map(&:info).join(' ').ljust(15, ' ')}\t\
        Score: #{ subject.score }"
  }

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
  
  it 'prints players info' do
    expect(subject.info).to eq(info)
  end
end
