RSpec.describe "Bookmark", type: :request do
  let(:bookmark) { create(:bookmark) }
  let(:video) { create(:video) }
  let(:user) { create(:user) }

  describe "GET /api/bookmarks" do
    it "ログインユーザーのブックマーク一覧を取得できる" do
      bookmark
      user
      token = login(bookmark.user)
      get api_bookmarks_path, headers: { Authorization: "Bearer #{token}" }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json[0]['id']).to eq(Bookmark.first.video.id)
    end
  end

  describe "GET /api/bookmarks/bookmark_list" do
    it "ログインユーザーのブックマーク一覧を取得できる" do
      bookmark
      user
      token = login(bookmark.user)
      get bookmark_list_api_bookmarks_path, headers: { Authorization: "Bearer #{token}" }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json[0]['id']).to eq(Bookmark.first.video.id)
    end
  end

  describe "POST /api/videos/:video_id/bookmarks" do
    it "ブックマークを追加できる" do
      video
      user
      token = login(user)
      post api_video_bookmarks_path(video.id), params: {id: video.id}, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
      expect(Bookmark.count).to eq(1)
    end
  end

  describe "DELETE /api/bookmarks/:id" do
    it "ブックマークを削除できる" do
      bookmark
      token = login(bookmark.user)
      delete api_bookmark_path(bookmark.video.id), params: {id: bookmark.video.id}, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
      expect(Bookmark.count).to eq(0)
    end
  end
end
