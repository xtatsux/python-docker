# Description

Pythonの実行環境をDockerで構築する試み。

* Python3.xを前提にした実行環境

# usage

* `.env.template`ファイルを`.env`に変更してファイル内容を書き換える。
  * `docker-compose.yml`内の`container_name`、`working_dir`、`volumes`を変数化するために利用している
  * 変数化が必要なければ、`docker-compose.yml`に直接書けばよい

    $ mv .env.template .env

* コンテナを立ち上げ

    $  docker-compose up -d --build

* コンテナに入る

    $  docker-compose exec python3 bash

* スクリプトを実行する

    $  cat latlng.csv | ./rev_geocd_latlngtopostalcd.py 

# Structure

```
python-docker
├── Dockerfile
├── docker-compose.yml
├── .env.template :.envにrenameして利用する
├── envfile.env.template :envfile.envにrenameして利用する
└── rev_geocd_latlngtopostalcd.py :サンプルスクリプト
```

`rev_geocd_latlngtopostalcd.py`は以前作成した、緯度経度から郵便番号を割り出すためのスクリプト。
Google Maps APIを利用して、リバースジオコーディングをしている。
API利用にあたり、`docker-compose.yml`内の`env_file`オプションでAPIキーの環境変数を読み込み、コンテナに渡している。
私が書くスクリプトではよく環境変数を利用してこうしたキー渡しをするので、このような構成とした。

# reference
- [dockerで簡易にpython3の環境を作ってみる - Qiita](https://qiita.com/reflet/items/4b3f91661a54ec70a7dc)
- [Compose における環境変数 | Docker ドキュメント](https://matsuand.github.io/docs.docker.jp.onthefly/compose/environment-variables/)
