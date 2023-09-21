class Board
  attr_reader :grid

  def initialize(dimensions:)
    @dimensions = dimensions
    clear
  end

  def clear
    @grid = (0..@dimensions - 1).map { Array.new(@dimensions) }
  end

  def set_cell_value(x_pos, y_pos, value)
    # will add validation and guards for out of range values

    @grid[x_pos][y_pos] = value
  end

  def render
    # this could potentially be a method on a rendering class, because
    # I kind of want to have the rendering to be outside of the business logic modules
    # so that I could render this board using plain text in a CLI, or using HTML, or
    # ncurses in a terminal
    @grid.map { |row| row.map { |cell_contents| cell_contents.nil? ? '_' : cell_contents.symbol }.join('|') }.join("\n")
  end
end
