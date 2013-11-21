class RemoveSingleFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :single
  end
end
