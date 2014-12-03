json.extract! @location, :id, :coordinates, :name, :created_at, :updated_at
json.photos @location.photos do |photo|
  json.id photo.id 
  json.src photo.photo.thumb_wide.url
  json.created_at photo.created_at
  json.updated_at photo.updated_at
end
json.sounds @location.sounds do |sound|
  json.id sound.id
  json.name
end

