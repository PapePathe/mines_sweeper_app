# frozen_string_literal: true

# Manage board requests by calling the generator
# and instrumenting with active support
class BoardService
  # creates a new board from request params
  def create_board(board_request)
    data = [[]]
    instrumentation_details = {
      h: board_request[:board_height],
      w: board_request[:board_width],
      m: board_request[:number_of_mines]
    }

    ActiveSupport::Notifications.instrument "minesweeper.generate_board", instrumentation_details do
      data = BoardGenerator.new.generate(
        board_request[:board_width].to_i,
        board_request[:board_height].to_i,
        board_request[:number_of_mines].to_i
      )
    end

    board = Board.new(
      email: board_request[:email],
      name: board_request[:board_name],
      number_of_mines: board_request[:number_of_mines],
      data: data
    )

    return Response.new(success?: true, board:) if board.save

    Response.new(success?: false, errors: board.errors.full_messages)
  end

  # A response object for easy integration in controllers
  Response = Struct.new(:success?, :board, :errors)
end
