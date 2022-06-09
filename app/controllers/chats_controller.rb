class ChatsController < ApplicationController
  before_action :reject_non_related, only: [:show]
  def show
    #チャットするユーザーを取得
    @user = User.find(params[:id])
    #現在のユーザーの中間テーブルにあるroom_idの値の配列をroomsに代入
    rooms = current_user.user_rooms.pluck(:room_id)
    #中間テーブルから一致するチャット相手のユーザーidとroomsの配列の中のidが部屋にあるか確認
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
    #user_roomsが空でなければ
    unless user_rooms.nil?
      #@roomに中間モデルで一致した部屋を代入
      @room = user_rooms.room
    else
      #空なら新しく部屋を作る
      @room = Room.new
      @room.save
      #中間テーブルを現在のユーザーとチャット相手のユーザー分を作る
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end
    #部屋の中のチャット内容
    @chats = @room.chats
    #form_withでチャットを送信する際に必要な空のインスタンス
    #ここでroom.idを@chatに代入しておかないと、form_withで記述するroom_idに値が渡らない
    #新しいチャットを部屋の中で発信する
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save

  end

  private
  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end

  #相互フォローじゃなければ一覧画面へリダイレクト
  def reject_non_related
    user = User.find(params[:id])
    unless current_user.following?(user) && user.following?(current_user)
      redirect_to books_path
    end
  end
end
