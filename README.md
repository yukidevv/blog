# Blog
AWSで運用しているブログの中身

＃ 構成図  
![SS2024-01-1019 28 49](https://github.com/yukidevv/blog/assets/31511996/7ef683de-c25f-4d38-bcfc-97e4b3526f15)

# Clone
サブモジュール含めてCloneする
```
git clone --recursive {git@github.com:yukidevv/blog.git}
```

# Pull
サブモジュール含めての最新化
```
git pull && git submodule update --init --recursive
```

# 記事の作成方法
```
hugo new post/xxxx.md
```

# 記事内容の確認とビルド時の注意
```
hugo server -D
```
ビルドする際には以下の変更を行うこと<br>
draft: true<br>
↓<br>
draft: false

