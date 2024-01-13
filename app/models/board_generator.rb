class BoardGenerator
  def generate(rows, columns, mines_count)
    raise InvalidArgument, "mines count must be a number" unless mines_count.is_a?(Integer)
    raise InvalidArgument, "columns must be a number" unless columns.is_a?(Integer)
    raise InvalidArgument, "rows must be a number" unless rows.is_a?(Integer)
    raise InvalidArgument, "rows must be greater than zero" if rows <= 0
    raise InvalidArgument, "columns must be greater than zero" if columns <= 0
    raise InvalidArgument, "number of mines must be less that board size" if mines_count >= rows * columns

    board = Array.new(rows) { Array.new(columns, 0)}

    while mines_count > 0
      rand_row = rand(rows)
      rand_col = rand(columns)

      next if board[rand_row][rand_col] == 1

      board[rand_row][rand_col] = 1
      mines_count -= 1
    end

    board
  end
end
