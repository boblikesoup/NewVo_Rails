class CreateCommentActivities < ActiveRecord::Migration
  def change
    create_table :comment_activities do |t|
      t.integer :notified_user_id
      t.integer :other_user_id
      t.integer :comment_id
      t.timestamps
    end
  end
end
