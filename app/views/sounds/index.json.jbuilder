json.array!(@sounds) do |sound|
  json.extract! sound, :id, :name, :author, :location_id
  json.url sound_url(sound, format: :json)
end
