require 'minitest/autorun'
require 'stringio'
require 'debug'
require './lib/game'

describe Game do
  describe 'game behaviour' do
    it 'what it must do' do
      mock = Minitest::Mock.new
      mock.expect(:gets, '0,0')
      mock.expect(:gets, '1,0')
      mock.expect(:gets, '0,1')
      mock.expect(:gets, '1,1')
      mock.expect(:gets, '0,2')
      mock.expect(:gets, '1,2')

      assert_equal :game_over, Game.new(user_input: mock).start
    end
  end
end
