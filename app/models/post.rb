class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :photos
  accepts_nested_attributes_for :photos,
      :reject_if => lambda { |attributes| attributes[:photo].blank? }

  after_save :update_has_single_picture

  validates_presence_of :title
  validates_presence_of :user_id
  validates_presence_of :photos


  def as_json(options={})
    {
      :post_id => id,
      :title => title,
      :has_single_picture => has_single_picture,
      :photos => photos,
      :comments => comments
    }
  end

  private

  def update_has_single_picture
    self.update_columns(has_single_picture: 'true') if self.photos.count == 1
  end
end
