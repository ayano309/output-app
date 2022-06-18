require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'モデルのテスト' do
    it "有効なtagの場合は保存されるか" do
      expect(build(:tag)).to be_valid
    end

    context 'nameカラム' do
      it "11文字以上のタグは保存されない" do
        tag = create(:tag)
        tag.name = Faker::Lorem.characters(number: 11)
        tag.valid?
        expect(tag.valid?).to eq false
      end
    end
  end
end