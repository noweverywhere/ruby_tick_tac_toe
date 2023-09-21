require_relative 'board'
require_relative 'player'
require_relative 'tic_tac_toe'

class Game
  BOARD_SIZE = 3

  def initialize(user_input: $stdin)
    @user_input = user_input
    @board = Board.new(dimensions: BOARD_SIZE)
    @players = [
      Player.new(name: 'Player 1', symbol: 'X'),
      Player.new(name: 'Player 2', symbol: 'O')
    ]
    @current_player_index = nil
  end

  def start
    print_message welcome_message
    choose_random_player
    play_turn until winner? || TicTacToe.stalemate?(@players, @board.grid)

    print_message('Game Over!')
    print_message @board.render
    :game_over
  end

  def play_turn
    prompt_turn
    print_message @board.render
    x, y = ask_move
    @board.set_cell_value(x, y, current_player)
    set_next_players_turn
  end

  private

  def prompt_turn
    print_message turn_message
  end

  def winner?
    @players.any? { |player| TicTacToe.winner?(player, @board.grid) }
  end

  def ask_move
    input = ask_input

    # using splat only to show I know how to use it, but normally I would probably just have passed the array
    return input if TicTacToe.valid_move?(BOARD_SIZE, @board.grid, *input)

    print_message ["'#{input}' is not a valid move.", turn_message]
    print_message @board.render

    # using recursion
    ask_move
  end

  def ask_input
    print_message "#{current_player.name}'s input:"
    raw_input = @user_input.gets.chomp
    # I am not sure how you feel about regex. I am aware that my regex is more permissive
    # than the <number>,<number> format. It will accept any non-word character as a break
    # between the two numbers
    return raw_input.split(/\W/).map(&:to_i) if raw_input.match(/^\d\W\d$/)

    print_message ["'#{raw_input}' is not valid input.", valid_format_explanation, turn_message]
    print_message @board.render
    ask_input
  end

  def players_symbols
    @players.map(&:symbol)
  end

  def choose_random_player
    @current_player_index = [0, 1].sample
  end

  def set_next_players_turn
    @current_player_index = @current_player_index.next
  end

  def turn_message
    "It is #{current_player.name}'s turn (their mark is '#{current_player.symbol}')."
  end

  def current_player
    @players[@current_player_index % 2]
  end

  def welcome_message
    ['Welcome to Tic-Tac-Toe!', valid_format_explanation]
  end

  def print_message(message)
    puts (message.is_a?(Array) ? message.join("\r") : message).gsub(/^\s+/, '')
  end

  def valid_format_explanation
    "
    Players need to specify the positions they want to play in the format x,y.
    To mark the top left corner enter 0,0.
    To mark the bottom right corner enter #{BOARD_SIZE - 1},#{BOARD_SIZE - 1}."
  end
end
