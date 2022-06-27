# 投稿サイトアプリ（OUTPUT）です。

![screencapture-localhost-3000-2022-06-19-13_50_24](https://user-images.githubusercontent.com/99533616/174467841-9585b6eb-f161-4d05-85ec-2999e37f4644.jpg)

## なぜ制作したか
スクールで勉強していてスクール期間中に受講生同士で情報を共有したりすることがあまりありませんでした。
教えることが最大のアウトプットだと知りその手助けができるアプリを制作したくて作りました。
## サービス概要
自信がアウトプットした内容を記事にして投稿できる。

# 主な機能

* User ログイン機能
* ゲストログイン機能
* プロフィール作成
* いいね登録
* コメント機能
* いいねが多い順に表示
* いいね、コメント非同期
* タイムライン
* フォロー、フォロワー機能
* 検索機能
* DM機能
* ページ閲覧数表示
* 投稿数グラフ化
* グループ機能
* メール機能
* タグ機能
* お問い合わせ機能
* 通知機能


# ER図

![output_app ER図](https://user-images.githubusercontent.com/99533616/173549517-326e5cca-0294-4a26-a41a-828b7b3ab90c.jpeg)


# 使用技術
## バックエンド
 * Ruby 2.7.5p203 (2021-11-24 revision f69aeb8314) [arm64-darwin20]
 * Rails 6.1.5
 * Rubocop
## フロントエンド
* HTML
* CSS(SCSS)
* JavaScript(jQuery)
* bootstrap4

# 主な Gem
* gem 'devise'
* gem 'better_errors'
* gem 'binding_of_caller'
* gem 'pry-rails'
* gem 'annotate'
* gem 'rubocop-rails'
* gem 'rubocop'
* gem 'factory_bot_rails'
* gem 'faker'
* gem 'rspec-rails'
* gem 'dotenv-rails'
* gem 'impressionist'
* gem 'simple_calendar', '~> 2.0'
* gem 'redcarpet', '~> 2.3.0'  **マークダウン形式での表示**
* gem 'coderay'                **シンタックスハイライト対応**
* gem 'image_processing', '~> 1.2'

## その他
* ActiveStrage
* ActionText
