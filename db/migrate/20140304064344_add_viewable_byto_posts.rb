class AddViewableBytoPosts < ActiveRecord::Migration
  def change
    add_column :posts, :viewable_by, :integer, default: 1
  end
end
