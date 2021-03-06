class TimelinesController < ApplicationController
  before_action :authenticate_user!
  def show
    user_ids = current_user.followings.pluck(:id)
    @articles = Article.preload(:user).where(user_id:user_ids).display_list(params[:page])
  end
end
