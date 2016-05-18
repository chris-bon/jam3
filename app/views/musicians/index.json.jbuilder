json.array!(@musicians) do |musician|
  json.extract! musician, :id
  json.url musician_url(musician, format: :json)
end
