require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  let(:user) { create(:user) }

  describe "POST /api/sessions" do
    context "パラメーターが正常の場合" do
      it "ログインに成功する" do
        post api_sessions_path(params: { email: user.email, password: "password" })
        expect(response).to have_http_status(200)
      end
    end

    context "メールアドレスが空の場合" do
      it "ログインに失敗する" do
        user
        post api_sessions_path(params: { email: "", password: "password" })
        expect(response).to have_http_status(401)
      end
    end

    context "登録されていないメールアドレスの場合" do
      it "ログインに失敗する" do
        user
        post api_sessions_path(params: { email: "spec_test@example.com", password: "password" })
        expect(response).to have_http_status(401)
      end
    end

    context "登録されていないパスワードの場合" do
      it "ログインに失敗する" do
        post api_sessions_path(params: { email: user.email, password: "testpassword" })
        expect(response).to have_http_status(401)
      end
    end
  end
end
