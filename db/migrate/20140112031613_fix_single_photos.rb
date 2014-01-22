class FixSinglePhotos < ActiveRecord::Migration
  def change
    change_column_default :posts, :has_single_picture, false
  end
end
