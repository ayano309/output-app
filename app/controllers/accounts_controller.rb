class AccountsController < ApplicationController
  before_action :authenticate_user!
  def index
    if params[:keyword].present?
      @keyword = params[:keyword].strip
      @users = User.search_information(@keyword).display_list(params[:pages])
    else
      @keyword = ""
      @users = User.eager_load(profile: {avatar_attachment: :blob}).display_list(params[:page])
    end
  end
  
  def show
    @user = User.find(params[:id])
      if @user == current_user
        redirect_to profile_path
      end
  end
end
