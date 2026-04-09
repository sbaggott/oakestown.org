# oakestown.org Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a single-page Astro site for Kaya Oakes (oakestown.org), hosted on Cloudflare Workers, replicating the content and visual style of the existing multi-page WordPress site.

**Architecture:** Single Astro page (`src/pages/index.astro`) composing standalone section components. Global CSS uses custom properties for the oakestown.org color scheme (white bg, orange accent). Data for books and essays lives in JSON files imported by their components.

**Tech Stack:** Astro 5, `@astrojs/cloudflare` adapter, Cloudflare Workers (wrangler), Google Fonts (Josefin Sans + Noto Serif), TypeScript.

---

## File Map

| Action | Path | Purpose |
|--------|------|---------|
| Replace | `package.json` | Astro + Cloudflare deps |
| Create | `astro.config.mjs` | Astro config with Cloudflare adapter |
| Replace | `tsconfig.json` | Extend astro strict config |
| Create | `wrangler.jsonc` | Cloudflare Workers config |
| Create | `src/styles/global.css` | CSS reset + custom properties + base styles |
| Create | `src/layouts/BaseLayout.astro` | HTML shell, font import, global CSS |
| Create | `src/data/books.json` | All 5 books with metadata |
| Create | `src/data/essays.json` | All 15 essays with publication |
| Create | `src/components/Header.astro` | Sticky nav + hamburger |
| Create | `src/components/Hero.astro` | Photo + name + tagline |
| Create | `src/components/About.astro` | Bio paragraphs |
| Create | `src/components/BookCard.astro` | Single book card |
| Create | `src/components/Books.astro` | Books grid |
| Create | `src/components/Essays.astro` | Essays list |
| Create | `src/components/Connect.astro` | Contact grid |
| Create | `src/components/Footer.astro` | Copyright line |
| Create | `src/pages/index.astro` | Assembles all sections |
| Delete | `src/index.ts` | Old TypeScript stub — no longer needed |

---

## Task 1: Replace package.json and scaffold config files

**Files:**
- Modify: `package.json`
- Create: `astro.config.mjs`
- Replace: `tsconfig.json`
- Create: `wrangler.jsonc`

- [ ] **Step 1: Replace package.json with Astro + Cloudflare deps**

```json
{
  "name": "oakestown-org",
  "type": "module",
  "version": "0.0.1",
  "scripts": {
    "dev": "astro dev",
    "build": "astro build",
    "preview": "astro preview",
    "astro": "astro"
  },
  "dependencies": {
    "@astrojs/cloudflare": "^12.6.12",
    "astro": "^5.17.1"
  },
  "devDependencies": {
    "@types/node": "^25.2.3"
  }
}
```

- [ ] **Step 2: Create `astro.config.mjs`**

```js
// @ts-check
import { defineConfig } from 'astro/config';
import cloudflare from '@astrojs/cloudflare';

export default defineConfig({
  adapter: cloudflare(),
});
```

- [ ] **Step 3: Replace `tsconfig.json`**

```json
{
  "extends": "astro/tsconfigs/strict",
  "include": [".astro/types.d.ts", "**/*"],
  "exclude": ["dist"],
  "compilerOptions": {
    "types": ["node"]
  }
}
```

- [ ] **Step 4: Create `wrangler.jsonc`**

```jsonc
{
  "name": "oakestown-org",
  "compatibility_date": "2026-02-12",
  "compatibility_flags": [
    "nodejs_compat"
  ],
  "assets": {
    "directory": "./dist"
  }
}
```

- [ ] **Step 5: Install dependencies**

```bash
npm install
```

Expected: `node_modules/` created, no errors.

- [ ] **Step 6: Delete the old TypeScript stub**

```bash
rm src/index.ts
```

- [ ] **Step 7: Commit**

```bash
git add package.json astro.config.mjs tsconfig.json wrangler.jsonc
git rm src/index.ts
git commit -m "chore: scaffold Astro + Cloudflare project"
```

---

## Task 2: Global CSS and BaseLayout

**Files:**
- Create: `src/styles/global.css`
- Create: `src/layouts/BaseLayout.astro`
- Create: `src/pages/index.astro` (minimal stub)

- [ ] **Step 1: Create `src/styles/global.css`**

