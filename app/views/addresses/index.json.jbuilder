json.array!(@addresses) do |address|
  json.extract! address, :street, :zip, :city, :user_id
  json.url address_url(address, format: :json)
end
