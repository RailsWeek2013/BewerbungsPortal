json.array!(@works) do |work|
  json.extract! work, 
  json.url work_url(work, format: :json)
end
