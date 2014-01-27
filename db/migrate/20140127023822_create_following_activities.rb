class CreateFollowingActivities < ActiveRecord::Migration
  def change
    create_table :following_activities do |t|
      t.integer :notified_user_id
      t.integer :other_user_id
      t.integer :following_id
      t.timestamps
    end
  end
end
