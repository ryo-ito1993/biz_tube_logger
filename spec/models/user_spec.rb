require 'rails_helper'

RSpec.describe User, type: :model do
  describe '必須カラムのvalidationの検証' do
    context '全必須カラムが指定されているとき' do
      let(:user) { build(:user) }
      it '正常にuserが登録される' do
        expect(user).to be_valid
      end
    end

    context 'ユーザーネームが指定されていないとき' do
      let(:user) { build(:user, name: nil) }
      it 'userの登録に失敗する' do
        expect(user).to be_invalid
        expect(user.errors[:name]).to eq ["can't be blank"]
      end
    end

    context 'メールアドレスが指定されていないとき' do
      let(:user) { build(:user, email: nil) }
      it 'userの登録に失敗する' do
        expect(user).to be_invalid
        expect(user.errors[:email]).to eq ["can't be blank"]
      end
    end

    context 'パスワードが指定されていないとき' do
      let(:user) { build(:user, password: nil) }
      it 'userの登録に失敗する' do
        expect(user).to be_invalid
        expect(user.errors[:password]).to eq ["is too short (minimum is 3 characters)"]
      end
    end

    context 'パスワード確認が指定されていないとき' do
      let(:user) { build(:user, password_confirmation: nil) }
      it 'userの登録に失敗する' do
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to eq ["can't be blank"]
      end
    end
  end

  describe 'パスワードの一致の検証' do
    context 'パスワードとパスワード確認が一致していないとき' do
      let(:user) { build(:user, password_confirmation: 'password1') }
      it 'userの登録に失敗する' do
        expect(user).to be_invalid
        expect(user.errors[:password_confirmation]).to eq ["doesn't match Password"]
      end
    end
  end

  describe '一意性の検証' do
    context 'メールアドレスが重複したとき' do
      let(:user1) { create(:user) }
      let(:user2) { build(:user, email: user1.email) }
      it 'userの登録に失敗する' do
        expect(user2).to be_invalid
        expect(user2.errors[:email]).to eq ["has already been taken"]
      end
    end
  end
end
