class BoardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @boards = current_user.boards.order(created_at: :desc)
    render json: BoardSerializer.new(@boards, include: ['author'])
  end

  def show
    board
    render json: BoardSerializer.new(board, include: ['author'])
  end

  private

  def board
    @board ||= Board.find_by!(slug: params[:slug])
  end
end
