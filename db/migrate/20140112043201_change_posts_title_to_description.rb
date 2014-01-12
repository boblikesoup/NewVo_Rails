class ChangePostsTitleToDescription < ActiveRecord::Migration
  def change
    rename_column :posts, :title, :description
  end
end
