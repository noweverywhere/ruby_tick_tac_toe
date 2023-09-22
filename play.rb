require './lib/game'

begin
  Game.new.start
rescue Interrupt => e
  puts "\nGame ended"
end
