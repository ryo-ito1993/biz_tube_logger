RSpec.describe "Comments", type: :request do
  let(:comment) { create(:comment) }
  let(:output) { create(:output) }
  let(:user) { create(:user) }

  describe "POST /api/comments" do
    it "コメントを追加できる" do
      output
      user
      token = login(user)
      post api_comments_path, params: {comment: {body: 'aaa', output_id: output.id}}, headers: { Authorization: "Bearer #{token}" }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(Comment.count).to eq(1)
      expect(json['comments'][0]['body']).to eq(Comment.first.body)
    end
  end

  describe "PATCH /api/comments/:id" do
    it "コメントを更新できる" do
      comment
      token = login(comment.user)
      patch api_comment_path(comment.id), params: {comment: {body: 'aaa', output_id: comment.output.id}}, headers: { Authorization: "Bearer #{token}" }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(Comment.count).to eq(1)
      expect(json['comments'][0]['body']).to eq(Comment.first.body)
    end
  end

  describe "DELETE /api/comments/:id" do
    it "コメントを削除できる" do
      comment
      token = login(comment.user)
      delete api_comment_path(comment.id), headers: { Authorization: "Bearer #{token}" }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(Comment.count).to eq(0)
    end
  end
end