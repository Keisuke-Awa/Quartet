# Quartet

気軽に男女が出会うための合コンマッチングサービス。<br><br>
URL: [Quartet〜新たな出会いへ〜](https:quartet-plan.com)

![README_image](https://user-images.githubusercontent.com/62461394/119217950-a8c4a180-bb18-11eb-8bef-ed33aba04f68.png)

## 使用技術
- Ruby 2.6.6
- Ruby on Rails 6.0.3
- MySQL 8.0
- Docker/Docker-compose
- Nginx
- Unicorn
- webpack 4
- jQuery
- Bootstrap 4
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
- ユーザー登録、ログイン機能(devise)
- OAuth認証機能(facebookAPI)
- SMS認証機能(twilio)
- プラン作成機能
  - タグ機能(acts-as-taggable-on)
    - カテゴリ機能(ancestry)
- プラン検索機能(ransack)
  - ページネーション機能(kaminari)
- メッセージ機能(Ajax)
  - メッセージルーム削除機能(discard)
- サンプルデータ作成(faker)

## 機能一覧
