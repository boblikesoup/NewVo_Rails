class Post < ActiveRecord::Base
    belongs_to :user
    has_many :comments
    has_many :votes, :as => :votable

    has_attached_file :picture1, :styles => { :medium => "300x300>", :thumb => "100x100>" }
    validates_attachment :picture1, :presence => true,
      :content_type => { :content_type => %w(image/jpg image/png image/jpeg)},
      :size => { :in => 0..500.kilobytes}


end