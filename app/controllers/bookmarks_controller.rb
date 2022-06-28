class BookmarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @articles = current_user.bookmarked_articles
  end

  def create
    @article = Article.find(params[:article_id])
    @bookmark = current_user.bookmarks.new(article_id: @article.id)
    @bookmark.save
  end

  def destroy
    @article = Article.find(params[:article_id])
    @bookmark = current_user.bookmarks.find_by(article_id: @article.id)
    @bookmark.destroy
  end
end
