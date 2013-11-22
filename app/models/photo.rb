class Photo < ActiveRecord::Base
  belongs_to :post
  has_many :votes, :as => :votable, :dependent => :destroy
  has_attached_file :photo, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment :photo, :presence => true,
      :content_type => { :content_type => %w(image/jpg image/png image/jpeg)},
      :size => { :in => 0..500.kilobytes}

end