```css
/* Google Fonts */
@import url('https://fonts.googleapis.com/css2?family=Josefin+Sans:wght@300;400;600;700&family=Noto+Serif:ital,wght@0,400;0,700;1,400&display=swap');

/* CSS Custom Properties */
:root {
  --bg: #ffffff;
  --bg-alt: #f9f9f9;
  --text: #333333;
  --text-muted: #666666;
  --accent: #f26e3f;
  --border: #eeeeee;
  --font-heading: 'Josefin Sans', sans-serif;
  --font-body: 'Noto Serif', Georgia, serif;
  --max-width: 900px;
  --header-height: 64px;
}

/* Reset */
*,
*::before,
*::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

html {
  scroll-behavior: smooth;
}

body {
  font-family: var(--font-body);
  background-color: var(--bg);
  color: var(--text);
  line-height: 1.7;
  -webkit-font-smoothing: antialiased;
}

h1, h2, h3, h4, h5, h6 {
  font-family: var(--font-heading);
  font-weight: 700;
  line-height: 1.2;
}

a {
  color: var(--accent);
  text-decoration: none;
  transition: color 0.2s ease;
}

a:hover {
  opacity: 0.8;
}

img {
  max-width: 100%;
  height: auto;
  display: block;
}

ul, ol {
  list-style: none;
}

.container {
  max-width: var(--max-width);
  margin: 0 auto;
  width: 100%;
}

section {
  padding: 72px 40px;
  border-top: 1px solid var(--border);
}

.section-label {
  font-family: var(--font-heading);
  font-size: 0.7rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 3px;
  color: var(--accent);
  margin-bottom: 8px;
}

.section-title {
  font-family: var(--font-heading);
  font-size: 2rem;
  font-weight: 700;
  color: var(--text);
  margin-bottom: 32px;
}
```

- [ ] **Step 2: Create `src/layouts/BaseLayout.astro`**

```astro
---
import '../styles/global.css';

interface Props {
  title: string;
  description?: string;
}

const {
  title,
  description = 'Kaya Oakes — Essayist, journalist, and teacher.',
} = Astro.props;
---

<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content={description} />
    <link rel="icon" type="image/svg+xml" href="/favicon.svg" />
    <title>{title}</title>
  </head>
  <body>
    <slot />
  </body>
</html>
```

- [ ] **Step 3: Create minimal `src/pages/index.astro` stub**

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
---

<BaseLayout title="Kaya Oakes — Essayist, Journalist, Teacher">
  <p style="padding: 40px; font-family: sans-serif;">Site coming soon</p>
</BaseLayout>
```

- [ ] **Step 4: Verify it builds**

```bash
npm run dev
```

Expected: Dev server starts at `http://localhost:4321`, page shows "Site coming soon", no console errors.

- [ ] **Step 5: Commit**

```bash
git add src/
git commit -m "feat: add global CSS, BaseLayout, and page stub"
```

---

## Task 3: Data files

**Files:**
- Create: `src/data/books.json`
- Create: `src/data/essays.json`

- [ ] **Step 1: Create `src/data/books.json`**

