# コードを実行するコンテナイメージ
FROM ruby:3.0.1

# アクションのリポジトリからコードファイルをコピー
COPY Gemfile /pullreq_police/Gemfile
COPY Gemfile.lock /pullreq_police/Gemfile.lock
COPY pullreq.rb /pullreq_police/pullreq.rb
COPY entrypoint.sh /pullreq_police/entrypoint.sh

# dockerコンテナが起動する際に実行されるコードファイル (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
