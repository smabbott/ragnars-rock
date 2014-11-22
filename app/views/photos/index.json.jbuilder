json.array!(@photos) do |photo|
  json.extract! photo, :id, :author, :location_id
  json.url photo_url(photo, format: :json)
end
