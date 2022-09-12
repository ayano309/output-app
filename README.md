# 投稿サイトアプリ（OUTPUT）です。

![screencapture-localhost-3000-2022-06-19-13_50_24](https://user-images.githubusercontent.com/99533616/174467841-9585b6eb-f161-4d05-85ec-2999e37f4644.jpg)



# 主な機能

* User ログイン機能
* ゲストログイン機能
* プロフィール作成
* いいね登録
* コメント機能
* 記事投稿新しい順、古い順に切り替え
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
* 通知機能
* ブックマーク機能


# ER図

![out-put](https://user-images.githubusercontent.com/99533616/176590594-209dc8b1-dfbd-4601-8b7b-dc8d4c6b9ded.png)



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
* gem 'simplecov'

## その他
* ActiveStrage
* ActionText
