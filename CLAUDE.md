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

Hugo version: **0.125.4** (extended) — required for SCSS compilation.

## Architecture

This is a **Hugo** static site deployed to S3 + CloudFront at `https://yukidev.net/blog` via GitHub Actions on push to `main`.

- **Theme**: PaperMod (git submodule in `themes/PaperMod/`)
- **Config**: `config.yml` — base URL, theme, taxonomies, RSS limit
- **Content**: `content/post/` — Markdown files with frontmatter

### Frontmatter convention

Posts use `years` taxonomy to group by year:

```yaml
---
title: "タイトル"
date: 2025-01-01T00:00:00+09:00
draft: false
years: ["2025"]
---
```

### Custom overrides

- `layouts/_default/terms.html` — custom year-grouped archive page (`/years/`)
- `layouts/rss.xml` — custom RSS template (limits to 10 items via `config.yml`)
- `static/` — static assets (favicons, images)
- Images for posts go in `static/images/YYYYMMDD/` and are referenced as `/blog/images/YYYYMMDD/filename.ext`

### Deployment

Push to `main` triggers a git hook on a self-hosted Raspberry Pi server, which builds the site and deploys `public/` via rsync.
