require 'rails_helper'

RSpec.describe Video, type: :model do
  describe '必須カラムのvalidationの検証' do
    context '全必須カラムが指定されているとき' do
      let(:video) { build(:video) }
      it '正常にvideoが登録される' do
        expect(video).to be_valid
      end
    end

    context 'youtube_idが空のとき' do
      let(:video) { build(:video, youtube_id: nil) }
      it 'エラーになる' do
        expect(video).to be_invalid
        expect(video.errors[:youtube_id]).to eq ["can't be blank"]
      end
    end

    context 'titleが空のとき' do
      let(:video) { build(:video, title: nil) }
      it 'エラーになる' do
        expect(video).to be_invalid
        expect(video.errors[:title]).to eq ["can't be blank"]
      end
    end

    context 'view_countが空のとき' do
      let(:video) { build(:video, view_count: nil) }
      it 'エラーになる' do
        expect(video).to be_invalid
        expect(video.errors[:view_count]).to eq ["can't be blank"]
      end
    end

    context 'published_atが空のとき' do
      let(:video) { build(:video, published_at: nil) }
      it 'エラーになる' do
        expect(video).to be_invalid
        expect(video.errors[:published_at]).to eq ["can't be blank"]
      end
    end

    context 'thumbnailが空のとき' do
      let(:video) { build(:video, thumbnail: nil) }
      it 'エラーになる' do
        expect(video).to be_invalid
        expect(video.errors[:thumbnail]).to eq ["can't be blank"]
      end
    end
  end
end
