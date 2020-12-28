class BoardsController < ApplicationController
  before_action :authenticate_user!

  def index
    render_jsonapi_response(current_user.boards.order(created_at: :desc))
  end

  def show
    render_jsonapi_response(board)
  end

  private

  def board
    @board ||= Board.find_by!(slug: params[:slug])
  end
end
