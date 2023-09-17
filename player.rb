# frozen_string_literal: true

require './game'

class Player < Gamer
  ACTIONS = {
    reveal_cards_action: 'Reveal cards',
    skip_turn_action: 'Skip a turn',
    take_card_action: 'Take a card'
  }

  attr_reader :name

  def initialize(name)
    super()
    @name = name
  end

  def action(dealer, bank, input:, output:)
    show_info(dealer, bank, output:)
    output.print menu_info.chomp
    value = input.gets.to_i

    if action_range.include?(value)
      args = [dealer, bank]
      kwargs = { input:, output: }
      send(actions.keys[value - 1], *args, **kwargs)
    else
      action(dealer, bank, input:, output:)
    end
  end

  def menu_info
    options = actions.values.each_with_object([]).with_index(1) { |(e, arr), i| arr << [i, e] }
    <<~MENU
      Your move. What will you do?
        #{options.map { |item| item.join('. ') }.join("\n  ")}
      Choose an action #{actions.keys.map { |e| actions.keys.index(e) + 1 }.join('/')}:
    MENU
  end

  def info
    "\e[4m#Player\e[0m: #{name.ljust(15, ' ')} - #{cash.to_s.concat('$').ljust(4, ' ')}\t\
        Cards: #{cards.map(&:info).join(' ').ljust(15, ' ')}\t\
        Score: #{score}"
  end

  def reveal_cards_action(dealer, bank, input:, output:)
    show_info(dealer, bank, output:, full: true)
  end

  def skip_turn_action(dealer, bank, input:, output:)
    dealer.action(self, bank, input:, output:)
  end

  def take_card_action(dealer, bank, input:, output:)
    dealer.deal_card(self)
    show_info(dealer, bank, output:)
    dealer.action(self, bank, input:, output:)
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

  def actions
    ACTIONS.dup.delete_if { |k, _v| k == :take_card_action && cards_limit? }
  end

  def action_range
    Range.new(1, actions.size)
  end

  def cards_limit?
    cards.size == Gamer::CARDS_LIMIT
  end
end
