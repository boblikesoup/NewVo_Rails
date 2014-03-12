class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :votes, :as => :votable, :dependent => :destroy

  validates :body, presence: true
  validates :post_id, presence: true
  validates :user_id, presence: true
  default_scope order: 'comments.created_at DESC'

  scope :recent, ->{order(created_at: :desc)}
  scope :published, ->{where(status: self::STATUS_PUBLISHED)}

  STATUS_PUBLISHED = 0
  STATUS_UNPUBLISHED = 1

  def as_json(options={})
    {
      :id => id,
      :body => body,
      :user_id => user_id,
      :profile_pic => User.find(user_id).profile_pic,
      :post_id => post_id,
      :user_name => User.find(user_id).first_name,
      :created_at => created_at
    }
  end

  def get_votes
    #when using votes add ":votes => get_votes," to as_json method
    self.votes.group(:value).count[1] || 0
  end
end