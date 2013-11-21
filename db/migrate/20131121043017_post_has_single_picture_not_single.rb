class PostHasSinglePictureNotSingle < ActiveRecord::Migration
  def change
    rename_column(:posts, :single, :has_single_picture)
  end
end
