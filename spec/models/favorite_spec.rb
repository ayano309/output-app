require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'favoriteモデルのテスト' do
    it "有効なfavoriteの場合は保存されるか" do
      expect(build(:favorite)).to be_valid
    end
  end
end