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

## push前の下準備
```bash
git config core.hooksPath .githooks
cp .githooks/conf.sh.example .githooks/conf.sh # デプロイ先を記入する
```

## 記事の作成方法
ファイル名は `YYYYMMDD.md`（日付のみ）で統一する
```bash
hugo new post/YYYYMMDD.md
```

## 記事内容の確認とビルド時の注意

```bash
hugo server --renderToMemory
```

## Docker を使う場合
本番ビルドと同じイメージタグ（`exts-0.154.5`）を使う
```bash
docker run -v .:/src -p 1313:1313 --rm hugomods/hugo:exts-0.154.5 server --renderToMemory #サイトテスト時
docker run -v .:/src --rm hugomods/hugo:exts-0.154.5 -gc --minify build # ビルド時
```

## 公開
main を push すると pre-push フックが Docker でビルドし、ラズパイへ rsync して**即本番公開**される（他ブランチの push ではスキップ）  
記事を公開する際は以下の変更を行うこと<br>
draft: true<br>
↓<br>
draft: false
