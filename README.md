# Description

Pythonの実行環境をDockerで構築する試み。

* Dockerfileにて必要となるpythonモジュールをpipでインストール
  * Python3.xを前提にしている
* `docker run` のラッパースクリプトとして、run.shを用意
* run.shの中で以下を考慮
  * カレントディレクトリをdocker側でマウント
  * ワーキングディレクトリを指定
  * 必要な環境変数を`envfile.env`から参照する

# usage

    $ docker build -t pythondocker .
    $ ./run.sh pythondocker bash -c 'cat latlng.csv | ./rev_geocd_latlngtopostalcd.py'

パイプを利用してつないでいるので、`bash -c`にてコマンドを実行している。