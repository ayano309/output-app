class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @articles = @user.articles

    @this_week_article = @articles.created_this_week
    @last_week_article = @articles.created_last_week
  end
end
