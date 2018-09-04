# 環境構築手順

## Dockerをインストールする
下記サイトよりDockerをインストールしてください。  
https://www.docker.com/products/docker-desktop

## Docker imageを取得する
```
$ docker pull ruby:2.5
$ docker pull mysql:5.7
```
## ソースコードをクローンして画像格納用ディレクトリをつくる
```
$ git clone https://github.com/nargok/photo_app.git
$ cd photo_app
$ mkdir public/images
```
## アプリケーションを立ち上げる
```
$ docker-compose run web bundle install --path vendor/bundle
$ docker-compose run web rake db:create
$ docker-compose run web rake db:migrate
$ docker-compose up -d
```

## テストユーザの作成
```
$ docker-compose run web rake db:seed
```

## 動作確認
ブラウザで、[http://localhost:3000](http://localhost:3000)にアクセスしてください。  
動作確認のため、以下2つのアカウントをお使い頂けます。

### テストユーザ1
- ユーザID  :  user1
- パスワード : password

### テストユーザ2
- ユーザID  :  user2
- パスワード : password