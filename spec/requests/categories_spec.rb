require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let!(:category) { create(:category) }

  describe "GET /api/categories" do
    it "カテゴリー一覧を取得できる" do
      get api_categories_path
      json = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(json[0]['name']).to eq(category.name)
    end
  end
end