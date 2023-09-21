require_relative 'game'

class Session
  attr_reader :game

  def initialize
    @game = Game.new
    print_message @game.start
  end

  def play
    play_round until game.over?
    puts 'Game Over'
    return unless play_again?

    game.reset
    play
  end

  def print_message(message)
    puts (message.is_a?(Array) ? message.flatten.join("\r") : message).gsub(/^\s+/, '')
  end

  def play_round
    print_message game.play(player_input)
  end

  def player_input
    raw_input = gets.chomp
  end
end
