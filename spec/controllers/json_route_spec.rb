require 'spec_helper'

feature 'api routes' do
  describe Api::PostsController do
    describe "GET :index" do
      it "should be success" do
        do_get
      response.should be_success
    end

    def do_get
      get :index, :format => :json
    end
  end
end

end