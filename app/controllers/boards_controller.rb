class BoardsController < ApplicationController

  rescue_from InvalidArgument do |e|
    flash[:error] = e.message
    redirect_to root_path
  end

  def create
    result = BoardService.new.create_board(board_request)

    if result.success?
      redirect_to board_path(result.board)
    else
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  private

  def board_request
    params.permit(:email, :board_width, :board_height, :board_name, :number_of_mines)
  end
end
