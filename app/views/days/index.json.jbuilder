json.array!(@days) do |day|
  json.extract! day, :id, :date, :path
  json.url day_url(day, format: :json)
end
