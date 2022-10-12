RSpec.describe "Likes", type: :request do
  let(:like) { create(:like) }
  let(:output) { create(:output) }
  let(:user) { create(:user) }

  describe "POST /api/outputs/:output_id/likes" do
    it "いいねを追加できる" do
      output
      user
      token = login(user)
      post api_output_likes_path(output.id), params: {id: output.id}, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
      expect(Like.count).to eq(1)
    end
  end

  describe "DELETE /api/likes/:id" do
    it "いいねを削除できる" do
      like
      token = login(like.user)
      delete api_like_path(like.output.id), params: {id: like.output.id}, headers: { Authorization: "Bearer #{token}" }
      expect(response).to have_http_status(200)
      expect(Like.count).to eq(0)
    end
  end
end
