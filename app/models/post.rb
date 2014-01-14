class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :photos
  accepts_nested_attributes_for :photos,
      :reject_if => lambda { |attributes| attributes[:photo].blank? }

  after_save :update_has_single_picture

  validates_presence_of :user_id
  validates_presence_of :photos


  def as_json(options={})
    {
      :post_id => id,
      :description => description,
      :has_single_picture => has_single_picture,
      :photos => photos,
      # :user_voted => user_voted,
      :comments => comments
    }
  end

  private

  # def user_voted
  #   vote = Vote.find_by(user_id: User.current.id, post_id: self.id)
  #   if vote != nil
  #     return true
  #   else
  #     return false
  #   end
  # end

  def update_has_single_picture
    self.update_columns(has_single_picture: 'true') if self.photos.count == 1
  end

end