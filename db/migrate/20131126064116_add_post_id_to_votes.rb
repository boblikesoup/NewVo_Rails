class AddPostIdToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :post_id, :integer
  end
end