```json
[
  {
    "title": "Not So Sorry: Abusers, False Apologies, and the Limits of Forgiveness",
    "publisher": "Broadleaf Books",
    "year": 2024,
    "description": "A nuanced exploration of forgiveness in cases of abuse and systemic wrongdoing. Examines how forgiveness is often weaponized against victims, spanning topics from Catholic Church scandals to high-profile abuse cases.",
    "endorsements": [
      {
        "quote": "Kaya Oakes challenges those slippery, PR-constructed apologies… allows us to wrestle with our assumptions.",
        "attribution": "Rev. Carol Howard"
      },
      {
        "quote": "A thoughtful meditation… with compassion, curiosity, and conviction.",
        "attribution": "Michael J. O'Loughlin"
      }
    ],
    "cover": "/images/books/not-so-sorry.jpg"
  },
  {
    "title": "The Defiant Middle: How Women Claim Life's In-Betweens to Remake the World",
    "publisher": "Broadleaf Books",
    "year": 2021,
    "description": "Examines how women navigate societal contradictions and life transitions, drawing on histories of female mystics. Argues that marginalized female identities can be spiritually transformative and world-changing.",
    "endorsements": [
      {
        "quote": "A provocative book… will challenge cultural and religious norms.",
        "attribution": "Fran Rossi Szpylczyn"
      },
      {
        "quote": "The book I didn't know I needed to read… an enlightening rumination.",
        "attribution": "Kristin Kobes Du Mez"
      }
    ],
    "cover": "/images/books/defiant-middle.jpg"
  },
  {
    "title": "The Nones Are Alright: A New Generation of Seekers, Believers, and Those In Between",
    "publisher": "Orbis Books",
    "year": 2015,
    "description": "Profiles dozens of Gen X and Gen Y individuals exploring why up to 40% of two generations lack religious affiliation. Contrasts stories of atheists, converts, and those redefining childhood faith traditions.",
    "endorsements": [
      {
        "quote": "The Growing Up Absurd for 21st century religion.",
        "attribution": "Nathan Schneider"
      }
    ],
    "cover": "/images/books/nones-are-alright.jpg"
  },
  {
    "title": "Radical Reinvention: An Unlikely Return to the Catholic Church",
    "publisher": "Counterpoint Press",
    "year": 2012,
    "description": "A memoir of personal transformation from atheist punk rocker to amateur theologian, exploring the author's return to Catholicism while examining the faith's evolution.",
    "endorsements": [
      {
        "quote": "Gorgeous prose… overview and history of the best of the Catholic faith.",
        "attribution": "Publishers Weekly"
      }
    ],
    "cover": "/images/books/radical-reinvention.jpg"
  },
  {
    "title": "Slanted and Enchanted: The Evolution of Indie Culture",
    "publisher": "Faber & Faber",
    "year": 2009,
    "description": "Examines indie culture's DIY ethos through interviews with artists including Mike Watt, Kathleen Hanna, and Dan Clowes. Explores how indie maintains core ideals of experimentation and collaboration.",
    "endorsements": [
      {
        "quote": "With uncommon insight… makes an impassioned case for indie's vitality.",
        "attribution": "San Francisco Chronicle"
      }
    ],
    "cover": "/images/books/slanted-and-enchanted.jpg"
  }
]
```

- [ ] **Step 2: Create `src/data/essays.json`**

```json
[
  { "title": "Ask Better Questions", "publication": "Commonweal", "url": null },
  { "title": "The "New Menopause" Is the Same Old Patriarchal BS", "publication": "Residuum", "url": null },
  { "title": "Whose Sin Is It Anyway", "publication": "The Revealer", "url": null },
  { "title": "What "Drag Nuns" Get Right About Faith", "publication": "Sojourners", "url": null },
  { "title": "Nick Cave Wants to Be Your Spiritual Director", "publication": "America", "url": null },
  { "title": "On Forgiveness, Clergy Abuse, and Healing", "publication": "The Revealer", "url": null },
  { "title": "Letter from California", "publication": "Commonweal", "url": null },
  { "title": "This is Your Soul on Mysticism", "publication": "America", "url": null },
  { "title": "We Are Not Middle Aged", "publication": "On Being", "url": null },
  { "title": "Mary: Always Radical Mother", "publication": "Religion News Service", "url": null },
  { "title": "A School Grows in Oakland", "publication": "America", "url": null },
  { "title": "Popesplaining", "publication": "Religion Dispatches", "url": null },
  { "title": "Lay Down Your Weary Tune", "publication": "Killing the Buddha", "url": null },
  { "title": "The Conservative Resistance Inside the Vatican", "publication": "The New Republic", "url": null },
  { "title": "I Got Shushed at a Yo-Yo Ma Concert", "publication": "Slate", "url": null }
]
```

- [ ] **Step 3: Commit**

```bash
git add src/data/
git commit -m "feat: add books and essays data"
```

---

## Task 4: Header component

**Files:**
- Create: `src/components/Header.astro`

- [ ] **Step 1: Create `src/components/Header.astro`**

