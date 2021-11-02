# 👮‍♂️プルリク警察

このアクションはリリースブランチに対しての変更を検知して、開発ブランチまでその変更を反映させるプルリクを作成します。

## Inputs

## `repo`
**Required** リポジトリ名。  
デフォルトはアクションを実行したリポジトリ。

## `token`
**Required** トークン。  
デフォルトはアクションを実行したリポジトリで取得したトークン。

## `current_branch`
**Required** マージされたリリースブランチ。  
デフォルトはアクションが実行されたブランチ。

## `release_branch_regexp`
**Required** リリースブランチ検索用正規表現。  
デフォルトは`^release-\d+\.\d+\.\d+\.\d+$`

## `pr_title`
**Required** プルリクのタイトル。  
デフォルトは`リリースブランチの変更を検知しました`

## `pr_body`
プルリクの本文。

## 使用例

```yml
on:
  pull_request:
    branches:
      - '^release-\d+\.\d+\.\d+\.\d+$'
    types: [closed]

jobs:
  pullreq_police:
    runs-on: ubuntu-latest
    if: github.event.pull_request.merged == true
    name: pullreq police
    steps:
      - name: Extract branch name
        shell: bash
        run: echo "::set-output name=branch::${GITHUB_REF#refs/heads/}"
        id: extract_branch
      - name: pullreq_police
        id: pullreq_police
        uses: rhiroe/pullreq_police@v1
        with:
          release_branch_regexp: '^release-\d+\.\d+\.\d+\.\d+$'
          pr_title: 'リリースブランチの変更を検知しました'
          pr_body: '速やかにマージしてください。'
```