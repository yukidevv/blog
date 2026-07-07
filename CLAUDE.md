# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Local dev server (with live reload)
hugo server

# Build site
hugo

# Create new post
hugo new post/YYYYMMDD.md
```

Hugo version: 本番ビルドは `.githooks/pre-push` の Docker イメージ **`hugomods/hugo:exts-0.154.5`** で行われる（タグ固定）。ローカルは PaperMod の要求する **0.146.0 以上**（extended）であればよい。バージョンを上げるときは pre-push のイメージタグを更新する。

## Architecture

This is a **Hugo** static site published at `https://yukidev.net/blog`.

- **Theme**: PaperMod (git submodule in `themes/PaperMod/`)
- **Config**: `config.yml` — base URL, language (`ja`), taxonomies, RSS limit, goldmark
- **Content**: `content/post/` — Markdown files with frontmatter

### Post conventions

- **ファイル名は `YYYYMMDD.md`**（日付のみ、スラッグや日本語名は使わない）。公開済み記事をリネームする場合は frontmatter の `aliases` に旧URLパス（例: `aliases: ["/post/old-name/"]`）を必ず残す。
- **本文の見出しは h2（`##`）から始める**。ページタイトルが h1 になるため、本文で `#` は使わない。
- 生HTML（`<br>` など）は使用可（goldmark の `unsafe: true` を有効化済み）。
- 画像は `static/images/YYYYMMDD/` に置き、`/blog/images/YYYYMMDD/filename.ext` で参照する（`/blog` プレフィックス必須、alt テキストを付ける）。

### Frontmatter convention

Posts use `years` taxonomy to group by year (`years` がないと `/years/` アーカイブに表示されない):

```yaml
---
title: "タイトル"
date: 2025-01-01T00:00:00+09:00
draft: false
years: ["2025"]
---
```

### Review

記事を書き終えたら、公開前に **`blog-reviewer` エージェント**（`.claude/agents/blog-reviewer.md`）でレビューする。frontmatter 規約・Markdown 構造・画像パス・日本語の文章品質をチェックする。

### Custom overrides

- `layouts/_default/terms.html` — custom year-grouped archive page (`/years/`)。`static/css/custom.css` はこのテンプレートが直接読み込む
- `layouts/rss.xml` — custom RSS template (limits to 10 items via `config.yml`)
- `static/` — static assets (favicons, images)

### Deployment

GitHub Actions は使っていない。デプロイは**ローカルの pre-push フック**（`.githooks/pre-push`）で行う:

1. `git config core.hooksPath .githooks` を一度設定しておく（`.githooks/conf.sh` を `conf.sh.example` から作成）
2. `git push` すると Docker で Hugo ビルドが走り、`public/` が自宅の Raspberry Pi サーバへ rsync され、ドキュメントルートに配置される

つまり **push = 即本番公開**。下書きを push する場合は `draft: true` にしておくこと。
