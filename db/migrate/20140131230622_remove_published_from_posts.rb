class RemovePublishedFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :published
  end
end
