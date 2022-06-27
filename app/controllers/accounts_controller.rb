class AccountsController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.eager_load(profile: {avatar_attachment: :blob}).display_list(params[:page])
  end
  def show
    @user = User.find(params[:id])
      if @user == current_user
        redirect_to profile_path
      end
  end
end
