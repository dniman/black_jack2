# frozen_string_literal: true

class Player
  attr_reader :name, :cash

  def initialize(name)
    @name = name
    @cash = 100
  end
end
