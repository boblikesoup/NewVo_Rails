class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :posts

  serialize :member_ids, Array
  validates_presence_of :user_id
  validates_presence_of :member_ids
  validates_presence_of :title
end
