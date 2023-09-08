# frozen_string_literal: true

class Player
  attr_reader :name, :cash, :cards

  def initialize(name)
    @name = name
    @cash = 100
    @cards = []
  end
end
