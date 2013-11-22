class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :votable, polymorphic: true #, counter_cache: true
  validates_uniqueness_of :user_id, scope: [:votable_id, :votable_type, :value]

end