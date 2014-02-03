class AddStatusToTables < ActiveRecord::Migration
  def change
    add_column :comment_activities, :status, :integer, default: 0
    add_column :following_activities, :status, :integer, default: 0
    add_column :friendship_activities, :status, :integer, default: 0
    add_column :vote_activities, :status, :integer, default: 0
    add_column :comments, :status, :integer, default: 0
    add_column :posts, :status, :integer, default: 0
    add_column :users, :status, :integer, default: 0
    add_column :votes, :status, :integer, default: 0
  end
end
