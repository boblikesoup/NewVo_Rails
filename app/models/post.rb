class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments#, :dependent => :destroy
  has_many :photos#, :dependent => :destroy
  accepts_nested_attributes_for :photos,
      :reject_if => lambda { |attributes| attributes[:photo].blank? }

  after_save :update_has_single_picture

  # validates_presence_of :title
  # validates_presence_of :user_id
  # validates_presence_of :single

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
    self.update_columns(has_single_picture: 'false') if self.photos.count == 2
  end
end
