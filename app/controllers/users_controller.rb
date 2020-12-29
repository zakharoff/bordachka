class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    user
    render json: UserSerializer.new(user)
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