```astro
---
const navLinks = [
  { label: 'About', href: '#about' },
  { label: 'Books', href: '#books' },
  { label: 'Essays', href: '#essays' },
  { label: 'Connect', href: '#connect' },
];
---

<header class="header">
  <div class="header-inner container">
    <a href="#" class="site-name">Kaya Oakes</a>
    <button class="hamburger" aria-label="Toggle menu" aria-expanded="false">
      <span></span>
      <span></span>
      <span></span>
    </button>
    <nav class="nav">
      <ul>
        {navLinks.map(link => (
          <li><a href={link.href}>{link.label}</a></li>
        ))}
      </ul>
    </nav>
  </div>
</header>

<script>
  const hamburger = document.querySelector('.hamburger');
  const nav = document.querySelector('.nav');

  hamburger?.addEventListener('click', () => {
    const expanded = hamburger.getAttribute('aria-expanded') === 'true';
    hamburger.setAttribute('aria-expanded', String(!expanded));
    nav?.classList.toggle('open');
    hamburger.classList.toggle('active');
  });

  document.querySelectorAll('.nav a').forEach(link => {
    link.addEventListener('click', () => {
      nav?.classList.remove('open');
      hamburger?.classList.remove('active');
      hamburger?.setAttribute('aria-expanded', 'false');
    });
  });
</script>

<style>
  .header {
    position: sticky;
    top: 0;
    z-index: 1000;
    background: var(--bg);
    border-bottom: 1px solid var(--border);
    height: var(--header-height);
  }

  .header-inner {
    display: flex;
    align-items: center;
    justify-content: space-between;
    height: 100%;
    padding: 0 40px;
  }

  .site-name {
    font-family: var(--font-heading);
    font-weight: 700;
    font-size: 1.1rem;
    letter-spacing: 2px;
    text-transform: uppercase;
    color: var(--text);
  }

  .site-name:hover {
    color: var(--accent);
    opacity: 1;
  }

  .nav ul {
    display: flex;
    gap: 32px;
  }

  .nav a {
    font-family: var(--font-heading);
    font-size: 0.78rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.5px;
    color: var(--text);
    transition: color 0.2s ease;
  }

  .nav a:hover {
    color: var(--accent);
    opacity: 1;
  }

  .hamburger {
    display: none;
    flex-direction: column;
    gap: 5px;
    background: none;
    border: none;
    cursor: pointer;
    padding: 5px;
  }

  .hamburger span {
    display: block;
    width: 25px;
    height: 2px;
    background: var(--text);
    transition: all 0.3s ease;
  }

  .hamburger.active span:nth-child(1) {
    transform: rotate(45deg) translate(5px, 5px);
  }

  .hamburger.active span:nth-child(2) {
    opacity: 0;
  }

  .hamburger.active span:nth-child(3) {
    transform: rotate(-45deg) translate(5px, -5px);
  }

  @media (max-width: 768px) {
    .hamburger {
      display: flex;
    }

    .nav {
      position: fixed;
      top: var(--header-height);
      left: 0;
      right: 0;
      background: var(--bg);
      border-bottom: 1px solid var(--border);
      padding: 20px;
      transform: translateY(-100%);
      opacity: 0;
      transition: all 0.3s ease;
      pointer-events: none;
    }

    .nav.open {
      transform: translateY(0);
      opacity: 1;
      pointer-events: all;
    }

    .nav ul {
      flex-direction: column;
      align-items: center;
      gap: 20px;
    }

    .nav a {
      font-size: 1rem;
    }
  }
</style>
```

- [ ] **Step 2: Wire Header into index.astro and verify**

Replace the stub content of `src/pages/index.astro`:

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
import Header from '../components/Header.astro';
---

<BaseLayout title="Kaya Oakes — Essayist, Journalist, Teacher">
  <Header />
  <main>
    <p style="padding: 80px 40px;">Content coming soon</p>
  </main>
</BaseLayout>
```

- [ ] **Step 3: Run dev server and verify sticky nav, mobile hamburger**

```bash
npm run dev
```

Expected: Nav is sticky at top, shows "KAYA OAKES" wordmark left and links right. On mobile width (<768px) links hide and hamburger appears.

- [ ] **Step 4: Commit**

```bash
git add src/components/Header.astro src/pages/index.astro
git commit -m "feat: add Header component with sticky nav and mobile hamburger"
```

---

## Task 5: Hero component

**Files:**
- Create: `src/components/Hero.astro`
- Create: `public/images/` directory (placeholder note)

- [ ] **Step 1: Create `src/components/Hero.astro`**

```astro
---

---

<section class="hero">
  <div class="hero-inner container">
    <div class="hero-photo">
      <img
        src="/images/kaya-oakes.jpg"
        alt="Kaya Oakes"
        width="200"
        height="200"
        loading="eager"
        onerror="this.style.display='none';this.nextElementSibling.style.display='flex'"
      />
      <div class="hero-photo-placeholder" aria-hidden="true">KO</div>
    </div>
    <div class="hero-text">
      <h1>Kaya<br />Oakes</h1>
      <p class="tagline">Essayist &middot; Journalist &middot; Teacher</p>
    </div>
  </div>
