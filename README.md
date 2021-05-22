# Quartet

気軽にできる合コンマッチングサービス。<br>
男女に新たな出会いの場を提供します。<br><br>
URL: [Quartet〜新たな出会いへ〜](https:quartet-plan.com)

![README_image](https://user-images.githubusercontent.com/62461394/119217950-a8c4a180-bb18-11eb-8bef-ed33aba04f68.png)

## 使用技術
- Ruby 2.6.6
- Ruby on Rails 6.0.3
- MySQL 8.0
- Docker/Docker-compose
- Nginx
- Unicorn
- jQuery
- AWS
  - VPC
  - EC2
  - RDS(MySQL)
  - S3
  - Route53
  - Certificate Manager
  - Elastic Load Balancing
- GitHub
- Editor
  - vim
  - Visual Studio Code

## AWS構成図

![AWSインフラ図](https://user-images.githubusercontent.com/62461394/119219595-49b75a80-bb21-11eb-9fcc-4990191e215a.png)

- SSL証明書を発行し、HTTP 化を実装

## 機能一覧
- ユーザー認証機能
  - **FacebookAPIを用いたOAuth認証**
  - **Twiloを用いたSMS認証**
- メッセージ自動更新
  - **Ajaxを活用したメッセージ送信や自動更新**
- モジュールバンドルとしてWebpackを採用
  - **制約が多いWebpackerを取り除き、webpackでJavaScriptやCSS、画像を管理**
- ユーザー登録・ログイン(devise)
- タグ付け機能(acts-as-taggable-on)
  - タグをDB上でカテゴリー化(ancestry)
- プラン検索機能(ransack)
- ページネーション機能(kaminari)
- メッセージルームの論理削除(discard)
- Bootstrapのグリッドレイアウトを採用
- Sassの使用
- サンプルデータ作成(faker)
