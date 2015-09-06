json.array!(@users) do |user|
  json.extract! user, :id, :name, :starting_date
  json.url user_url(user, format: :json)
end
