# oakestown.org — Design Spec

**Date:** 2026-04-09  
**Status:** Approved

## Overview

A single-page Astro site for author Kaya Oakes, hosted on Cloudflare Workers. Replicates the look, feel, and content of the existing multi-page WordPress site at oakestown.org, collapsed into a single scrollable page. Setup mirrors sagebaggott.com.

## Tech Stack

- **Framework:** Astro with `@astrojs/cloudflare` adapter
- **Deployment:** Cloudflare Workers (via `wrangler.jsonc`)
- **Styling:** Scoped component styles + global CSS (no CSS frameworks)
- **Fonts:** Josefin Sans (headings/UI), Noto Serif (body) — Google Fonts
- **Language:** TypeScript

## Visual Design

- **Background:** White (`#fff`)
- **Text:** Dark charcoal (`#333`)
- **Accent:** Orange (`#f26e3f`)
- **Muted text:** `#555`–`#999`
- **Section dividers:** `1px solid #eee`
- **Fonts:** Josefin Sans (nav, labels, headings), Noto Serif (body prose)

## Page Structure (single page, top to bottom)

1. **Nav** — sticky, `Kaya Oakes` wordmark left, anchor links right (About / Books / Essays / Connect)
2. **Hero** — author photo (circular) + name + tagline "Essayist · Journalist · Teacher"
3. **About** (`#about`) — bio paragraphs: background, publications, teaching, awards
4. **Books** (`#books`) — grid of 5 books, each with cover image placeholder, title, publisher/year, description, endorsement quote(s)
5. **Essays** (`#essays`) — list of 15 essays with publication name (orange label) + title
6. **Connect** (`#connect`) — 2-column grid: email, newsletter, literary agent, social links
7. **Footer** — minimal: © Kaya Oakes

## Component Architecture

```
src/
  layouts/BaseLayout.astro       — html shell, fonts, global CSS
  components/
    Header.astro                 — sticky nav with hamburger (mobile)
    Hero.astro                   — photo + name + tagline
    About.astro                  — bio section
    Books.astro                  — books grid
    BookCard.astro               — individual book (cover, title, publisher, blurb)
    Essays.astro                 — essays list
    Connect.astro                — contact grid
    Footer.astro                 — copyright line
  pages/
    index.astro                  — assembles all sections
  styles/
    global.css                   — reset, custom properties, base styles
  data/
    books.json                   — book data (title, publisher, year, description, endorsements)
    essays.json                  — essay data (title, publication, url if available)
```

## Content

### Books (5)
1. *Not So Sorry* — Broadleaf Books, 2024
2. *The Defiant Middle* — Broadleaf Books, 2021
3. *The Nones Are Alright* — Orbis Books, 2015
4. *Radical Reinvention* — Counterpoint Press, 2012
5. *Slanted and Enchanted* — 2009

### Essays (15)
Commonweal, Residuum, The Revealer, Sojourners, America, Killing the Buddha, On Being, Religion News Service, Religion Dispatches, The New Republic, Slate — see full list in essays.json

### Connect
- Email: kayaoakes@gmail.com
- Newsletter: kayaoakes.substack.com
- Agent: Michelle Brower, Trellis Literary Management (trellisliterary.com/michelle-brower)
- Twitter: @kayaoakes
- Instagram: @kayaoakeswrites

## Images

Author photo and book covers cannot be automatically sourced from the WordPress site. Initial build uses styled placeholders; images to be dropped into `public/images/` and wired up manually.

## Mobile

Hamburger menu (same pattern as sagebaggott.com). Books grid collapses to single column. Connect grid stacks to single column.

## Cloudflare Config (`wrangler.jsonc`)

```jsonc
{
  "name": "oakestown-org",
  "compatibility_date": "2026-02-12",
  "compatibility_flags": ["nodejs_compat"],
  "assets": { "directory": "./dist" }
}
```

## Out of Scope

- CMS / editable content
- Contact form (email link only)
- Blog/post pages
- Analytics
