require 'minitest/autorun'
require 'stringio'
require 'debug'
require './lib/game'

describe Game do
  let(:input) { Minitest::Mock.new }
  let(:output) { Minitest::Mock.new }

  describe 'given predictable input' do
    it 'the game comes to an end' do
      # this is not a great unit test, it is effectively more of an integration
      # test. But at the very least it does do a happy-path flow for a game
      ['0,0', '1,0', '0,1', '1,1', '0,2', '1,2'].each do |coordinate|
        input.expect(:gets, coordinate, [])
      end
      25.times { output.expect(:puts, true, [String]) }

      assert_equal :game_over, Game.new(user_input: input, output: output).start
    end
  end
end
