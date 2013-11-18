class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  validates :body, presence: true
  default_scope order: 'comments.created_at DESC'


end