class BoardsController < ApplicationController
  def create
    data = generator.generate(
      board_request[:board_width].to_i,
      board_request[:board_height].to_i,
      board_request[:number_of_mines].to_i
    )

    board = Board.new(
      email: board_request[:email],
      name: board_request[:board_name],
      number_of_mines: board_request[:email],
      data: data,
    )

    board.save

    redirect_to board_path(board)
  end

  def show
    @board = Board.find(params[:id])
  end

  private

  def generator
    BoardGenerator.new
  end

  def board_request
    params.permit(:email, :board_width, :board_height, :board_name, :number_of_mines)
  end
end
