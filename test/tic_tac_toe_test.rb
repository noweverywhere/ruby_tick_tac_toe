require 'minitest/autorun'
require './lib/tic_tac_toe'

describe TicTacToe do
  let(:empty_board) do
    (0..2).map { Array.new 3 }
  end

  describe '.is_valid_move?' do
    describe 'when the desired location is already filled' do
      it 'returns false' do
        board = empty_board
        empty_board[0][0] = 'not_nil'

        refute TicTacToe.valid_move?(1, board, 0, 0)
      end
    end

    describe 'when the desired location is empty' do
      it 'returns true' do
        assert TicTacToe.valid_move?(1, empty_board, 0, 0)
      end
    end
  end

  describe '.winner?' do
    describe 'when there is no winner' do
      describe 'the board is empty' do
        it 'does not find a winner' do
          refute TicTacToe.winner?('X', empty_board)
        end
      end

      describe 'when there are marks on the board' do
        it 'does not find a winner' do
          board = [
            %w[X O X],
            %w[X O X],
            %w[O X O]
          ]

          refute TicTacToe.winner?('X', board)
          refute TicTacToe.winner?('O', board)
        end
      end
    end

    describe 'when player with "X" is the winner' do
      describe 'with a horizontal row' do
        it 'declares them the winner' do
          board = [
            %w[X X X],
            [nil, 'O', nil],
            %w[X O X]
          ]

          assert TicTacToe.winner?('X', board)
        end
      end

      describe 'with a vertical line' do
        it 'declares them the winner' do
          board = [
            %w[X O X],
            %w[X b O],
            %w[X O X]
          ]

          assert TicTacToe.winner?('X', board)
        end
      end

      describe 'with a diagonal line' do
        it 'declares them the winner' do
          board = [
            %w[X O O],
            %w[O X O],
            %w[O O X]
          ]

          assert TicTacToe.winner?('X', board)
        end
      end
    end
  end

  describe '.stalemate?' do
    describe 'when there are still moves to be made' do
      it 'returns false' do
        board = [
          %w[X O O],
          %w[X X O],
          Array.new(3)
        ]

        refute TicTacToe.stalemate?(%w[X O], board)
      end
    end

    describe 'when there is a winner' do
      it 'returns false' do
        board = [
          %w[X O O],
          %w[O X O],
          %w[O O X]
        ]

        refute TicTacToe.stalemate?(%w[X O], board)
      end
    end

    describe 'when there are no more moves to be made and there is no winner' do
      it do
        board = [
          %w[X O O],
          %w[O X X],
          %w[O X O]
        ]

        assert TicTacToe.stalemate?(%w[X O], board)
      end
    end
  end
end
