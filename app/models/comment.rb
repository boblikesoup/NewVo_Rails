class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post#, :counter_cache => true
  has_many :votes, :as => :votable, :dependent => :destroy

  validates :body, presence: true
  default_scope order: 'comments.created_at DESC'

  def as_json(options={})
    {
      :id => id,
      :body => body,
      :votes => get_votes,
      :user_id => user_id
    }
  end

  def get_votes
    self.votes.group(:value).count[1] || 0
  end



end