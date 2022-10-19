# BizTubeLogger

## ■サービスURL
https://www.biztube-logger.com/

## ■サービス概要
&emsp;ビジネス系youtubeの内容をアウトプットして記録管理、共有ができるサービスです。

## ■ビジネス系youtubeとは
&emsp;ビジネス書の要約や幅広い教養知識などを短時間で気軽に学ぶことができるyoutube動画です。　

## ■メインのターゲットユーザー
 - ビジネス系youtubeの視聴者層
 - 主に20代~40代の男性

## ■ユーザーが抱える課題
- 動画を見るだけでは知識の積み上げをしている実感が薄い。
- 動画視聴のみだとインプットだけとなってしまいがちになる。
- 動画がたくさんあり、どれが役立つのか判断が難しい。

## ■解決方法
- 視聴内容をアウトプットし、自分の積み上げとして管理することで知識をスキルとして身につける。
- アウトプットした内容をユーザー同士で共有することで、新たな役立つ知識を見つける。

## ■使用技術
### バックエンド
- Ruby 3.1.2 
- Rails  6.1.5
### フロントエンド
- Vue.js 2.6.14  
- Vuetify 2.6.9 

## ■実装予定の機能
### 未ログインユーザー
* ユーザー登録ができる。
  * 投稿一覧を閲覧できる。
  * 動画のサムネイル、タイトル、再生回数、投稿者名、カテゴリー名、いいね総数、ブックマークボタンを表示。
* 投稿詳細ページを閲覧できる。
  * ページ内で動画の視聴もできる。
### ログインユーザー
* ログイン機能
* アウトプット投稿機能
  * 新規作成ページからyoutube動画のURL、動画の要約、感想、今後に活かすことを投稿できる。
  * 一つの動画に対して複数人がアウトプットを投稿できる。
  * 他ユーザーの投稿詳細ページからその動画の投稿ページに遷移できる。
  * 投稿をTwitterに共有できる。
* マイページ機能
  * ログインユーザーの投稿一覧を閲覧できる。
  * 積み上げ記録として、週毎または月毎の投稿数、総動画時間、いいね総数を閲覧できる。
  * プロフィールを編集できる。
* いいね機能
  * 投稿詳細から動画に紐づくアウトプット投稿毎にいいね(ためになったボタン)を押すことができる。
* ブックマーク機能
  * 気になった動画をブックマークできる。
  * ブックマーク一覧を表示できる。
* コメント機能
  * 投稿詳細から動画に紐づくアウトプット投稿毎にコメントすることができる。
* カテゴリー機能
  * 投稿時に動画のジャンル毎(仕事、投資、健康等)にカテゴリーを設定できる。
  * カテゴリー毎に投稿一覧を閲覧できる。
* 検索機能
  * 投稿一覧をタイトル、カテゴリーで検索できる
* ランキング機能
  * いいね総数もしくは再生回数で投稿のランキングが表示できる。
### 管理ユーザー
* ユーザー検索、一覧、詳細、編集、削除
* 投稿検索、一覧、詳細、編集、削除
* カテゴリー検索、一覧、詳細、編集、削除

## ■なぜこのサービスを作りたいのか？<br>
&emsp;私は幅広い教養を学ぶためにビジネス系youtubeを、隙間時間などに視聴しています。幅広い教養を学ぶことは自分の視野や世界を広げてくれるものだと考えており、このようなyoutube動画を通じて自分の知らなかったエンジニアの世界に興味を持つきっかけにもなりました。<br>
&emsp;一方で動画視聴をしてもインプットだけになってしまい実際の生活に活かせていないことも多いと感じています。
また、私自身プログラミング学習を通じてアウトプットの重要性を学び、インプットした知識はアウトプットすることで
身につくものだと実感しました。<br>
&emsp;このサービスで継続してアウトプットを行い学んだことを定着させることで、インプットと実際に行動に移すまでのギャップの橋渡しができればと考えています。また、ユーザー同士でアウトプットを共有することで新たな知見を広げることのきっかけを作りたいと思います。

## ■画面遷移図
[figma](https://www.figma.com/file/2QQJTd9CjQo7Mc3lz5NvMk/BizTubeLogger?node-id=0%3A1)

## ■ER図
[draw.io](https://drive.google.com/file/d/1a_sgZG8fUdDulSuAmLoqRdc3K0bRs2ww/view?usp=sharing)

## ■スケジュール

- 企画〜技術調査：8/24〆切
&emsp;(YouTubeDataAPIで動画URLから動画情報を取得できることを確認した)
- README〜ER図作成：9/4〆切
- メイン機能実装：9/5 - 10/7
- β版をRUNTEQ内リリース（MVP）：10/7〆切
- 本番リリース：10/23
