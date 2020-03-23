# Description

Pythonの実行環境をDockerで構築する試み。

* Python3.xを前提にした実行環境

# Usage

## Visual Studio Code - Remote Developmentを利用する場合（簡単なのでおすすめ）

1. VSCodeで、このフォルダを開く
2. コンテナを起動して接続した上で、VSCodeが開く
3. 統合ターミナルなどを起動して、コンテナ上でPythonスクリプト開発


## コマンドラインでDockerを起動して開発する場合

1. `.env.template`ファイルを`.env`に変更してファイル内容を書き換える
   * `docker-compose.yml`内の`container_name`、`working_dir`、`volumes`を変数化するために利用している
   * 変数化が必要なければ、`docker-compose.yml`に直接書けばよい
2. コンテナを立ち上げ
3. コンテナに入る
4. スクリプトを実行する

        $ mv .env.template .env
        $ code .env
        $ docker-compose up -d --build
        $ docker-compose exec python3 bash
        $ cat latlng.csv | ./rev_geocd_latlngtopostalcd.py 

# Structure

```
python-docker
├── Dockerfile
├── docker-compose.yml
├── .env.template :.envにrenameして利用する
├── envfile.env.template :envfile.envにrenameして利用する
└── rev_geocd_latlngtopostalcd.py :サンプルスクリプト
```

* `rev_geocd_latlngtopostalcd.py`は以前作成した、緯度経度から郵便番号を割り出すためのスクリプト。Google Maps APIを利用して、リバースジオコーディングをしている。
  * API利用にあたり、`docker-compose.yml`内の`env_file`オプションでAPIキーの環境変数を読み込み、コンテナに渡している

私が書くスクリプトではよく環境変数を利用してこうしたキー渡しをするので、このような構成とした。

# reference
- [dockerで簡易にpython3の環境を作ってみる - Qiita](https://qiita.com/reflet/items/4b3f91661a54ec70a7dc)
- [Compose における環境変数 | Docker ドキュメント](https://matsuand.github.io/docs.docker.jp.onthefly/compose/environment-variables/)
