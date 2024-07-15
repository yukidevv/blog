# Blog
AWSで運用しているブログの中身  
https://yukidev.net/

# 構成図  
![SS2024-02-1713 50 44](https://github.com/yukidevv/blog/assets/31511996/2c5ced48-5810-4c1b-b1d8-082068d7ba4a)

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
hugo server --renderToMemory
```
ビルドする際には以下の変更を行うこと<br>
draft: true<br>
↓<br>
draft: false

