class TicTacToe
  def self.stalemate?(players, grid)
    players.none? { |player| winner?(player, grid) } && grid.flatten.none?(&:nil?)
  end

  def self.winner?(player, grid)
    horizontal_winner?(player, grid) ||
      vertical_winner?(player, grid) ||
      diagonal_winner?(player, grid)
  end

  def self.horizontal_winner?(player, grid)
    grid.map.any? { |row| row.all? { |cell_value| cell_value == player } }
  end

  def self.vertical_winner?(player, grid)
    # if the grid will later be greater than 3x3 these magic numbers will have to
    # be removed and the values derived from the properties of the grid, or else
    # they could be passed in from the Game instance. My intuition is telling me
    # that using a hash is going to be better as a representation of the board state.
    # I think at that point I will store the dimensions on that hash
    (0..2).any? { |index| grid.all? { |a| a.slice(index) == player } }
  end

  def self.diagonal_winner?(player, grid)
    [
      [grid[0][0], grid[1][1], grid[2][2]].all? { |cell_value| cell_value == player },
      [grid[0][2], grid[1][1], grid[2][0]].all? { |cell_value| cell_value == player }
    ].any?
  end

  def self.valid_move?(dimensions, grid, x_pos, y_pos)
    return false if [x_pos, y_pos].any? { |value| value > dimensions - 1 }
    return false unless grid[x_pos][y_pos].nil?

    true
  end
end
