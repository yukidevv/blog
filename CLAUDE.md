# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## コマンド

```bash
# 初回 clone（テーマがサブモジュールのため必須）
git clone --recursive git@github.com:yukidevv/blog.git

# ローカル確認（draft: true の記事も見るときは -D を付ける）
hugo server --renderToMemory

# 新規記事（archetype により draft: true で作成される）
hugo new post/YYYYMMDD.md

# 本番と同じビルドの確認（public/ に出力されるので確認後に削除する）
docker run -v .:/src --rm --user $(id -u):$(id -g) hugomods/hugo:exts-0.154.5 --gc --minify build
```

テストとリンタはない。ビルドの成功と `blog-reviewer` のレビューが公開前の確認になる。

`--renderToMemory` を省いた `hugo server` は `public/` に書き出す。Hugo のビルドは出力先を掃除しないため、`public/` に残ったファイル（`-D` で出力した下書きを含む）が次のデプロイで一緒に公開されるおそれがある。

Hugo のバージョン: 本番ビルドは `.githooks/pre-push` の Docker イメージ **`hugomods/hugo:exts-0.154.5`** で行われる（タグ固定）。ローカルは PaperMod の要求する **0.146.0 以上**（extended）であればよい。バージョンを上げるときは pre-push のイメージタグを更新する。

## 構成

`https://yukidev.net/blog` で公開している **Hugo** の静的サイト。

- **テーマ**: PaperMod（`themes/PaperMod/` に git サブモジュールとして配置）
- **設定**: `config.yml` — ベース URL、言語（`ja`）、タクソノミー、RSS の件数上限、goldmark
- **コンテンツ**: `content/post/` — frontmatter 付きの Markdown ファイル

### 記事の規約

- **ファイル名は `YYYYMMDD.md`**（日付のみ、スラッグや日本語名は使わない。同日の2本目のみ `YYYYMMDD-2.md`）。公開済み記事をリネームする場合は frontmatter の `aliases` に旧URLパス（例: `aliases: ["/post/old-name/"]`）を必ず残す。
- **本文の見出しは h2（`##`）から始める**。ページタイトルが h1 になるため、本文で `#` は使わない。
- 生HTML（`<br>` など）は使用可（goldmark の `unsafe: true` を有効化済み）。
- 画像は `static/images/YYYYMMDD/` に置き、`/blog/images/YYYYMMDD/filename.ext` で参照する（`/blog` プレフィックス必須、alt テキストを付ける）。
- 外部リンクは `[表示名](URL "タイトル")` 形式で書く。

### frontmatter の規約

タクソノミーは `years` のみ（`config.yml` の `taxonomies` で定義。`tags` や `categories` は無効）。`years` がないと `/years/` アーカイブに表示されない:

```yaml
---
title: "タイトル"
date: 2025-01-01T00:00:00+09:00
draft: false
years: ["2025"]
---
```

### レビュー

記事を書き終えたら、公開前に **`blog-reviewer` エージェント**（`.claude/agents/blog-reviewer.md`）でレビューする。frontmatter 規約・Markdown 構造・画像パス・日本語の文章品質をチェックする。🔴（要修正）の指摘をすべて解消してから公開する。

### テーマの上書きと独自テンプレート

- `layouts/_default/terms.html` — 年別アーカイブページ（`/years/`）の独自テンプレート。`static/css/custom.css` はこのテンプレートが直接読み込む
- `layouts/rss.xml` — 独自の RSS テンプレート（`config.yml` の設定で10件に制限）
- `layouts/partials/post_nav_links.html` — 記事下の前後ナビ（PaperMod のデフォルトを上書き）
- `layouts/shortcodes/techstack.html` — `data/techstack.yml` をカード表示するショートコード。`content/about.md` で使用。技術スタックの更新は YAML 側を編集する
- `static/` — 静的ファイル（ファビコン、画像）

### 検索

PaperMod 標準の Fuse.js 検索を使う。`config.yml` の `outputs.home` の `JSON` が検索インデックス `index.json` を生成し、`content/search.md` が検索ページになる。精度は `params.fuseOpts` で調整する。

### デプロイ

GitHub Actions は使っていない。デプロイは**ローカルの pre-push フック**（`.githooks/pre-push`）で行う:

1. `git config core.hooksPath .githooks` を一度設定しておく（`.githooks/conf.sh` を `conf.sh.example` から作成）
2. **main を push したときのみ** Docker で Hugo ビルドが走り、`public/` が自宅の Raspberry Pi サーバへ rsync され、ドキュメントルートに配置される（他ブランチの push ではスキップされる）

つまり **main への push = 即本番公開**。下書きを main に push する場合は `draft: true` にしておくこと。

**main への push はユーザーの明示的な指示があるまで行わない。**

- **GitHub 上で PR をマージしてもデプロイされない**。フックはローカルの push でしか動かないため、公開するにはローカルから main へ push する。
- フックは push の前に動く。ビルドや rsync が失敗すると push は中止され、逆にデプロイ後に push が拒否されると本番だけが先に更新される。
