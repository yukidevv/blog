# Blog
AWSで運用しているブログ

# Clone
サブモジュール含めてCloneする
```
git clone --recursive {git@github.com:yukidevv/blog.git}
```

# Pull
サブモジュール含めての最新化
```
git pull
git submodule update --init --recursive
```

# 記事の作成方法
```
hugo new post/xxxx.md
```

# 記事内容の確認とビルド
```
hugo server -D
```
ビルドする際には以下の変更を行うこと<br>
draft: true<br>
↓<br>
draft: false
