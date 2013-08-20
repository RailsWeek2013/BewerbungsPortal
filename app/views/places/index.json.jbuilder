json.array!(@places) do |place|
  json.extract! place, :time_start, :time_end, :desc, :type
  json.url place_url(place, format: :json)
end
