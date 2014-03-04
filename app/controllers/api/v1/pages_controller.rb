class API::V1::PagesController < API::V1::ApplicationController
  respond_to :json

  def legal
    render json: {}
  end

  def about
    render json: {}
  end

  def contact_us
    render json: {}
  end

end