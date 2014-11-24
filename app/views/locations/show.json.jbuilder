json.extract! @location, :id, :coordinates, :name, :created_at, :updated_at
json.photos @location.photos do |photo|
  json.extract! photo, :id, :photo_url, :name, :description, :created_at, :updated_at
end
