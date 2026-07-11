---
name: new-post
description: ブログの新規記事を作成する。記事の雛形作成からファイル名・frontmatter・本文の規約適用、blog-reviewer による公開前レビュー、公開（draft:false）までの一連のワークフロー。「記事を書きたい」「新しいポストを作って」「記事を公開して」と言われたときに使う。
---

# 新規記事の作成〜公開ワークフロー

このブログ（Hugo + PaperMod、日本語）の記事を作成するときは、以下の手順と規約に従う。

## 1. 雛形の作成

```bash
hugo new post/YYYYMMDD.md
```

- ファイル名は **`YYYYMMDD.md`（本日の日付のみ）**。スラッグ・日本語・ハイフン区切りの日付は使わない。
- 同日に2本目を書く場合のみ `YYYYMMDD-2.md` のように枝番を付ける。

## 2. Frontmatter 規約

```yaml
---
title: "タイトル"                      # ダブルクォート必須
date: 2025-01-01T00:00:00+09:00       # ISO 8601 + JST
draft: true                           # 執筆中は必ず true
years: ["2025"]                       # 記事の年。/years/ アーカイブ表示に必須
---
```

- 公開済み記事をリネームする場合は `aliases: ["/post/旧パス/"]` で旧URLを維持する。

## 3. 本文の規約

- 見出しは **h2（`##`）から始める**（ページタイトルが h1 のため `#` は使わない）
- 画像は `static/images/YYYYMMDD/` に置き、`/blog/images/YYYYMMDD/filename.ext` で参照（alt テキスト必須）
- 生HTML（`<br>` など）は使用可
- 外部リンクは `[表示名](URL "タイトル")` 形式が既存記事の慣例

## 4. プレビュー

```bash
hugo server --renderToMemory
```

## 5. 公開前レビュー（必須）

執筆が終わったら **`blog-reviewer` エージェント**で記事をレビューし、🔴（要修正）の指摘をすべて解消する。

## 6. 公開

1. `draft: false` に変更する
2. コミットして push する

**注意: main への push = 即本番公開**（pre-push フックがビルドしてラズパイへ rsync する。他ブランチの push ではスキップ）。公開の push はユーザーの明示的な指示があるまで行わないこと。
