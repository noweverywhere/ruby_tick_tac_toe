# TicTacToe

To play the game run `ruby play.rb`.
To run the tests run `rake`. You may need to install with `bundle install` first.

## Design considerations

I am familiar with developing in an environment where the business logic is several layers removed from the presentation layer. Initially I was a bit disoriented thinking in this different environment.

I am mostly happy with my [TicTacToe module](./lib/tic_tac_toe.rb), as it is generic and concisely captures the rules/logic of the game. This module could be used for determining turns and outcomes for any 3x3 TicTacToe game. It tries to make as few assumptions as possible. This is what that module looks like:

```ruby
module TicTacToe
  def self.stalemate?(players, grid)
    players.none? { |player| winner?(player, grid) } && grid.flatten.none?(&:nil?)
  end

  def self.winner?(player, grid)
    horizontal_winner?(player, grid) ||
      vertical_winner?(player, grid) ||
      diagonal_winner?(player, grid)
  end

  def self.horizontal_winner?(player, grid)
    grid.map.any? { |row| row.all? { |cell_value| cell_value == player } }
  end

  def self.vertical_winner?(player, grid)
    # if the grid will later be greater than 3x3 these magic numbers will have to
    # be removed and the values derived from the properties of the grid, or else
    # they could be passed in from the Game instance. My intuition is telling me
    # that using a hash is going to be better as a representation of the board state.
    # I think at that point I will store the dimensions on that hash
    (0..2).any? { |index| grid.all? { |a| a.slice(index) == player } }
  end

  def self.diagonal_winner?(player, grid)
    [
      [grid[0][0], grid[1][1], grid[2][2]].all? { |cell_value| cell_value == player },
      [grid[0][2], grid[1][1], grid[2][0]].all? { |cell_value| cell_value == player }
    ].any?
  end

  def self.valid_move?(dimensions, grid, x_pos, y_pos)
    return false if [x_pos, y_pos].any? { |value| value > dimensions - 1 }
    return false unless grid[x_pos][y_pos].nil?

    true
  end
end
```

The Game class is not perfect, but I have to stop somewhere, right? If I spent more time on this I would like to create a Session class that interfaces with IO. It would pass messages back and forth between the player using a CLI and the Game instance. This Session class would remove the rendering and input gathering concerns from the Game class.

Right now it is not easy to test the Game class, because it expects inputs from $stdin and prints text to $stout. I am getting around this with DI (Dependency Injection), but it is not easily interoperable with other possible uses for the Game class such as putting this on a webserver that might return HTML and pass controller params into the Game class instances.

That Session class would look something  like this:

```ruby
class Session
  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
    @game = Game.new
    print_message @game.start
  end

  def play
    play_round until @game.over?
    puts 'Game Over'
    return unless play_again?

    @game.reset
    play
  end

  def play_round
    print_message @game.play(player_input)
  end

  def player_input
    @input.gets.chomp
  end

  def print_message(message)
    @output.puts (message.is_a?(Array) ? message.flatten.join("\r") : message).gsub(/^\s+/, '')
  end
end
```

## Code comments

I have littered the code with a few comments explaining my considerations and how I might do things differently. Normally I do not comment code like this. Code should be self-documenting, and comments should be used sparingly to explain why something counter-intuitive is being done. These comments would normally be the topics of conversation in a Pull Request.
