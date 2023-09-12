# frozen_string_literal: true

require './gamer'
require './deck'

class Dealer < Gamer
  attr_reader :deck

  def initialize
    super()
    @deck = Deck.new
  end

  def deal_card(player)
    player.take_card(deck.draw)
  end

  def action(player, bank, input:, output:)
    if reveal_cards?(player)
      show_info(player, bank, output:, full: true)
    elsif skip_move?
      player.action(self, bank, input:, output:)
    else
      deal_card(self)
      show_info(player, bank, output:)
      player.action(self, bank, input:, output:)
    end
  end

  def info
    "\e[4m#Dealer\e[0m: #{''.ljust(15, ' ')} - #{cash.to_s.concat('$').ljust(4, ' ')}\t\
        Cards: #{Array.new(cards.count, '*').join(' ').ljust(15, ' ')}\t\
        Score: ??"
  end

  def full_info
    "\e[4m#Dealer\e[0m: #{''.ljust(15, ' ')} - #{cash.to_s.concat('$').ljust(4, ' ')}\t\
        Cards: #{cards.map(&:info).join(' ').ljust(15, ' ')}\t\
        Score: #{score}"
  end

  private

  def reveal_cards?(player)
    cards.size == 3 && player.cards.size >= 3
  end

  def show_info(player, bank, output:, full: false)
    output.puts "Game bank: #{bank.values.inject(:+)}$"
    output.puts player.info

    if full
      output.puts full_info
      if win?(player)
        output.puts 'Sorry, you lose...'
        self.cash = cash + bank.values.inject(:+)
      elsif lose?(player)
        output.puts 'Congrats, you win!'
        player.cash = player.cash + bank.values.inject(:+)
      else
        output.puts 'Draw!'
        player.cash = player.cash + bank[:dealer]
        self.cash = cash + bank[:player]
      end
    else
      output.puts info
    end
  end

  def skip_move?
    score >= 17
  end
end
