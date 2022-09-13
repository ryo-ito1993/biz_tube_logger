json.array! @videos do |video|
  json.id video.id
  json.title video.title
  json.thumbnail video.thumbnail
  json.view_count video.view_count
  json.created_at video.created_at
  json.user_name video.user.name
  json.output_name video.outputs do |output|
    json.output_name output.user.name
  end
end
