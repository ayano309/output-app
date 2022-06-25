class EventNoticesController < ApplicationController
  #メール新規フォーム
  def new
    @group = Group.find(params[:group_id])
  end

  #フォームの内容を受け取る
  def create
    #フォームからgroup_idとtitle,bodyを受け取る
    @group = Group.find(params[:group_id])
    @title = params[:title]
    @body = params[:body]

    #受け取った値をハッシュに
    event = {
      :group => @group,
      :title => @title,
      :body => @body

    }

    #EventMailer.rbにハッシュを送る
    EventMailer.send_notifications_to_group(event)
    #送信後の確認画面へ
    render :sent
  end

  #groupの詳細画面へリダイレクト
  def sent
    redirect_to group_path(params[:group_id])
  end
end
