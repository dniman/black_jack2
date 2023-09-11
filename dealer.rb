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

  def action(player, input:, output:)
    if reveal_cards?(player)
      show_info(player, output:, full: true)
    elsif skip_move?
      player.action(self, input:, output:)
    else
      deal_card(self)
      show_info(player, output:)
      player.action(self, input:, output:)
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

  def show_info(player, output:, full: false)
    output.puts player.info
    output.puts full ? full_info : info
  end

  def skip_move?
    score >= 17
  end
end
