class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  impressionist :actions=> [:show]
  def index
    if sort_params.present?
      @sorted = params[:sort]
      @articles = Article.preload(:user).sort_articles(sort_params, params[:page])
    else
      @articles = Article.preload(:user).display_list(params[:page])
    end
    @tags = Tag.last(10)
    @sort_list = Article.sort_list
  end

  def show
    @user = @article.user
    @comment = Comment.new
    impressionist(@article, nil, unique: [:session_hash])
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    tag_list = params[:article][:tag_name].split(',')
    if @article.save
      @article.save_tags(tag_list)
      redirect_to article_path(@article), notice: '保存できたよ'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
  end

  def edit
    @article = current_user.articles.find(params[:id])
    @tag_list=@article.tags.pluck(:name).join(',')
  end

  def update
    @article = current_user.articles.find(params[:id])
    tag_list = params[:article][:tag_name].split(',')
    if @article.update(article_params)
      #紐づいていたタグを@oldrelationsに入れる
      @old_relations=ArticleTag.where(article_id: @article.id)
      #それらを取り出し、全部消す
      @old_relations.each do |relation|
        relation.delete
      end
      @article.save_tags(tag_list)
    redirect_to article_path(@article), notice: '更新できました'
    else
    flash.now[:error] = '更新できませんでした'
    render :edit
    end
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy!
    redirect_to root_path, notice: '削除に成功しました'
  end

  private
  def article_params
      params.require(:article).permit(:title, :content, :subcontent, :image)
  end

  def set_article
      @article = Article.find(params[:id])
  end

  def sort_params
    params.permit(:sort)
  end
end
