json.array!(@educations) do |education|
  json.extract! education, 
  json.url education_url(education, format: :json)
end
