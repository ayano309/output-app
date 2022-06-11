class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only:[:edit, :update]

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end


  def create
    @group = Group.new(group_params)
    #groupの作成者のIDを代入する
    @group.owner_id = current_user.id

    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end


  def edit
    @group = Group.find(params[:id])
  end


  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to groups_path
    else
      render :edit
    end

  end


  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end

  def correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end
end	