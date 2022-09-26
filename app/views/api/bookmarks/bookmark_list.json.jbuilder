json.array! @bookmarks do |video|
  json.id video.id
  json.title video.title
  json.thumbnail video.thumbnail
  json.view_count video.view_count
  json.created_at video.created_at
  json.user_name video.user.name
  json.outputs video.outputs do |output|
    json.name output.user.name
    json.comments output.comments.length
  end
  json.categories video.categories do |category|
    json.name category.name
  end
  json.video_comments @video_comments
  json.video_likes @video_likes
end
