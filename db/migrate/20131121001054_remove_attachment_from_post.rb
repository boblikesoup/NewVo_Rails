class RemoveAttachmentFromPost < ActiveRecord::Migration
  def change
    remove_attachment :posts, :picture1
  end
end
