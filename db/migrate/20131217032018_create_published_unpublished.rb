class CreatePublishedUnpublished < ActiveRecord::Migration
  def change
    add_column :posts, :published, :boolean, default: true
  end
end
