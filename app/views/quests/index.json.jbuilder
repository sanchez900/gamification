json.array!(@quests) do |quest|
  json.extract! quest, :id, :latitude, :longitude, :address, :description, :title
  json.url quest_url(quest, format: :json)
end
