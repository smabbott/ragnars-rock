class Photo < ActiveRecord::Base
  has_many :sounds
  acts_as_commentable
end
