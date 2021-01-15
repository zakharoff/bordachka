class CardsController < ApplicationController
  before_action :authenticate_user!

  def create
    @card = Card.new(card_params)
    @card.author_id = current_user.id

    if @card.save
      render json: @card, include: [:author, :column], status: :created
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  def destroy
    card

    if @card.destroy
      render json: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  private

  def card
    @card ||= Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:title, :body, :board_id, :column_id)
  end
end
