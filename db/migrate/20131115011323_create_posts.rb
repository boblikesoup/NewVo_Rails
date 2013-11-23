class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.belongs_to :user
      t.boolean :has_single_picture, default: true
      t.timestamps
    end
  end
end
