# frozen_string_literal: true

require './game'

class Player < Gamer
  attr_reader :name

  def initialize(name)
    super()
    @name = name
  end

  def action(dealer, input:, output:)
    output.print menu_info
    value = input.gets.to_i
    if (1..3).include?(value)
      case value
      when 1
        dealer.action(self, input:, output:)
      when 2
        dealer.deal_card(self)
        show_info(dealer, output:)
        dealer.action(self, input:, output:)
      when 3
        show_info(dealer, output:, full: true)
      end
    else
      action(dealer, input:, output:)
    end
  end

  def menu_info
    <<~MENU
      Your move. What will you do?
        1. Skip a turn
        2. Take a card
        3. Reveal cards
      Choose an action 1/2/3:
    MENU
  end

  def info
    "\e[4m#Player\e[0m: #{name.ljust(15, ' ')} - #{cash.to_s.concat('$').ljust(4, ' ')}\t\
        Cards: #{cards.map(&:info).join(' ').ljust(15, ' ')}\t\
        Score: #{score}"
  end

  def show_info(dealer, output:, full: false)
    output.puts info
    output.puts full ? dealer.full_info : dealer.info
  end
end
