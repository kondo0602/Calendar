# :calendar: 週間カレンダー

<img width="1680" alt="スクリーンショット 2021-02-24 16 21 40" src="https://user-images.githubusercontent.com/73473550/108962970-d7b7ac80-76bc-11eb-8701-86713b63e7ad.png">

Ruby on Railsにて15分刻みのカレンダーを作成しました。

自分は30分刻みの手帳を使用していますが、30分に満たない予定は案外多く、兼ねてよりあったらいいなと思っていたものです！

## 機能
* 予定一覧機能
* 予定追加機能
* 予定編集機能
* 予定削除機能
* 自動テスト機能(RSpec)

## アピールできるポイント
既存のgemファイル（simple_calendar）を活用しつつ、
gemファイルに含まれているメソッドやパラメータの意味を読み解き、アレンジを加えることができた点です。

## ユーザエクスペリエンスを考えた点
必要だと考えた最低限の機能はつけつつも「使用方法を説明しなくても直感的に使えること」を重視しました。
項目名やエラーメッセージについてもわかりやすい和訳を検討しどういうエラー内容なのかがわかりやすいようにしました。

## 動作確認
ローカルにて動作させることを想定しています。
```markdown:README.md
$ git clone https://github.com/kondo0602/Calendar
$ cd Calendar
$ bundle install
$ rails db:create
$ rails db:migrate
$ rails s
$ http://localhost:3000
```