</section>

<style>
  .hero {
    padding: 80px 40px;
    border-top: none;
  }

  .hero-inner {
    display: flex;
    align-items: center;
    gap: 60px;
  }

  .hero-photo {
    flex-shrink: 0;
    position: relative;
    width: 180px;
    height: 180px;
  }

  .hero-photo img {
    width: 180px;
    height: 180px;
    border-radius: 50%;
    object-fit: cover;
  }

  .hero-photo-placeholder {
    display: none;
    width: 180px;
    height: 180px;
    border-radius: 50%;
    background: #f0ece8;
    align-items: center;
    justify-content: center;
    font-family: var(--font-heading);
    font-size: 2rem;
    font-weight: 700;
    color: var(--accent);
  }

  .hero-text h1 {
    font-family: var(--font-heading);
    font-size: clamp(2.5rem, 5vw, 4rem);
    font-weight: 700;
    letter-spacing: 2px;
    text-transform: uppercase;
    color: var(--text);
    line-height: 1.0;
    margin-bottom: 16px;
  }

  .tagline {
    font-family: var(--font-heading);
    font-size: 1rem;
    letter-spacing: 1.5px;
    color: var(--accent);
    text-transform: uppercase;
  }

  @media (max-width: 600px) {
    .hero-inner {
      flex-direction: column;
      gap: 32px;
      text-align: center;
    }
  }
</style>
```

- [ ] **Step 2: Add Hero to index.astro**

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
import Header from '../components/Header.astro';
import Hero from '../components/Hero.astro';
---

<BaseLayout title="Kaya Oakes — Essayist, Journalist, Teacher">
  <Header />
  <main>
    <Hero />
  </main>
</BaseLayout>
```

- [ ] **Step 3: Run dev and verify**

```bash
npm run dev
```

Expected: Hero shows "KO" initials circle placeholder (until real photo added to `public/images/kaya-oakes.jpg`), name in large Josefin Sans uppercase, orange tagline.

- [ ] **Step 4: Commit**

```bash
git add src/components/Hero.astro src/pages/index.astro
git commit -m "feat: add Hero component"
```

---

## Task 6: About component

**Files:**
- Create: `src/components/About.astro`

- [ ] **Step 1: Create `src/components/About.astro`**

```astro
---

---

<section id="about" class="about">
  <div class="container">
    <p class="section-label">About</p>
    <h2 class="section-title">Kaya Oakes</h2>
    <div class="about-body">
      <p>
        Kaya Oakes is an author of six books. Her most recent works include
        <em>Not So Sorry: Abusers, False Apologies and the Limits of Forgiveness</em> (Broadleaf Books, 2024),
        <em>The Defiant Middle: How Women Claim Life's In Betweens to Remake the World</em> (Broadleaf Books, 2021),
        <em>The Nones Are Alright</em> (Orbis Books, 2015), and
        <em>Radical Reinvention</em> (Counterpoint Press, 2012).
      </p>
      <p>
        Her essays and journalism have appeared in The Revealer, The New Republic, Slate, Foreign Policy,
        The Guardian, The Washington Post, Sojourners, National Catholic Reporter, Commonweal,
        Religion Dispatches, Tricycle, On Being, and America. She co-founded the arts and culture
        magazine Kitchen Sink and serves on the editorial board of Killing the Buddha.
      </p>
      <p>
        She received the Religion News Association's award for best commentary in 2021
        and has appeared on CBC, NPR, and various podcasts. She has lectured at universities
        including Fordham, Syracuse, Notre Dame, Villanova, USC, and UC Berkeley,
        and was selected to study religion writing at the Vatican in 2016.
      </p>
      <p>
        Since 1999, she has taught creative nonfiction, cultural criticism, composition,
        and research writing at UC Berkeley's College Writing Programs.
        She was born and raised in Oakland, California, where she currently resides.
      </p>
    </div>
  </div>
</section>

<style>
  .about {
    background: var(--bg-alt);
  }

  .about-body p {
    font-size: 1.05rem;
    color: var(--text-muted);
    margin-bottom: 18px;
    max-width: 700px;
  }

  .about-body p:last-child {
    margin-bottom: 0;
  }
</style>
```

