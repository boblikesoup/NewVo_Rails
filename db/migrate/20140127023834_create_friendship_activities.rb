class CreateFriendshipActivities < ActiveRecord::Migration
  def change
    create_table :friendship_activities do |t|
      t.integer :notified_user_id
      t.integer :other_user_id
      t.integer :friendship_id
      t.timestamps
    end
  end
end
