class UserProfileColumns < ActiveRecord::Migration
  def change
    add_column :users, :description, :string
    add_attachment :users, :avatar
  end
end