- [ ] **Step 2: Add About to index.astro**

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
import Header from '../components/Header.astro';
import Hero from '../components/Hero.astro';
import About from '../components/About.astro';
---

<BaseLayout title="Kaya Oakes — Essayist, Journalist, Teacher">
  <Header />
  <main>
    <Hero />
    <About />
  </main>
</BaseLayout>
```

- [ ] **Step 3: Run dev and verify**

```bash
npm run dev
```

Expected: About section has orange label, bold heading, 4 bio paragraphs in gray serif text on slightly off-white background.

- [ ] **Step 4: Commit**

```bash
git add src/components/About.astro src/pages/index.astro
git commit -m "feat: add About section"
```

---

## Task 7: Books component

**Files:**
- Create: `src/components/BookCard.astro`
- Create: `src/components/Books.astro`

- [ ] **Step 1: Create `src/components/BookCard.astro`**

```astro
---
interface Props {
  title: string;
  publisher: string;
  year: number;
  description: string;
  endorsements: Array<{ quote: string; attribution: string }>;
  cover: string;
}

const { title, publisher, year, description, endorsements, cover } = Astro.props;
---

<div class="book-card">
  <div class="book-cover">
    <img
      src={cover}
      alt={`Cover of ${title}`}
      loading="lazy"
      onerror="this.style.display='none';this.nextElementSibling.style.display='flex'"
    />
    <div class="cover-placeholder" aria-hidden="true"></div>
  </div>
  <div class="book-info">
    <h3>{title}</h3>
    <p class="publisher">{publisher}, {year}</p>
    <p class="description">{description}</p>
    {endorsements.length > 0 && (
      <blockquote>
        <p>"{endorsements[0].quote}"</p>
        <cite>— {endorsements[0].attribution}</cite>
      </blockquote>
    )}
  </div>
</div>

<style>
  .book-card {
    display: flex;
    gap: 24px;
    align-items: flex-start;
  }

  .book-cover {
    flex-shrink: 0;
    width: 100px;
  }

  .book-cover img {
    width: 100px;
    border: 1px solid var(--border);
  }

  .cover-placeholder {
    display: none;
    width: 100px;
    height: 150px;
    background: #f0ece8;
    border: 1px solid var(--border);
  }

  .book-info h3 {
    font-family: var(--font-heading);
    font-size: 1rem;
    font-weight: 700;
    color: var(--text);
    margin-bottom: 4px;
    line-height: 1.3;
  }

  .publisher {
    font-family: var(--font-heading);
    font-size: 0.75rem;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: var(--accent);
    margin-bottom: 10px;
  }

  .description {
    font-size: 0.92rem;
    color: var(--text-muted);
    line-height: 1.65;
    margin-bottom: 12px;
  }

  blockquote {
    border-left: 2px solid var(--accent);
    padding-left: 12px;
    margin-top: 10px;
  }

  blockquote p {
    font-size: 0.88rem;
    font-style: italic;
    color: var(--text-muted);
    line-height: 1.6;
  }

  blockquote cite {
    display: block;
    font-size: 0.78rem;
    font-style: normal;
    font-family: var(--font-heading);
    color: var(--text-muted);
    margin-top: 6px;
  }
</style>
```

- [ ] **Step 2: Create `src/components/Books.astro`**

```astro
---
import BookCard from './BookCard.astro';
import booksData from '../data/books.json';

interface Book {
  title: string;
  publisher: string;
  year: number;
  description: string;
  endorsements: Array<{ quote: string; attribution: string }>;
  cover: string;
}

const books = booksData as Book[];
---

<section id="books" class="books">
  <div class="container">
    <p class="section-label">Books</p>
    <h2 class="section-title">Selected Works</h2>
    <div class="books-list">
      {books.map(book => (
        <BookCard
          title={book.title}
          publisher={book.publisher}
          year={book.year}
          description={book.description}
          endorsements={book.endorsements}
          cover={book.cover}
        />
      ))}
    </div>
  </div>
</section>

<style>
  .books-list {
    display: flex;
    flex-direction: column;
    gap: 40px;
  }
