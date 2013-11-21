class AddColumnVotesCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :votes_count, :integer, :null => false, :default => 0
  end
end
