class Post < ActiveRecord::Base
    has_attached_file :picture1, :styles => { :medium => "300x300>", :thumb => "100x100>" }
end