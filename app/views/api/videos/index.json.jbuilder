json.array! @videos do |video|
  json.id video.id
  json.title video.title
  json.thumbnail video.thumbnail
  json.view_count video.view_count
  json.created_at video.created_at
  json.categories video.categories do |category|
    json.name category.name
  end
  json.video_comments @video_comments
  json.video_likes @video_likes
end
