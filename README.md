# Direct Lyric Input
## 概要
歌唱用合成音声エディター、Synthesizer V Studio Pro（以下SynthV）用の拡張スクリプトです。  
このスクリプトを用いることで、ノートへ歌詞（主にひらがなを想定）を少ない操作で入力できます。  
通常、ノートへ歌詞を入れるときは、  
- ノートをダブルクリック、ひらがな1文字入力、<kbd>enter</kbd>、<kbd>tab</kbd>で次のノートへ、を繰り返す
- ノートを複数選択、一括入力ウィンドウを開き、既存の歌詞を削除、入力、<kbd>enter</kbd>、`確定`をクリックするか<kbd>tab</kbd>、<kbd>tab</kbd>、<kbd>enter</kbd>

という手順を踏みます。  

このスクリプトでは、キーボードのアルファベットキー全てにショートカットを割り振ることで、  
- ノートを複数選択、歌詞を削除、入力

のみの操作で歌詞が入力できるようになります。  

また、一括入力ウィンドウと違い、入力がノートに1文字ずつ反映されるため、途中で歌詞がずれたりしたときにすぐ気付けたり、英語設定のノート、音素を直で入力したいノート（[.sil] など）も比較的スムーズに入力できます。  

## 導入
1. 最新版をダウンロード
2. SynthVを起動、メニューの`スクリプト` > `スクリプトフォルダを開く` でscriptsフォルダを開き、ダウンロードした direct-lyric-input フォルダを**フォルダごと**入れる
3. SynthVのメニューの `スクリプト` > `再スキャン`
4. 設定からショートカットを割り振る

## 使い方
（以下説明は設定が初期設定である前提です。）

- ノートを選択して歌詞を削除後、キーボードを叩くとそのまま入力されます。
  - 歌詞の削除用のスクリプト（lyric-clear, lyric-clear-all）を同梱しています。それぞれ<kbd>shift</kbd>+<kbd>backspase</kbd>、<kbd>ctrl</kbd>+<kbd>backspase</kbd>とかに振っとくと良いと思います。
  - 複数のノートを選択しているとき、ノートがひらがな、`-`、`+`で終わっていると次のノートに入力されるので、普通にひらがなを打てば1文字ずつ入力されます。[kya]とか[tta]とかもいい感じに入力されます。
- ノートの言語設定がデフォルトでない、かつ日本語以外である時はひらがなにならずアルファベットのまま入力されます。
  - たとえトラックやグループが非日本語設定でも、ノートの言語設定をノート編集から変更していなければそれはデフォルト設定（グループかトラックの言語設定に従う）なのでひらがなが入力されます。
  - `/`を入力すると次のノートに入力先が写ります。"hello"と"world"を2つのノートに打ちたければ[hello/world]と入力するわけです。打った`/`は勝手に消えます。
  - 大量に英語を打ちたいときはこのスクリプト使わないほうが楽だと思います。
- 歌詞を`.`から始めると、そのノートではひらがなにならず英語で入力されます。これはSynthVの「歌詞を`.`から始めると音素を直で入力できる」という仕様を意識したものです。
  - 1文字目以外に`.`を入力すると半角スペースに変換されます。
  - 例えば[.l.eh]と入力すれば、ノートの歌詞は".l eh"になります。
  - 先述の通り、`/`を入力することで次のノートへ移動できます。

## 設定の変更
本スクリプトはすべてのキーにショートカットを割り振る都合上、設定データの集約が難しいため、設定及び反映用スクリプト（init.lua）を別で作成しています。

1. init.luaをテキストエディタなどで開き、上部にある定数を書き換えて下さい。それぞれの細かい説明はそこに書いてあります。
   - Mac以外で設定を変更する場合、29行目、SCRIPT_DIR_PATHの設定が**必須**です。Windowsならおそらく "C:\\\\User\\\\〇〇\\\\Documents\\\\Dreamtonics\\\\Synthesizer V Studio\\\\scripts\\\\direct-lyric-input" になります。
2. できたらinit.luaへの変更の反映のためSynthVでスクリプトの再読み込みをし、`スクリプト` > `Direct Lyric Input` > `init`を実行してください。
3. 設定が反映されたファイルが`output`以下に生成されるので、それらの変更を反映するため再度スクリプトの再読み込みをして下さい。