</style>
```

- [ ] **Step 3: Add Books to index.astro**

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
import Header from '../components/Header.astro';
import Hero from '../components/Hero.astro';
import About from '../components/About.astro';
import Books from '../components/Books.astro';
---

<BaseLayout title="Kaya Oakes — Essayist, Journalist, Teacher">
  <Header />
  <main>
    <Hero />
    <About />
    <Books />
  </main>
</BaseLayout>
```

- [ ] **Step 4: Run dev and verify**

```bash
npm run dev
```

Expected: Books section shows 5 books, each with placeholder rectangle (until real covers added to `public/images/books/`), publisher in orange, description, and first endorsement quote with orange left border.

- [ ] **Step 5: Commit**

```bash
git add src/components/BookCard.astro src/components/Books.astro src/pages/index.astro
git commit -m "feat: add Books section with BookCard component"
```

---

## Task 8: Essays component

**Files:**
- Create: `src/components/Essays.astro`

- [ ] **Step 1: Create `src/components/Essays.astro`**

```astro
---
import essaysData from '../data/essays.json';

interface Essay {
  title: string;
  publication: string;
  url: string | null;
}

const essays = essaysData as Essay[];
---

<section id="essays" class="essays">
  <div class="container">
    <p class="section-label">Selected Essays &amp; Journalism</p>
    <h2 class="section-title">Writing</h2>
    <ul class="essays-list">
      {essays.map(essay => (
        <li class="essay-item">
          <span class="essay-pub">{essay.publication}</span>
          {essay.url
            ? <a href={essay.url} target="_blank" rel="noopener noreferrer" class="essay-title">{essay.title}</a>
            : <span class="essay-title">{essay.title}</span>
          }
        </li>
      ))}
    </ul>
  </div>
</section>

<style>
  .essays {
    background: var(--bg-alt);
  }

  .essays-list {
    display: flex;
    flex-direction: column;
  }

  .essay-item {
    display: flex;
    align-items: baseline;
    gap: 20px;
    padding: 14px 0;
    border-bottom: 1px solid var(--border);
  }

  .essay-item:first-child {
    border-top: 1px solid var(--border);
  }

  .essay-pub {
    font-family: var(--font-heading);
    font-size: 0.68rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.5px;
    color: var(--accent);
    min-width: 140px;
    flex-shrink: 0;
  }

  .essay-title {
    font-family: var(--font-body);
    font-size: 1rem;
    color: var(--text);
  }

  a.essay-title {
    color: var(--text);
    transition: color 0.2s;
  }

  a.essay-title:hover {
    color: var(--accent);
    opacity: 1;
  }

  @media (max-width: 600px) {
    .essay-item {
      flex-direction: column;
      gap: 4px;
    }

    .essay-pub {
      min-width: unset;
    }
  }
</style>
```

- [ ] **Step 2: Add Essays to index.astro**

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
import Header from '../components/Header.astro';
import Hero from '../components/Hero.astro';
import About from '../components/About.astro';
import Books from '../components/Books.astro';
import Essays from '../components/Essays.astro';
---

<BaseLayout title="Kaya Oakes — Essayist, Journalist, Teacher">
  <Header />
  <main>
    <Hero />
    <About />
    <Books />
    <Essays />
  </main>
</BaseLayout>
```

- [ ] **Step 3: Run dev and verify**

```bash
npm run dev
```

Expected: Essays section shows all 15 essays as rows with orange publication label left and essay title right, separated by hairline borders.

- [ ] **Step 4: Commit**

```bash
git add src/components/Essays.astro src/pages/index.astro
git commit -m "feat: add Essays section"
```

---

## Task 9: Connect and Footer components

**Files:**
- Create: `src/components/Connect.astro`
- Create: `src/components/Footer.astro`

- [ ] **Step 1: Create `src/components/Connect.astro`**

```astro
---

---

<section id="connect" class="connect">
  <div class="container">
    <p class="section-label">Connect</p>
    <h2 class="section-title">Get in Touch</h2>
    <div class="connect-grid">
      <div class="connect-item">
        <h3>Email</h3>
        <a href="mailto:kayaoakes@gmail.com">kayaoakes@gmail.com</a>
        <p>For speaking inquiries, questions, and general correspondence.</p>
      </div>
      <div class="connect-item">
        <h3>Newsletter</h3>
        <a href="https://kayaoakes.substack.com" target="_blank" rel="noopener noreferrer">
          kayaoakes.substack.com
        </a>
      </div>
      <div class="connect-item">
        <h3>Literary Representation</h3>
        <a href="https://trellisliterary.com/michelle-brower" target="_blank" rel="noopener noreferrer">
          Michelle Brower
        </a>
        <p>Trellis Literary Management</p>
      </div>
      <div class="connect-item">
        <h3>Social</h3>
        <a href="https://twitter.com/kayaoakes" target="_blank" rel="noopener noreferrer">
          Twitter @kayaoakes
        </a>
        <br />
        <a href="https://instagram.com/kayaoakeswrites" target="_blank" rel="noopener noreferrer">
          Instagram @kayaoakeswrites
        </a>
      </div>
    </div>
  </div>
