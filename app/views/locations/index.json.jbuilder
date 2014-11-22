json.array!(@locations) do |location|
  json.extract! location, :id, :coordinates, :name
  json.url location_url(location, format: :json)
end
