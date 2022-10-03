require 'rails_helper'

RSpec.describe Output, type: :model do
  describe '必須カラムのvalidationの検証' do
    context '全必須カラムが指定されているとき' do
      let(:output) { build(:output) }
      it '正常にvideoが登録される' do
        expect(output).to be_valid
      end
    end

    context 'summaryが空のとき' do
      let(:output) { build(:output, summary: nil) }
      it 'エラーになる' do
        expect(output).to be_invalid
        expect(output.errors[:summary]).to eq ["can't be blank"]
      end
    end

    context 'impressionが空のとき' do
      let(:output) { build(:output, impression: nil) }
      it 'エラーになる' do
        expect(output).to be_invalid
        expect(output.errors[:impression]).to eq ["can't be blank"]
      end
    end
  end
end
