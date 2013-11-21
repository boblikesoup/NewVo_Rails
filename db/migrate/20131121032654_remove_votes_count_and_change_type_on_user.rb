class RemoveVotesCountAndChangeTypeOnUser < ActiveRecord::Migration
  def change
    remove_column :users, :votes_count
    remove_column :users, :type
    add_column :users, :single, :boolean, default: true
  end
end
