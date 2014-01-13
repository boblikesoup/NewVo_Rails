class UsersController < ApplicationController
respond_to :html, :json

  def index
    respond_with(current_user)
  end

end