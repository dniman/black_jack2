# frozen_string_literal: true

class Player < Gamer
  attr_reader :name

  def initialize(name)
    super()
    @name = name
  end

  def info
    "\e[4m#Player\e[0m: #{ name.ljust(15, ' ')} - #{ cash.to_s.concat('$').ljust(4, ' ')}\t\
        Cards: #{ cards.map(&:info).join(' ').ljust(15, ' ')}\t\
        Score: #{score}"
  end
end
