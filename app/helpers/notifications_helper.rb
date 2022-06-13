module NotificationsHelper
  def notification_form(notification)
    @visiter = notification.visiter
    @comment = nil
    your_article = link_to 'あなたの投稿', article_path(notification), style:"font-weight: bold;"
    @visiter_comment = notification.comment_id
    #notification.actionがfollowかlikeかcommentか
    case notification.action
      when "follow" then
        tag.a(notification.visiter.name, href:account_path(@visiter), style:"font-weight: bold;")+"があなたをフォローしました"
      when "like" then
        tag.a(notification.visiter.name, href:account_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:article_path(notification.article_id), style:"font-weight: bold;")+"にいいねしました"
      when "comment" then
          @comment = Comment.find_by(id: @visiter_comment)&. comment
          tag.a(@visiter.name, href:account_path(@visiter), style:"font-weight: bold;")+"が"+tag.a('あなたの投稿', href:article_path(notification.article_id), style:"font-weight: bold;")+"にコメントしました"
    end
  end

  def unchecked_notifications
    @notifications = current_user.passive_notifications.where(checked: false)
  end
end
