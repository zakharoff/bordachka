class BoardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @boards = current_user.boards.order(created_at: :desc)
    render json: @boards, include: [:author]
  end

  def show
    board
    render json: board, include: [:author, :column, :cards]
  end

  private

  def board
    @board ||= Board.find_by!(slug: params[:slug])
  end
end
