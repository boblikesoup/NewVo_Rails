class AddNewvoTokenToUser < ActiveRecord::Migration
  def change
    add_column :users, :newvo_token, :string
  end
end
