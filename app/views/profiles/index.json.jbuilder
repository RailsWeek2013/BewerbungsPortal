json.array!(@profiles) do |profile|
  json.extract! profile, :firstName, :name, :birthday, :address_id, :marialStatus, :telefon
  json.url profile_url(profile, format: :json)
end
