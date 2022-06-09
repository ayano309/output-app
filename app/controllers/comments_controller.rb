class CommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @article = Article.find(params[:article_id])
    @comment = current_user.comments.new(comment_params)
    @comment.article_id = @article.id
    unless @comment.save
      render 'error'  #comments/error.js.erbを参照する
    end
      # redirect_to request.referer
      #comments/create.js.erbを参照する
  end

  def destroy
    @article = Article.find(params[:article_id])
    comment = @article.comments.find(params[:id])
    comment.destroy
    # redirect_to request.referer
    #comments/destroy.js.erbを参照する
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
