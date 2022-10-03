require 'rails_helper'

RSpec.describe VideoCategory, type: :model do
  describe '必須カラムのvalidationの検証' do
    context '全必須カラムが指定されているとき' do
      let(:video_category) { build(:video_category) }
      it '正常にvideo_categoryが登録される' do
        expect(video_category).to be_valid
      end
    end
  end

  describe '一意性の検証' do
    context '同一ビデオに同一のカテゴリーが登録されたとき' do
      let(:video_category1) { create(:video_category) }
      let(:video_category2) { build(:video_category, video_id: video_category1.video_id, category_id: video_category1.category_id) }
      it '登録に失敗する' do
        expect(video_category2).to be_invalid
        expect(video_category2.errors[:video_id]).to eq ["has already been taken"]
      end
    end
  end
end
