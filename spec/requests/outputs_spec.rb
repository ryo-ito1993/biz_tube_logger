RSpec.describe "Outputs", type: :request do
  let(:output) { create(:output) }
  let(:user) { create(:user) }

  describe "GET /api/output/:id" do
    it "アウトプット詳細を取得できる" do
      output
      get api_output_path(output.video.id)
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json[0]['summary']).to eq(output.summary)
      expect(json[0]['impression']).to eq(output.impression)
    end
  end

  describe "POST /api/outputs" do
    it "アウトプットを追加できる" do
      output
      user
      token = login(user)
      post api_outputs_path, params: {output: {summary: 'aaa', impression: 'bbb', video_id: output.video.id}}, headers: { Authorization: "Bearer #{token}" }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(Output.count).to eq(2)
      expect(json['summary']).to eq(Output.last.summary)
      expect(json['impression']).to eq(Output.last.impression)
    end
  end

  describe "PATCH /api/outputs/:id" do
    it "アウトプットを更新できる" do
      output
      token = login(output.user)
      patch api_output_path(output.id), params: {output: {summary: 'aaa', impression: 'bbb'}}, headers: { Authorization: "Bearer #{token}" }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(Output.count).to eq(1)
      expect(json['summary']).to eq(Output.first.summary)
      expect(json['impression']).to eq(Output.first.impression)
    end
  end

  describe "DELETE /api/outputs/:id" do
    it "アウトプットを削除できる" do
      output
      token = login(output.user)
      delete api_output_path(output.id), headers: { Authorization: "Bearer #{token}" }
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(Output.count).to eq(0)
    end
  end
end