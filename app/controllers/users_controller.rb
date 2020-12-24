class UsersController < ApplicationController
  def show
    render_jsonapi_response(user)
  end

  private

  def user
    @user ||= User.find(params[:id])
  end
end
