require 'spec_helper'

describe Photo do
  it { should have_attached_file(:photo) }
  it { should validate_attachment_presence(:photo) }
  it { should validate_attachment_content_type(:photo).allowing %w(image/jpg image/png image/jpeg)}
  it { should validate_attachment_size(:photo)}

  it "a photo object can be created" do
     photo_create
  end

  it "a double photo object can be created" do
     double_photo_create
  end
end