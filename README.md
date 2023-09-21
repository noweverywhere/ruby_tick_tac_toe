### TicTacToe

To play the game run `ruby play.rb`


## Design considerations

Initially I was unfamiliar with a paradigm like this where I have to perform business logic operations in the same place where the information is then presented to the user. I am more familiar with patterns where the business logic is separate from the presentation layer.

I am not very happy with the current implementation, and I would like to create a Session class that basically implements IO operations and passes messages back and forth between the player and the game. Right now it is not easy to test the Game class, because it expects inputs from $stdin and prints text to $stout. With the implementation of a session class I can simply send messages to the Game class and receive arrays of string messages back that I will then present to the user.
That Session class would look something  like this:

```ruby
class Session
  def initialize
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
    raw_input = gets.chomp
  end

  def print_message(message)
    puts (message.is_a?(Array) ? message.flatten.join("\r") : message).gsub(/^\s+/, '')
  end
end
```