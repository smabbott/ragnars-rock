class Location < ActiveRecord::Base
  has_many :photos
  has_many :sounds
  belongs_to :day

  def coordinates=(coords)
    self[:coordinates] = coords.class == String ? coords.gsub(/\(|\)/, '').split(', ') : coords
  end
end
