class EditGroupTable < ActiveRecord::Migration
  def change
    remove_column :groups, :creator_id
    remove_column :groups, :user_id
    add_column :groups, :member_ids, :text
    add_column :groups, :user_id, :integer
  end
end
