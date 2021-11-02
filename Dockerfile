# コードを実行するコンテナイメージ
FROM ruby:3.0.1

# アクションのリポジトリからコードファイルをコピー
WORKDIR /pullreq_police
COPY Gemfile /pullreq_police/Gemfile
COPY Gemfile.lock /pullreq_police/Gemfile.lock
COPY main.rb /pullreq_police/main.rb
COPY entrypoint.sh /pullreq_police/entrypoint.sh

# dockerコンテナが起動する際に実行されるコードファイル (`entrypoint.sh`)
ENTRYPOINT ["/pullreq_police/entrypoint.sh"]
