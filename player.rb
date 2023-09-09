# frozen_string_literal: true

class Player < Gamer
  attr_reader :name

  def initialize(name)
    super()
    @name = name
  end
end
