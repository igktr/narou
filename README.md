Narou.rb - 小説家になろうダウンローダー＆電子書籍端末での利用に超特化した管理ツール
===================================================================================

[![Gem Version](https://badge.fury.io/rb/narou.svg)](http://badge.fury.io/rb/narou)
[![Join the chat at https://gitter.im/whiteleaf7/narou](https://badges.gitter.im/whiteleaf7/narou.svg)](https://gitter.im/whiteleaf7/narou?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

概要 - Summary
--------------
このアプリは[小説家になろう](http://syosetu.com/)などで公開されている小説の管理、
及び電子書籍データへの変換を支援します。縦書き用に特化されており、
横書きに最適化されたWEB小説を違和感なく縦書きで読むことが出来るようになります。
また、校正機能もありますので、小説としての一般的な整形ルールに矯正します。（例：感嘆符のあとにはスペースが必ずくる）

小説家になろうを含めて、下記のサイトに対応しています。
+ 小説家になろう http://syosetu.com/
+ ノクターンノベルズ http://noc.syosetu.com/
+ ムーンライトノベルズ http://mnlt.syosetu.com/
+ ミッドナイトノベルズ http://mid.syosetu.com/
+ ハーメルン https://syosetu.org/
+ Arcadia http://www.mai-net.net/
+ 暁 http://www.akatsuki-novels.com/ （※300話以上ある作品は未対応）
+ カクヨム https://kakuyomu.jp/

コンソールで操作するアプリケーションですが、ブラウザを使って直感的に操作することができる WEB UI も搭載！（[デモページ](http://whiteleaf7.github.io/narou/demo/)）

主な機能は小説家になろうの小説のダウンロード、更新管理、テキスト整形、AozoraEpub3・kindlegen連携によるEPUB/MOBI出力です。  
その他にも変換したデータを直接電子書籍端末へ送信する機能は、メールで送信する機能などもあります。

詳細な説明やインストール方法は **[Narou.rb 説明書](https://github.com/whiteleaf7/narou/wiki)** を御覧ください。

![WEB UI ScreenCapture](https://raw.github.com/wiki/whiteleaf7/narou/images/webui_cap.png)
![Console ScreenCapture](https://raw.github.com/wiki/whiteleaf7/narou/images/narou_cap.gif)

更新履歴 - ChangeLog
--------------------

3.3.1: 2018/09/29
------------------
#### 修正内容
- Windows において、ユーザー名や管理フォルダに全角文字が含まれている場合に、
  エラーが出るようになっていた


3.3.0: 2018/09/22
------------------
#### 追加機能
- ダウンロード（や更新）と変換の同時実行が可能になりました
  + 環境設定の concurrency オプションを有効にすることで使用可能になります
  + 大規模な変更なので、不安定な恐れあり。使う場合はバックアップを万全に
  + 有効にすると表示されるログの出力形式が変更されます。CUI では特殊な形式に
    なり、WEB UIではコンソールが物理的に２つになります。CUI の表示については
    concurrency.format-queue-style で調整出来ます。詳細は narou s -h を参照
  + アップデート時の変換を中断した場合に、次回更新時に変換を再試行する機能が
    concurrency が有効な場合は動きません。これは現時点では仕様です

- ログが保存出来るようになりました
  + 環境設定 logging オプションを追加しました。有効にすることでほぼすべての
    ログを保存します
    * diff や list コマンド、ヘルプなどの、出力が多く表示すること自体が目的の
      一部コマンドの出力はログには保存しません
    * ログのフォーマットとしてlogging.format-filename, logging.format-timestamp
      も追加されています。詳細は narou s -h を参照
    * concurrency が有効な場合、通常ログと変換ログに分けられます。通常ログの
      ファイル名が 20180831.txt だった場合、変換ログは 20180831_convert.txt に
      保存されます(log コマンドで簡単に表示できます)
  + log コマンドを実装しました。logging オプションで保存されるログを表示する
    ことが出来ます。tail -f のようなストリーミング機能も付いています。詳細は
    narou log -h を参照
    * concurrency で更新と変換を同時実行中は基本的に更新のログだけ表示されるの
      で、コンソールを分割して片方で narou update を実行して更新ログを表示して
      もう片方で narou log -ct で変換ログを垂れ流すみたいな使い方を想定

- ダウンロードを中断しても、再開（レジューム）出来るようになりました
  + download で新規小説をダウンロードしていたのを中断した場合は、updateコマンド
    で再開出来ます(再開部分は新着扱いになります)
  + この仕様追加の影響で、今までは新規ダウンロードを中断した場合は(ネットワーク
    エラーや手動など手段問わず)データベースに登録されなかったのが、登録される
    様になりました
  + 中断した小説は変換ができません。update で再開して最後までDLしきってください

- 環境設定に folder-length-limit を追加しました。小説を格納するフォルダ名の長さ
  制限を設定出来ます。(デフォルトでは50文字)
  + この設定を変更しても既存小説には影響はありません

- 環境設定に filename-length-limit を追加しました。各話ファイルを保存する際の
  長さ制限を設定出来ます。(デフォルトでは50文字)
  + 既存小説のアップデートにも影響が出るので、50文字でも長すぎてエラーが出る
    場合のみ変更を強く推奨

#### WEB UI
- コンソールに「全ての履歴を取得」ボタンを追加しました
  + 普段はリロードしたら直近の履歴以外は表示されませんが(読み込み負荷軽減の為)
    それを全て再表示する機能です。履歴はログ削除ボタンを押した場合に表示と共に
    一緒にクリアされます
- 個別メニューから変換などを実行した際に表示されるサブコンソールを廃止しました
- 右下にページ上部へスクロールするアイコンを設置
- 環境設定ページに「サーバを再起動」ボタンを設置
- Send のサブメニューに「端末の栞データをバックアップ」を追加
  + device が kindle の時のみ表示

#### 仕様変更
- 環境設定の update.logging を廃止しました。それに合わせて update コマンドの
  --log オプションも削除しました。ログの保存は logging に統合されます
- 更新を中断した場合でも、そこまでの新着に関しては hotentry を生成するように
  なりました
- カクヨムの小説を保存する時に格納フォルダにタイトルも含めるように変更しました
- ノクターンノベルズ、ムーンライトノベルズ、ミッドナイトノベルズの各作品は、
  掲載サイト名をそれぞれ区別するようになりました。これに合わせて格納先フォルダ
  もそれぞれのサイトごとに分けられます
  + すでにダウンロード済みの小説には影響はありません
- 上記ふたつの仕様変更に関して、以前と同じ設定に戻すには webnovel フォルダ下に
  設定上書き用のデータを用意することで実現可能です。
  詳細は http://bit.ly/overwrite_webnovel を参照してください

#### 修正内容
- カクヨムの作品の完結済みが取得できなくなっていた
- 完結状態を取得できなかった場合、end タグを勝手に削除しない様に調整
- 暁の作品の非公開状態が取得できなくなっていた
- diff コマンドに存在しない小説を指定するとエラーが出ていた
- convert コマンドに存在しない小説を指定するとエラーが出ていた
- WEB UI サーバを Ctrl+C で終了時にエラーが出ていた
- WEB UI で小説を大量に選択し「選択したタグを編集」を実行するとエラーが出ていた
- 各話DL時にタイムアウトした時にまだエラーが出ていた
- 特定の小説でファイル名を短くする処理が動いていなかった
- disable_alphabet_word_to_zenkaku を有効にすると挿絵が正常に埋め込めなくなる
  場合があった
- データ書き込み時の安定性向上

----

「小説家になろう」は株式会社ヒナプロジェクトの登録商標です
