class API::V1::ActivityFeedController < ApplicationController
  respond_to :json

  def index
    @data = []
    two_weeks_ago = Time.now - 2.weeks
    info = VoteActivity.where("notified_user_id = ?", current_user.id).where("created_at > ?", two_weeks_ago)
    #do for the rest of the activities
    respond_with(@data)
  end

  before_filter :set_current_user

end

