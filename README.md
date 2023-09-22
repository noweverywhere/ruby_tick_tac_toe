### TicTacToe

To play the game run `ruby play.rb`.
To run the tests run `rake`. You may need to install with `bundle install` first.

## Design considerations

Initially I was unfamiliar with a paradigm like this where I have to perform business logic operations in the same place where the information is then presented to the user. I am more familiar with patterns where the business logic is separate from the presentation layer.

I am not very happy with the current implementation, and I would like to create a Session class that basically implements IO operations and passes messages back and forth between the player and the game. Right now it is not easy to test the Game class, because it expects inputs from $stdin and prints text to $stout. For now I am getting around this constraint with DI (Dependency Inject), but it is not easily interoperable with other possible use-cases such as putting this on a webserver that might return HTML and pass controller params into the Game class instances. With the implementation of a session class I can simply send messages to the Game class and receive arrays of string messages back that I will then present to the user.

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
