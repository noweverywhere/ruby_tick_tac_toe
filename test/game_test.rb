require 'minitest/autorun'
require 'stringio'
require 'debug'
require './lib/game'

describe Game do
  let(:game) { Game.new }

  describe '#over?' do
    describe 'when the game has not started yet' do
      it 'is not over' do
        refute game.over?
      end
    end
  end

  describe '#start' do
    it 'returns the expected messages' do
      assert_equal([], game.start)
    end
  end
end
