class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @reviews = @user.sort_reviews_by(params[:dir])
  end
end
