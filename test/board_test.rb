require 'minitest/autorun'
require 'ostruct'
require 'debug'
require './lib/board'

describe Board do
  describe '#initialize' do
    it 'returns a grid of specified size' do
      board = Board.new(dimensions: 3)

      assert_equal [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]], board.grid
    end
  end

  describe '#render' do
    describe 'when the board is empty' do
      it 'looks the way we expect it to' do
        board = Board.new(dimensions: 3)
        expected_board_appearance = "
        _|_|_
        _|_|_
        _|_|_".gsub(/^\s+/, '')

        assert_equal expected_board_appearance, board.render
      end
    end

    describe 'when the board is not empty' do
      it 'looks the way we expect it to' do
        board = Board.new(dimensions: 3)
        board.set_cell_value(0, 0, OpenStruct.new(symbol: 'X'))

        expected_board_appearance = "
        X|_|_
        _|_|_
        _|_|_".gsub(/^\s+/, '')

        assert_equal expected_board_appearance, board.render
      end
    end
  end
end
