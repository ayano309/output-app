class Notification < ApplicationRecord
  #スコープ(新着順)
  default_scope->{order(created_at: :desc)}

  #optional: trueはarticle_idにnilを許容する
  #railsで自動的にallow_nil: falseが付与されるため。フォロー通知ではarticle_idは関与しないためnilとなるからこのオプションをつけないとフォロー通知が有効にならない。
  belongs_to :article, optional: true
  belongs_to :comment, optional: true

  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true

  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

end
