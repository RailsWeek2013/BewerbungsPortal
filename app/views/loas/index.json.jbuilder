json.array!(@loas) do |loa|
  json.extract! loa, :to, :street, :city, :zip, :subject, :what, :profile_id
  json.url loa_url(loa, format: :json)
end
