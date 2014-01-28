class AddFollowedTypeToFollowingActivities < ActiveRecord::Migration
  def change
    add_column :following_activities, :followed_type, :string
  end
end
