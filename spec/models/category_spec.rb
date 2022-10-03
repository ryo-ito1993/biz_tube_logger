require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '必須カラムのvalidationの検証' do
    context '全必須カラムが指定されているとき' do
      let(:category) { build(:category) }
      it '正常にcategoryが登録される' do
        expect(category).to be_valid
      end
    end

    context 'nameが空のとき' do
      let(:category) { build(:category, name: nil) }
      it 'エラーになる' do
        expect(category).to be_invalid
        expect(category.errors[:name]).to eq ["can't be blank"]
      end
    end
  end
end
