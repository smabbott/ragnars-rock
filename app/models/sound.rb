class Sound < ActiveRecord::Base
  has_many :photos
  acts_as_commentable
end
