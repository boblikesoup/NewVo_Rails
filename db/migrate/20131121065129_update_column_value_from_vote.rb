class UpdateColumnValueFromVote < ActiveRecord::Migration
  def change
    change_column :votes, :value, :integer, :null => false, :default => 0
  end
end
