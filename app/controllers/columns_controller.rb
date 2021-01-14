class ColumnsController < ApplicationController
  before_action :authenticate_user!

  def index
    @columns = board.columns.order(created_at: :asc)
    render json: @columns, include: [:cards]
  end

  private

  def board
    @board ||= Board.find(params.require(:column)[:board_id])
  end
end
