class Photo < ActiveRecord::Base
  has_many :sounds
  acts_as_commentable
  mount_uploader :photo, PhotoUploader
end
