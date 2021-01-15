class ColumnsController < ApplicationController
  before_action :authenticate_user!

  def index
    @columns = board.columns.order(created_at: :asc)
    render json: @columns, include: [:cards]
  end

  def create
    @column = Column.new(column_params)

    if @column.save
      render json: @column, status: :created
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  def destroy
    column

    if @column.destroy
      render json: @column
    else
      render json: @column.errors, status: :unprocessable_entity
    end
  end

  private

  def board
    @board ||= Board.find(params[:column][:board_id])
  end

  def column
    @column ||= Column.find(params[:id])
  end

  def column_params
    params.require(:column).permit(:title, :board_id)
  end
end
