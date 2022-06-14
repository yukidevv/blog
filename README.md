# blog
Github pagesで運用しているブログの中身

# 記事の作成方法
```
hugo new posts/hello-world.md
```

# 記事内容の確認とビルド
```
hugo server -D
```
ビルドする際には以下の変更を行うこと<br>
draft: true<br>
↓<br>
draft: false

ローカルで記事の内容に問題がないことを確認後、以下のスクリプトでビルドを行う<br>
Github pages、Blogレポジトリのpushも合わせて実行する<br>
```
./push.sh
```

コミットメッセージを変更したい場合は引数に指定する
```
./push.sh "another message"
```