</section>

<style>
  .connect-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 40px 60px;
  }

  .connect-item h3 {
    font-family: var(--font-heading);
    font-size: 0.72rem;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 2px;
    color: var(--accent);
    margin-bottom: 8px;
  }

  .connect-item a {
    font-size: 1rem;
    color: var(--text);
    display: inline-block;
  }

  .connect-item a:hover {
    color: var(--accent);
    opacity: 1;
  }

  .connect-item p {
    font-size: 0.9rem;
    color: var(--text-muted);
    margin-top: 4px;
  }

  @media (max-width: 600px) {
    .connect-grid {
      grid-template-columns: 1fr;
      gap: 28px;
    }
  }
</style>
```

- [ ] **Step 2: Create `src/components/Footer.astro`**

```astro
---
const currentYear = new Date().getFullYear();
---

<footer class="footer">
  <div class="container">
    <p class="copyright">&copy; {currentYear} Kaya Oakes</p>
  </div>
</footer>

<style>
  .footer {
    padding: 32px 40px;
    border-top: 1px solid var(--border);
    text-align: center;
  }

  .copyright {
    font-family: var(--font-heading);
    font-size: 0.78rem;
    letter-spacing: 1px;
    text-transform: uppercase;
    color: var(--text-muted);
  }
</style>
```

- [ ] **Step 3: Assemble final index.astro**

```astro
---
import BaseLayout from '../layouts/BaseLayout.astro';
import Header from '../components/Header.astro';
import Hero from '../components/Hero.astro';
import About from '../components/About.astro';
import Books from '../components/Books.astro';
import Essays from '../components/Essays.astro';
import Connect from '../components/Connect.astro';
import Footer from '../components/Footer.astro';
---

<BaseLayout title="Kaya Oakes — Essayist, Journalist, Teacher">
  <Header />
  <main>
    <Hero />
    <About />
    <Books />
    <Essays />
    <Connect />
  </main>
  <Footer />
</BaseLayout>
```

- [ ] **Step 4: Run dev and do a full-page review**

```bash
npm run dev
```

Expected: Complete page scrolls through all 6 sections. Nav links scroll to correct anchors. Footer shows current year. No console errors.

- [ ] **Step 5: Commit**

```bash
git add src/components/Connect.astro src/components/Footer.astro src/pages/index.astro
git commit -m "feat: add Connect and Footer; complete single-page assembly"
```

---

## Task 10: Production build and Cloudflare deploy

**Files:**
- No new files — verify existing config

- [ ] **Step 1: Run production build**

```bash
npm run build
```

Expected: `dist/` directory created, no build errors.

- [ ] **Step 2: Preview build locally**

```bash
npm run preview
```

Expected: Site loads at `http://localhost:4321` (or next available port). Full scroll, all nav anchors work.

- [ ] **Step 3: Deploy to Cloudflare Workers**

```bash
npx wrangler deploy
```

Expected: Deployment URL printed (e.g., `https://oakestown-org.<account>.workers.dev`). Site loads at that URL.

- [ ] **Step 4: Commit any final tweaks**

```bash
git add -A
git commit -m "chore: verify production build and deploy"
```

---

## Images Note

Book covers and author photo are not included in this plan because they must be sourced from the existing site or provided manually. Once obtained, drop them into:

- `public/images/kaya-oakes.jpg` — author photo (Hero)
- `public/images/books/not-so-sorry.jpg`
- `public/images/books/defiant-middle.jpg`
- `public/images/books/nones-are-alright.jpg`
- `public/images/books/radical-reinvention.jpg`
- `public/images/books/slanted-and-enchanted.jpg`

The components use `onerror` fallbacks so placeholders show until real images are in place.
