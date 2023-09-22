# TicTacToe

To play the game run `ruby play.rb`.
To run the tests run `rake`. You may need to install with `bundle install` first.

## Design considerations

I am used to developing in an environment where the business logic is several layers removed from the presentation layer. Initially I was a bit disoriented thinking in this different environment.

This implementation is not perfect, but I have to stop somewhere, right? If I spent more time on this I would like to create a Session class that interfaces with IO. It would pass messages back and forth between the player using a CLI and the Game instance.

Right now it is not easy to test the Game class, because it expects inputs from $stdin and prints text to $stout. I am getting around this with DI (Dependency Inject), but it is not easily interoperable with other possible uses for the Game class such as putting this on a webserver that might return HTML and pass controller params into the Game class instances.

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

I have littered the code with a few comments explaining my considerations and how I might do things differently. Normally I do not comment code like this. Code should be self-documenting, and comments should be use sparingly to explain why something counter-intuitive is being done. These comments would normally be the topics of conversation in a Pull Request.
