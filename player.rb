# frozen_string_literal: true

require './game'

class Player < Gamer
  attr_reader :name

  def initialize(name)
    super()
    @name = name
  end

  def action(dealer, bank, input:, output:)
    show_info(dealer, bank, output:)
    output.print menu_info.chomp
    value = input.gets.to_i
    if (1..3).include?(value)
      case value
      when 1
        dealer.action(self, bank, input:, output:)
      when 2
        dealer.deal_card(self)
        show_info(dealer, bank, output:)
        dealer.action(self, bank, input:, output:)
      when 3
        show_info(dealer, bank, output:, full: true)
      end
    else
      action(dealer, bank, input:, output:)
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

  private

  def show_info(dealer, bank, output:, full: false)
    output.puts "Game bank: #{bank.values.inject(:+)}$"
    output.puts info

    if full
      output.puts dealer.full_info
      if win?(dealer)
        output.puts 'Congrats, you win!'
        self.cash += bank.values.inject(:+)
      elsif lose?(dealer)
        output.puts 'Sorry, you lose...'
        dealer.cash = dealer.cash + bank.values.inject(:+)
      else
        output.puts 'Draw!'
        dealer.cash = dealer.cash + bank[:dealer]
        self.cash += bank[:player]
      end
    else
      output.puts dealer.info
    end
  end
end
