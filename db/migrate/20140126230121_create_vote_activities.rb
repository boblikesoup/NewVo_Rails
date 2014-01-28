class CreateVoteActivities < ActiveRecord::Migration
  def change
    create_table :vote_activities do |t|
      t.integer :notified_user_id
      t.integer :other_user_id
      t.integer :vote_id
      t.timestamps
    end
  end
end
