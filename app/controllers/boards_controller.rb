class BoardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @boards = current_user.boards.order(created_at: :desc)
    render json: @boards, include: [:author]
  end

  def show
    board
    render json: @board, include: [:author, :columns, :cards], serializer: BoardFullSerializer
  end

  def create
    @board = Board.new(board_params)
    @board.author_id = current_user.id

    if @board.save
      render json: @board, include: [:author], status: :created
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  def destroy
    board

    if @board.destroy
      render json: @board
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  private

  def board
    @board ||= Board.find_by!(slug: params[:slug])
  end

  def board_params
    params.require(:board).permit(:title, :description, :img_url)
  end
end
