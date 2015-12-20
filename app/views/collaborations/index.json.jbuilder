json.array!(@collaborations) do |collaboration|
  json.extract! collaboration, :id
  json.url collaboration_url(collaboration, format: :json)
end
