require 'rails_helper'

RSpec.describe Bookmark, type: :model do
  describe '必須カラムのvalidationの検証' do
    context '全必須カラムが指定されているとき' do
      let(:bookmark) { build(:bookmark) }
      it '正常にbookmarkが登録される' do
        expect(bookmark).to be_valid
      end
    end
  end

  describe '一意性の検証' do
    context '同一ユーザーが同一のポストに対し複数のブックマークをしたとき' do
      let(:bookmark1) { create(:bookmark) }
      let(:bookmark2) { build(:bookmark, user_id: bookmark1.user_id, video_id: bookmark1.video_id) }
      it 'ブックマークに失敗する' do
        expect(bookmark2).to be_invalid
        expect(bookmark2.errors[:user_id]).to eq ["has already been taken"]
      end
    end
  end
end
