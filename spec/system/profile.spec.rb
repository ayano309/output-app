require 'rails_helper'

RSpec.describe 'Profile', type: :system do
    let!(:user) { create(:user, :with_profile) }

    context 'ログインしている場合' do
        before do
            sign_in user
        end

        it '自分のプロフィールを確認できる' do
            visit profile_path
            expect(page).to have_css('.profilePage_user_displayName', text: user.profile.nickname)
        end
    end
end