json.array!(@urls) do |url|
  json.extract! url, :id, :Url
  json.url url_url(url, format: :json)
end
