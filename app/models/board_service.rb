# frozen_string_literal: true

# Manage board requests by calling the generator
# and instrumenting with active support
class BoardService
  def create_board(board_request)
    data = BoardGenerator.new.generate(
      board_request[:board_width].to_i,
      board_request[:board_height].to_i,
      board_request[:number_of_mines].to_i
    )

    board = Board.new(
      email: board_request[:email],
      name: board_request[:board_name],
      number_of_mines: board_request[:number_of_mines],
      data:
    )

    return Response.new(success?: true, board:) if board.save

    Response.new(success?: false, board: nil)
  end

  Response = Struct.new(:success?, :board)
end
