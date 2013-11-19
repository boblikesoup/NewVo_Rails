class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post, :counter_cache => true
  has_many :votes, :as => :votable

  validates :body, presence: true
  default_scope order: 'comments.created_at DESC'


end