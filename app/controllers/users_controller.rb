class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.includes(:recipe).all
  end
end
