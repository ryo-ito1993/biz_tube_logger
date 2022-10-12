require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /api/users" do
    context "パラメーターが正常" do
      it "ユーザー登録に成功する" do
        post api_users_path(params: { user: { name: "test1", email: "test@example.com", password: "password", password_confirmation: "password" } })
        expect(response).to have_http_status(200)
        expect(1).to eq(User.count)
      end
    end

    context "名前とメールアドレスが空の場合" do
      it "ユーザー登録に失敗する" do
        post api_users_path(params: { user: { name: "", email: "", password: "password", password_confirmation: "password" } })
        expect(response).to have_http_status(400)
        expect(0).to eq(User.count)
      end
    end

    context "パスワードとパスワード(確認)が空の場合" do
      it "ユーザー登録に失敗する" do
        post api_users_path(params: { user: { name: "test1", email: "test@example.com", password: "", password_confirmation: "" } })
        expect(response).to have_http_status(400)
        expect(0).to eq(User.count)
      end
    end
  end
end