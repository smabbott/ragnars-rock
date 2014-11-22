class Location < ActiveRecord::Base
  has_many :photos
  has_many :sounds
  belongs_to :day
end
