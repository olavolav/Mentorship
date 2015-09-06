json.array!(@developers) do |developer|
  json.extract! developer, :id, :name, :starting_date
  json.url developer_url(developer, format: :json)
end
