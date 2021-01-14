class CardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cards = current_user.cards.order(created_at: :asc)
    render json: @cards, include: [:author, :executors]
  end

  def show
    card
    render json: card, include: [:author, :executors, :column]
  end

  private

  def card
    @card ||= Card.find(params[:id])
  end
end
