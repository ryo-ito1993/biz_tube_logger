json.array! @videos do |video|
  json.id video.id
  json.title video.title
  json.thumbnail video.thumbnail
  json.view_count video.view_count
  json.created_at video.created_at
  json.user_id video.user_id
  json.categories video.categories do |category|
    json.name category.name
  end
  json.outputs video.outputs do |output|
    json.created_at output.created_at
    json.comments_count output.comments.count
    json.likes_count output.likes.count
  end
end
