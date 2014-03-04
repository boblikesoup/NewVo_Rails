class CreateGroupTable < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.integer :creator_id
      t.text :user_id
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end

