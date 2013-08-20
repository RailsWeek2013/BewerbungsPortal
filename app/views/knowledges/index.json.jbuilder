json.array!(@knowledges) do |knowledge|
  json.extract! knowledge, :name, :desc
  json.url knowledge_url(knowledge, format: :json)
end
