class PhotoSound < ActiveRecord::Base
  belongs_to :photo
  belongs_to :sound
end