# Blog
ラズパイ上で動いています  
https://yukidev.net/blog/

## Clone
まずサブモジュール含めてCloneする
```bash
git clone --recursive git@github.com:yukidevv/blog.git
```

## Pull
サブモジュール含めて最新化を行う
```bash
git pull && git submodule update --init --recursive
```

## 記事の作成方法
```bash
hugo new post/xxxx.md
```

## 記事内容の確認とビルド時の注意

```bash
hugo server --renderToMemory
```

## Docker を使う場合
```bash
docker run -v .:/src -p 1313:1313 --rm hugomods/hugo:exts server --renderToMemory #サイトテスト時
docker run -v .:/src --rm hugomods/hugo:exts build # ビルド時
```
記事を公開する際は以下の変更を行うこと<br>
draft: true<br>
↓<br>
draft: false
