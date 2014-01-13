class Photo < ActiveRecord::Base
  belongs_to :post
  has_many :votes, :as => :votable, :dependent => :destroy
  has_attached_file :photo,
                    :styles => { :medium => "300x300>", :thumb => "100x100>" }
  validates_attachment :photo, :presence => true,
      :content_type => { :content_type => %w(image/jpg image/png image/jpeg)},
      :size => { :in => 0..500.kilobytes}

  def as_json(options={})
    {
      :id => id,
      :url => photo.url,
      :upvotes => upvotes,
      :downvotes => downvotes
    }
  end
  # TODO
  # refactor into one method or use counter cache to speed up

  def upvotes
    self.votes.group(:value).count[1] || 0
  end

  def downvotes
    self.votes.group(:value).count[-1] || 0
  end

end