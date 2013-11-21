class RemoveTypeAddSingleToPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :type
    add_column :posts, :single, :boolean, default: true
    remove_column :posts, :votes_count
  end
end
