require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '必須カラムのvalidationの検証' do
    context '全必須カラムが指定されているとき' do
      let(:comment) { build(:comment) }
      it '正常にコメントが登録される' do
        expect(comment).to be_valid
      end
    end

    context 'コメントが入力されていないとき' do
      let(:comment) { build(:comment, body: nil) }
      it 'コメントの登録に失敗する' do
        expect(comment).to be_invalid
        expect(comment.errors[:body]).to eq ["can't be blank"]
      end
    end
  end
end
