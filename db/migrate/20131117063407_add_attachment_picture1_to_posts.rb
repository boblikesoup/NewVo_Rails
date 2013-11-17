class AddAttachmentPicture1ToPosts < ActiveRecord::Migration
  def change
    add_attachment :posts, :picture1
  end

end
