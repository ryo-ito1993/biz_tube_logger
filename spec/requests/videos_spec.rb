require 'rails_helper'

RSpec.describe "Videos", type: :request do
  let(:video) { create(:video) }
  let(:category) { create(:category) }
  let(:user) { create(:user) }

  describe "GET /api/videos" do
    it "投稿一覧を取得できる" do
      video
      get api_videos_path
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json[0]['title']).to eq(video.title)
      expect(json[0]['thumbnail']).to eq(video.thumbnail)
      expect(json[0]['view_count']).to eq(video.view_count)
    end
  end

  describe "GET /api/videos/display_videos" do
    it "投稿一覧を取得できる" do
      video
      get display_videos_api_videos_path
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json[0]['title']).to eq(video.title)
      expect(json[0]['thumbnail']).to eq(video.thumbnail)
      expect(json[0]['view_count']).to eq(video.view_count)
    end
  end

  describe "POST /api/videos" do
    it "videoを追加できる" do
      user
      category
      token = login(user)
      post api_videos_path, params: { youtube_id: "z9EUo-T5v6Q", selected_categories: ["仕事"], output: {summary: "aaa", impression: "bbb"}} , headers: { Authorization: "Bearer #{token}" }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(Video.count).to eq(1)
      expect(Output.count).to eq(1)
      expect(json[0]['title']).to eq(Video.first.title)
      expect(json[0]['thumbnail']).to eq(Video.first.thumbnail)
      expect(json[0]['view_count']).to eq(Video.first.view_count)
      expect(json[1]['summary']).to eq(Output.first.summary)
      expect(json[1]['impression']).to eq(Output.first.impression)
    end
  end

  describe "/api/videos/:id" do
    it "video詳細を取得できる" do
      video
      get api_video_path(video.id)
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json[0]['title']).to eq(video.title)
      expect(json[0]['thumbnail']).to eq(video.thumbnail)
      expect(json[0]['view_count']).to eq(video.view_count)
    end
  end
end