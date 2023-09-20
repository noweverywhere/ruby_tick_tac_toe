require 'minitest/autorun'
require './lib/tic_tac_toe'

describe TicTacToe do
  describe 'game behaviour' do
    it 'returns true' do
      assert TicTacToe.new.returns_true
    end
  end
end
