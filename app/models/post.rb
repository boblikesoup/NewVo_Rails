class Post < ActiveRecord::Base
    belongs_to :user
    has_many :comments, :dependent => :destroy
    has_many :photos, :dependent => :destroy
    has_many :votes, :as => :votable, :dependent => :destroy
    accepts_nested_attributes_for :photos, :reject_if => lambda { |attributes| attributes[:photo].blank? }

    validates_presence_of :title
    validates_presence_of :user_id
    validates_presence_of :single
end
