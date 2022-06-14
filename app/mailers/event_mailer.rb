class EventMailer < ApplicationMailer
  #下のメソッドで送られてくるevent={:group, :title, :body}
  def send_notification(member, event)
    @group = event[:group]
    @title = event[:title]
    @body = event[:body]
    
    @mail = EventMailer.new()

    mail(
      from: ENV['SMTP_USERNAME'],
      to:   member.email,
      subject: '勉強会始まるよ'
    )
  end

  #まずコントローラーからこちらのメソッドに飛ぶ
  def self.send_notifications_to_group(event)
    #event={:group, :title, :body}
    group = event[:group]
    #groupのメンバー１人１人にメールを送る
    group.users.each do |member|
    #上のメソッドにgroupのuserとeventのハッシュを送って返ってきたものをメールで送る。
      EventMailer.send_notification(member, event).deliver_now
    end
  end
  
end