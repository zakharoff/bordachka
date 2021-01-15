class ColumnsController < ApplicationController
  before_action :authenticate_user!

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

  def column
    @column ||= Column.find(params[:id])
  end

  def column_params
    params.require(:column).permit(:title, :board_id)
  end
end
