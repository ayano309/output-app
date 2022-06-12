require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/articles/index'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    it 'returns http success' do
      get '/articles/show'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /new' do
    it 'returns http success' do
      get '/articles/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /edit' do
    it 'returns http success' do
      get '/articles/edit'
      expect(response).to have_http_status(:success)
    end
  end
  let!(:user) { create(:user) }
  let!(:articles) { create_list(:article, 3, user: user) }

  describe 'GET /articles' do
    it '200ステータスが返ってくる' do
      get articles_path
      expect(response).to have_http_status(200)
    end
  end
  describe 'POST /articles' do
    context 'ログインしている場合' do
      before do
        sign_in user
      end

      it '記事が保存される' do
        article_params = attributes_for(:article)
        post articles_path({article: article_params})
        expect(response).to have_http_status(302)
        expect(Article.last.title).to eq(article_params[:title])
        expect(Article.last.content.body.to_plain_text).to eq(article_params[:content])
      end
    end
    context 'ログインしていない場合' do
      it 'ログイン画面に遷移する' do
        article_params = attributes_for(:article)
        post articles_path({article: article_params})
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
