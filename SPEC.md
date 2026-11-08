# Refresh the blog's look and feel

## Context

The blog is lean and simple, straight to the essence, and that concept stays. But the index list
uses titles that are too big, about 30px. Reading could feel calmer and more comfortable, as it does
on Medium.com. Every colour is fixed, so readers can't pick a darker or warmer page. The header and
the article title scroll away, so readers lose track of where they are. The Jekyll build also prints
Sass deprecation warnings, and Dart Sass 2.0 will remove the features behind them. Links in the
text are underlined far below the words. A reader deep in a long article has no quick way back to the
top, and no way to share a link to one section.

## Intent

The blog gets a Medium-like reading style: a serif body with sans-serif titles, headings and labels,
a monospace font for code, comfortable sizes, a narrower column and smaller index titles. Readers can switch between light, dark and sepia with one button in
the header. Their system preference picks the mode on the first visit, and their choice is remembered
after that. The header stays fixed at the top. While reading an article, its title stays visible in
small type just below the header. The build prints no Sass deprecation warnings. Links in the text
are underlined close to the words. A button beside the docked title takes the reader back to the top.
Each article heading offers a link to itself, to share.

## Out of scope

- new content on the index list: it keeps only each post's title and tag
- the header hiding on scroll, reading-time estimates, or other Medium features not named here
- changing images in posts to suit dark mode
- the mobile menu's behaviour, which still opens on hover
- the events page (`events.xml`, `events.xsl`, `events.css`), which has its own styles
- the share button, the read-more link and the post navigation, apart from their font and colours
- copying a heading's link to the clipboard: the link updates the address bar, and the reader copies it
- heading links on pages that are not articles, such as About

## Acceptance criteria

Typography

- AC1: Body text uses Source Serif Pro. Titles, headings, the header, tags and other labels use
  Inter. Lato is no longer loaded.
- AC2: Post titles on the index and tag pages are about 22px, and no longer full-size headings.
- AC3: Article body text is 18px with a line height of about 1.65, on wide screens and phones.
- AC4: The content column is at most about 680px wide.
- AC5 (manual): Index, article and tag pages read as calm and Medium-like, in the author's judgement.

Colour modes

- AC6: On a first visit, the page shows dark mode when the device prefers dark, and light mode
  otherwise.
- AC7: When the reader clicks the mode button in the header, the mode changes from light to dark to
  sepia, then back to light.
- AC8: When the reader returns or opens another page, the page shows the mode they last picked.
- AC9: When a page loads in dark or sepia mode, it never shows the light colours first.
- AC10: The mode button tells screen readers and mouse hover which mode is active.
- AC11 (manual): In every mode, text, links, code blocks, syntax highlighting, quotes, borders and
  the footer are readable.
- AC12 (manual): In dark and sepia modes, tags show softened versions of their colours.

Fixed header

- AC13: When the reader scrolls any page, the header stays fixed at the top.
- AC14: When a link jumps to a heading, the heading appears below the fixed header, not behind it.
- AC15: On phones, the header menu still opens and its links still work.

Docked title

- AC16: When the article's title scrolls out of view, it appears in small type just below the header.
- AC17: When the article's title scrolls back into view, the docked title disappears.
- AC18: On phones, the docked title shows on one line and cuts off long titles with an ellipsis.
- AC19: Pages that are not articles, such as the index, tag pages and About, show no docked title.

Build

- AC20: `bundle exec jekyll build --verbose` prints no Sass deprecation warnings.

Code, colours and spacing

- AC21: Inline code and code blocks use JetBrains Mono at about 14.5px, with rounded corners.
- AC22: In light mode, body text is `#24292e` and headings are `#111111`.
- AC23: In light mode, code backgrounds are `#f6f8fa`.
- AC24: Article headings have about 2.5rem of space above, 1rem below, and a line height of 1.25.

Links

- AC25: Links in the text of articles and the About page are underlined about 3px below the letters,
  not at the bottom of the line.

Back to top

- AC26: When the docked title shows, a button on its left scrolls the page back to the top.
- AC27: When the reader clicks the docked title's text, the page scrolls back to the top.
- AC28: Screen readers find the button as "Back to top", and don't read the docked title.

Heading links

- AC29: Each heading in an article's text has a "#" link to that heading's address.
- AC30: On wide screens, the "#" hangs in the left margin and shows while the reader hovers the
  heading.
- AC31: On phones, the "#" shows after the heading text, always visible and faded.
- AC32: Heading links work with JavaScript turned off.
- AC33 (manual): The back-to-top button and the "#" links fit the calm look, in every mode.

## Plan

The blog has no test suite, and none is added. Each criterion is checked in a real browser against
`bundle exec jekyll serve`, by hand or with Claude driving Chrome. The result goes into `## Progress`.
AC20 is checked by running the build. Every refactoring keeps the built `css/main.css` the same:
diff it before and after.

Every item touches only infrastructure: the theme's templates, stylesheets and inline scripts.

1. **refactor: move the Sass variables and the `media-query` mixin into a partial, and switch
   `@import` to `@use`** (enabling) — infrastructure. The `%clearfix` and `%vertical-rhythm`
   placeholders move to where every partial that extends them can load them
2. **refactor: delete the unused `$brand-color` and `$grey-color-dark`** (enabling) — infrastructure
3. **refactor: name the colours still written as literals** (enabling) — infrastructure. The divider
   `#EFEDF0`, the code background `#eef`, the highlight background `#fff` and the tag text
   `white`/`black` join the variables. `lighten($grey-color, 35%)` becomes its value, `#dbdbdb`
4. **refactor: name the header height** (enabling) — infrastructure. `$header-height: 60px` replaces
   the three `60px` in `_sass/_layout.scss`
5. **refactor: render the tag colours from one Sass map** (enabling) — infrastructure. One `@each`
   over `tag → background, text` replaces the seven `.post-tag.<tag>` rules. The class names stay
6. **build with no Sass deprecation warnings** (AC20) — inside-out: follows the Sass migration guide;
   items 1–3 already remove the `@import`, `lighten` and `darken` warnings. Replace each remaining
   `/` division with `math.div`. No warning is silenced in `_config.yml`
7. **Medium-like typography** (AC1, AC2, AC3, AC4, AC5) — inside-out: follows the existing variables
   block and the `media-query` mixin. Drop Lato from the fonts link and the variables, so `body` sets
   the one font. Set the line height as a ratio. Size `.post-list .post-title` for the index and tag
   pages. Make the visible text column at most about 680px, allowing for the padding `.wrapper`
   subtracts. Body weight and loaded font weights are settled while checking AC5 with the author
8. **fixed header** (AC13, AC14, AC15) — inside-out: `.site-header` is already the positioning
   context for the phone menu, and stays so when fixed. `.page-content` is offset by
   `$header-height`, and headings get a matching `scroll-margin-top`
9. **light, dark and sepia modes** (AC6, AC7, AC8, AC9, AC10, AC11, AC12) — outside-in: nobody has
   run how the Sass variables, CSS custom properties and an inline script before the stylesheet fit
   together here. The mode is a `data-theme` attribute on `<html>`, and the reader's choice is stored
   in `localStorage`
   - slice 1: an inline script in `_includes/head.html`, before the stylesheet, applies the system
     preference with no flash of light colours. The colour variables become custom properties per
     mode (AC6, AC9)
   - slice 2: the button in the header cycles light → dark → sepia, remembers the choice and names
     the active mode (AC7, AC8, AC10)
   - slice 3: dark and sepia colours for code, syntax highlighting, quotes, borders, footer and the
     phone menu icon, and softened tag colours as extra columns in the tag map (AC11, AC12)
10. **docked title** (AC16, AC17, AC18, AC19) — outside-in: nobody has run how a script that watches
    the title behaves under the fixed header, on wide screens and phones. The docked element and its
    inline script live only in `_layouts/post.html`
    - slice 1: when the title leaves the view, a small copy appears below the header. It disappears
      when the title returns. Other pages have none (AC16, AC17, AC19)
    - slice 2: on phones, the docked title is one line, cut off with an ellipsis (AC18)
11. **sans-serif labels, code font, softer colours and heading space** (AC1, AC3, AC5, AC21, AC22,
    AC23, AC24) — inside-out: follows the font variables, `$modes` and the fonts link item 7 and
    item 9 left. Touches infrastructure. Inter (600, 700) and JetBrains Mono join the fonts link. A
    heading font variable covers titles, headings, the header, tags, the share button and the post
    navigation. Light mode gets a heading colour; dark and sepia keep their text colour for headings.
    The heading space applies to `.post-content` headings only, so the index keeps its spacing

12. **refactor: make "no border" the default for links** (enabling) — infrastructure. Drop
    `border-bottom` from the site-wide `a` rule. Give the border only to the links that show it today:
    article and About text (`.post-content a`), the RSS link (`.rss-subscribe a`) and the footer links
    (`.social-media-list a`). Delete the seven rules that cancel it. `main.css` changes, so every
    link kind is compared in the browser before and after, in all three modes
13. **refactor: share the plain-button reset** (enabling) — infrastructure. The reset on
    `.site-nav .mode-toggle` moves into a `%plain-button` placeholder in `_sass/_base.scss`, beside
    `%clearfix`. The mode button extends it and keeps its float, margin and colour. `main.css` may
    regroup selectors only: the mode button computes the same styles
14. **underline links close to the text** (AC25) — inside-out: follows the `.post-content a` rule item
    12 leaves and the variables in `_sass/_variables.scss`. Touches infrastructure. A real underline
    with a new `$link-underline-offset` (3px) and a 1px thickness, in the text colour of each mode
15. **back to top from the docked title** (AC26, AC27, AC28, AC33) — inside-out: follows
    `.docked-title` and its inline script in `_layouts/post.html`, and the `%plain-button` from item
    13. Touches infrastructure. A "↑" button left of the title, labelled "Back to top". Clicking it or
    the title text scrolls smoothly to the top, instantly when the reader prefers reduced motion.
    `aria-hidden` moves from the container to the title `<p>`. The bar becomes a flex row: the `<p>`
    keeps its ellipsis (AC18), and the bar keeps `$docked-title-height` so anchored headings still
    land below it (AC14)
16. **heading links** (AC29, AC30, AC31, AC32, AC33) — outside-in: nobody has run a Liquid include
    that rewrites heading HTML here, on GitHub Pages' Jekyll 3.10 and local Jekyll 4.4, with jemoji
    images inside some headings. Touches infrastructure. A hand-written `_includes/heading-links.html`
    replaces `{{ content }}` in `_layouts/post.html` only, so About gets none
    - slice 1: at build time, every heading in an article's text with an id gets a "#" link to it,
      keeping the heading's inner HTML. Works with JavaScript off (AC29, AC32)
    - slice 2: on wide screens the "#" hangs in the left margin and shows on hover or focus. On phones
      it sits after the text, always visible and faded. It opts out of the AC25 underline (AC30, AC31)

## Design notes

- **Where it belongs:** typography in the variables partial, `_sass/_base.scss` and
  `_sass/_layout.scss` (`.post-content`, `.post-title`), and the fonts link in `_includes/head.html`.
  Colour modes in the variables partial as per-mode custom properties, the inline mode script in
  `_includes/head.html` before `main.css`, the button in `_includes/header.html` inside `.site-nav`,
  and syntax colours in `_sass/_syntax-highlighting.scss`. Fixed header in `.site-header`
  (`_sass/_layout.scss`). Docked title in `_layouts/post.html`, the only template with
  `.post-header > h1.post-title`. Build warnings in `css/main.scss`, `_sass/_base.scss` and
  `_sass/_layout.scss`
- **Existing behaviour and abstractions to reuse:**
  - `css/main.scss` — the variables block, `media-query`, `$on-palm`, `$on-laptop`
  - `_sass/_base.scss` — `.wrapper`, `%clearfix`, `%vertical-rhythm`, `.post-tag`, `.post-link`
  - `_sass/_layout.scss` — `.site-header`, `.site-nav` (phone hover menu), `.post-content`,
    `.post-title`
  - `_includes/head.html` — the inline gtag script, precedent for an inline script
  - `_layouts/default.html` — owns `<html>`
  - `_layouts/post.html` — `.post-header`, `h1.post-title`
- **Boundaries that must hold:**
  - the events page stays separate: `events.xsl` loads only `events.css`
  - class names templates use stay: `post-tag <tag>` (`index.html`, `_layouts/tag.html`,
    `_layouts/post.html`), `post-title`, `post-link`
  - classes generated by plugins stay styled: `emoji` (jemoji), `highlighter-rouge` and `highlight`
    (Rouge)
  - the phone menu keeps opening on `.site-nav:hover .trigger`
  - AC20 is met by fixing the sources, not by silencing warnings
- **Other modules or consumers affected:** `about.md` gets the fixed header and the colour modes, and
  no docked title. Posts use little of the theme: `{% include youtube.html %}` (`.embed-container`),
  raw images and audio. `feed.xml` and `_category/` are untouched. The phone menu icon's colour comes
  from `_sass/_layout.scss` (`fill: $grey-color-light`), not from the `fill` in
  `_includes/header.html`
- **Enabling refactorings (planned):** items 1–5
- **Deferred:**
  - **Remove styles no template uses**
    - **Change:** delete `.post-meta`, `.page-heading`, `.footer-col-3` and `.contact-list`
    - **Why:** they would be themed in every mode for nothing. But `.post-meta`'s markup sits in a
      comment in `_layouts/post.html`, so dates may come back
    - **Where:** `_sass/_layout.scss` — `.page-heading`, `.post-meta`, `.footer-col-3`,
      `.contact-list`
    - **Confidence:** high
    - **Risk:** none
  - **Keep the list of tags in one place**
    - **Change:** a `_data/tags.yml` drives both the tag pages and the tag colours
    - **Why:** adding a tag needs a file in `_category/` and a colour in the stylesheet
    - **Where:** `_category/` — seven files; `_sass/_base.scss` — `.post-tag.<tag>`
    - **Confidence:** low. Missing: how often tags are added, and whether tag colours belong in
      content data
    - **Risk:** none now
- **Open questions:** none block implementing. Body weight, loaded font weights and the softened tag
  colours are settled with the author while checking AC5 and AC12


### Design notes for items 12–16

- **Where it belongs:** the underline in `_sass/_layout.scss` — `.post-content a`, its offset in
  `_sass/_variables.scss`. The back-to-top button in `_layouts/post.html` — `.docked-title` and its
  inline script, styled in `_sass/_layout.scss` — `.docked-title`. Heading links in a new
  `_includes/heading-links.html`, called from `_layouts/post.html`, styled beside the `.post-content`
  headings in `_sass/_layout.scss`, with `media-query($on-palm)` for phones
- **Existing behaviour and abstractions to reuse:**
  - `_sass/_variables.scss` — `media-query`, `$on-palm`, `$grey-color`, `$docked-title-height`
  - `_sass/_base.scss` — `%clearfix` (precedent for a placeholder), `h1…h6 { scroll-margin-top }`
  - `_sass/_layout.scss` — `.docked-title ~ .post-content h1…h6` (anchored headings land below the
    header and the docked title), `.site-nav .mode-toggle` (the button reset), `.post-content h1…h6`
  - `_layouts/post.html` — the inline `IntersectionObserver` script, which already holds `docked`
  - `_includes/youtube.html`, `_includes/icon-github.html` — includes that take parameters
  - Kramdown's `auto_ids`, on by default: every heading in the posts has an id
- **Boundaries that must hold:**
  - the RSS link and the footer links keep their bottom border: only article and About text change
  - the "#" links sit inside `.post-content`, so they opt out of the AC25 underline
  - the docked bar stays `$docked-title-height` tall, or anchored headings land behind it
  - a button inside `aria-hidden="true"` is hidden from screen readers, so `aria-hidden` moves to the
    `<p>` that repeats the title
  - the include uses only Liquid 4 filters, which GitHub Pages' Jekyll 3.10 supports. jemoji runs
    after the layout, so the include keeps each heading's inner HTML as it is
  - `feed.xml` uses `post.summary`, so heading links never reach the feed
  - the earlier boundaries above still hold: the events page, template class names, plugin classes
    and the phone menu's hover
- **Other modules or consumers affected:** `about.md` gets AC25 only. `index.html` (`.rss-subscribe`)
  and `_includes/footer.html` keep their look after item 12
- **Enabling refactorings (planned):** items 12 and 13
- **Deferred:** none. Reshaping the docked title first, and any existing heading-link code, were
  checked and need no action
- **Open questions:** none block implementing. Whether a 3px offset reads well is settled with the
  author while checking AC33

## Refactorings

### r1. Read the tag colours' modes from `$modes`

- **Change:** replace `@each $mode in (dark, sepia)` in `_sass/_base.scss` with the keys of
  `$modes` other than `light`, e.g. `map.keys(map.remove($modes, light))`
- **Why:** `$modes` is the one list of modes, and `_sass/_modes.scss` already loops over it. A mode
  added to `$modes` and `$tag-colors` would get no tag backgrounds until this second list is edited,
  with no error
- **Where:**
  - `_sass/_base.scss` — `@each $mode in (dark, sepia)`
  - `_sass/_variables.scss` — `$modes`
  - `_sass/_modes.scss` — `@each $mode, $colors in $modes`
- **Confidence:** high
- **Risk:** none. `main.css` stays byte-identical: diff it before and after

### r2. Let the head script own the stored mode, and the header script only the button

- **Change:** the inline script in `_includes/head.html` exposes one small global, e.g.
  `window.colorMode = { modes, current(), set(mode) }`, owning the `theme` key in `localStorage`, the
  `data-theme` attribute and the list of modes. The script in `_includes/header.html` keeps only the
  names, icons and cycle order, and calls `colorMode.current()` and `colorMode.set(next)`
- **Why:** both scripts repeat the storage key, the attribute and the list of modes. Renaming the key
  or adding a mode takes matching edits in two files, and a miss breaks AC7 or AC8 silently. The gtag
  script in the same file already defines globals, so this follows existing practice
- **Where:**
  - `_includes/head.html` — inline mode script (`picked`, `known`)
  - `_includes/header.html` — inline button script (`modes`, `show`, the click handler)
- **Confidence:** medium. Two self-contained scripts may be the simpler design on purpose
- **Risk:** the header script then depends on the head script having run. `_layouts/default.html`
  always includes the head first. Check AC6–AC10 in the browser again

### r3. Name the tag text roles without mode words

- **Change:** rename `tag-text-light` and `tag-text-dark`, in `$modes` and as Sass aliases, to words
  that aren't mode names, e.g. `tag-text-pale` and `tag-text-ink`
- **Why:** each `$tag-colors` row reads `text: $tag-text-light, light: …, dark: …`, where `light`
  means a text colour once and a mode once. A reader can take `tag-text-dark` for "tag text in dark
  mode"
- **Where:**
  - `_sass/_variables.scss` — `$modes`, `$tag-text-light`, `$tag-text-dark`, `$tag-colors`
  - `_sass/_base.scss` — `@each $tag, $colors in $tag-colors`
- **Confidence:** medium. The name clash is real. Whether it misleads is a judgement call
- **Risk:** none in behaviour. The custom property names in `main.css` change. Check AC12 in the
  browser again

## Progress

- [x] 1. refactor: move the Sass variables and the `media-query` mixin into a partial, and switch
  `@import` to `@use`
  - the variables and the mixin live in `_sass/_variables.scss`, loaded by every partial
  - `%clearfix` and `%vertical-rhythm` stay in `_sass/_base.scss`. `_layout.scss` and
    `_syntax-highlighting.scss` load `base` to extend them, which keeps `main.css` byte-identical
- [x] 2. refactor: delete the unused `$brand-color` and `$grey-color-dark`
- [x] 3. refactor: name the colours still written as literals
  - `$grey-color-light` is now `#dbdbdb`. Sass had computed `rgb(219.25, …)`, the only change in
    `main.css`
- [x] 4. refactor: name the header height
- [x] 5. refactor: render the tag colours from one Sass map
  - `$tag-colors` lives in `_sass/_variables.scss`. Only tags with dark text override the link
    colour, as before
- [x] 6. build with no Sass deprecation warnings
  - every `/` division became `math.div`, including the example in the `media-query` comment.
    `main.css` stayed byte-identical
- [x] 7. Medium-like typography
  - Lato is gone from the fonts link and the variables. Headings, tags, links, the share button and
    the post navigation inherit Source Serif Pro from `body`
  - body text is weight 400, chosen by the author over 300. The fonts link loads 400, 600 and 700
  - `$base-line-height` is the ratio 1.6, also on phones. `$content-width` is 740px, so the column
    is 680px after the padding. Index and tag page titles are `$post-list-title-font-size`, 22px
- [x] 8. fixed header
  - `.site-header` is `position: fixed` and still the phone menu's positioning context
  - `$header-offset` (header height plus one spacing unit) pads `.page-content` and sets the
    headings' `scroll-margin-top`
- [x] 9. light, dark and sepia modes
  - Item 9 slices built: the device preference, applied before the stylesheet; the header button
    that cycles and remembers the mode; dark and sepia colours for the rest, and softened tags
  - every mode colour lives in `$modes` in `_sass/_variables.scss`. `_sass/_modes.scss` turns it
    into custom properties: light on `:root`, the others on `:root[data-theme="…"]`
  - the stored choice is the `theme` key in `localStorage`. An unknown value falls back to the
    device preference
  - the button sits first in `.site-nav`: rightmost on wide screens, beside the menu icon on phones.
    It shows ☀, ☾ or ☕, and its label reads e.g. "Dark mode. Switch to sepia mode"
  - syntax token colours are `--syntax-*` properties, used directly in
    `_sass/_syntax-highlighting.scss`. Sepia keeps the light token colours, except darker comments
  - `$tag-colors` gives each tag its text role and a background per mode. Tag text follows the
    mode's `--tag-text-pale` and `--tag-text-ink` (renamed in r3), and tag links inherit it
- [x] 10. docked title
  - Item 10 slices built: the docked title shows and hides as the article title leaves and returns;
    one line with an ellipsis
  - an `IntersectionObserver` in `_layouts/post.html` watches the title, with the header height as
    its top margin. The docked copy is `aria-hidden`, since it repeats the `h1`
  - the docked title is one line at every width, not only on phones. Its height stays fixed, so
    article headings reached by a link get `scroll-margin-top` for the header plus the docked
    title (`$docked-title-height`)
  - the header stacks above the docked title (`$header-z-index` is 2), so the phone menu opens over it

- [x] 11. sans-serif labels, code font, softer colours and heading space
  - asked for by the author after the first round: AC1 and AC3 were reworded, AC21–AC24 added
  - `$heading-font-family` (Inter) covers headings, the header, tags, index links, the share
    button, the post navigation and the docked title. `$code-font-family` is JetBrains Mono, with
    ligatures off at the author's choice. The fonts link loads Inter 400, 600 and 700, and JetBrains
    Mono 400 and 700
  - light mode gets `heading-color` `#111111`. Dark and sepia headings keep their text colour
  - the 2.5rem/1rem heading space applies to `.post-content` headings only, so the index keeps
    its spacing. The docked title's height follows the new line height, so anchored headings
    still land below it
  - the light-mode code comment colour now sits on `#f6f8fa` instead of `#eef`
- [x] 12. refactor: make "no border" the default for links
  - the border lives in one rule for `.post-content a`, `.rss-subscribe a` and
    `.social-media-list a`. Every link computes the same styles in all three modes, at 1400px and
    375px, except the menu icon on wide screens, which is hidden there
- [x] 13. refactor: share the plain-button reset
  - `%plain-button` sits in `_sass/_base.scss` before the icons. In `main.css` only the reset's
    declarations moved into their own rule
- [x] 14. underline links close to the text
  - `.post-content a` draws a real underline: `$link-underline-offset` (3px) and
    `$link-underline-thickness` (1px), in the mode's text colour. The RSS and footer links keep
    their bottom border
- [x] 15. back to top from the docked title
  - a "↑" `.back-to-top` button, labelled "Back to top", sits left of the docked title, which is a
    flex row. The title `<p>` keeps its ellipsis and now carries `aria-hidden`
  - the button and the title text call one `backToTop`: a smooth scroll, or an instant one when the
    reader prefers reduced motion. The bar stays 39px tall, so anchored headings still land below it
- [x] 16. heading links
  - Item 16 slices built: a "#" link in every article heading with an id, at build time; the "#"
    in the left margin on hover or focus, and faded after the text on narrow screens
  - `_includes/heading-links.html` splits the content on `<h`, and puts the link just before each
    heading's closing tag, so the inner HTML stays as it was. The link reads "Link to this heading"
    to screen readers
  - checked on every post with Jekyll 4.4 and 3.10: all 151 headings with an id get one link, and
    nothing else in the pages changes. The emoji plugin only reflows whitespace
  - the "#" goes after the text below 700px (`$on-laptop`), not only below 600px: between those
    widths the side padding is too narrow to hold it in the margin
- [x] r1. Read the tag colours' modes from `$modes`
  - `main.css` stayed byte-identical
- [x] r2. Let the head script own the stored mode, and the header script only the button
  - `window.colorMode` offers `current()` and `set(mode)`. The list of modes stays private to the
    head script, since nothing else reads it
- [x] r3. Name the tag text roles without mode words
  - `tag-text-light` is now `tag-text-pale`, and `tag-text-dark` is `tag-text-ink`. With the names
    mapped back, `main.css` is identical, and every tag computes the same colours in every mode
- the refactorings were checked again in headless Chromium: AC6–AC10 for r2, AC7, AC11 and
  AC13–AC19 after it, and AC12's tag colours for r3. All still pass
- the final design review ran and recorded r1, r2, r3. It also found that some design notes
  describe where code was planned to live, not where it ended up: the mode custom properties come
  from `_sass/_modes.scss`, the syntax colour values sit in `$modes`, and `css/main.scss` now only
  loads partials
- the browser checks lived in the session's scratchpad and are not committed, as the plan said
- items 12–16 were checked in headless Chromium: every link kind before and after item 12, AC25–AC32,
  and AC6–AC10, AC13–AC19 and AC20 again after them. All pass

### Acceptance

- AC1: changed — the author found serif titles, headings and labels didn't work. They now use
  Inter, body text stays Source Serif Pro. Met: headless Chromium computes Inter for titles,
  headings, header, tags, share button, post navigation and docked title, Source Serif Pro for
  body text; the fonts link loads Inter and no Lato
- AC2: met — index and tag page post titles compute to 22px
- AC3: changed — 18px with a 1.65 line height, chosen by the author over 20px. Met: body text
  computes to 18px and 1.65 on a 1400px window, 18px at 375px
- AC4: met — the article column measures 680px on a 1400px window
- AC5: met — confirmed again by the author from screenshots of the Inter, Source Serif Pro and
  JetBrains Mono look, in light, dark and sepia
- AC6: met — first visits with a dark device preference show dark mode, light otherwise, on the
  index, an article and About
- AC7: met — clicking the header button cycles light → dark → sepia → light with three different
  page colours, and tapping it works on phones
- AC8: met — the picked mode survives a reload and another page, and a picked light mode wins over
  a dark device
- AC9: met — `data-theme` is already dark when the stylesheet is parsed, and the first frame paints
  the dark background
- AC10: met — the button's `aria-label` and `title` start with the active mode, e.g. "Dark mode.
  Switch to sepia mode", also after loading
- AC11: met — confirmed by the author from screenshots of all three modes. Measured contrast is at
  least 3:1 everywhere, except code comments in light mode (2.5:1), the colour the blog already had
- AC12: met — confirmed by the author from dark and sepia index screenshots
- AC13: met — after scrolling, the header stays at the top of the index, a tag page, About and an
  article, on wide screens and phones
- AC14: met — headings reached by a link land below the header and the docked title
- AC15: met — on phones, hovering the menu shows the links on top, and the About link navigates
- AC16: met — once the title scrolls away, a 16px copy of it shows just below the header, on wide
  screens and phones
- AC17: met — the docked title is hidden at the top, and hides again on scrolling back
- AC18: met — on phones the docked title is `nowrap` with `text-overflow: ellipsis`, and a long
  title overflows into the ellipsis
- AC19: met — the index, a tag page and About have no docked title
- AC20: met — `bundle exec jekyll build --verbose` prints no Sass deprecation warnings
- AC21: met — inline code and code blocks compute to JetBrains Mono at 14.5px with rounded corners
- AC22: met — in light mode body text computes to rgb(36, 41, 46) and headings to rgb(17, 17, 17)
- AC23: met — in light mode inline code and code blocks compute to rgb(246, 248, 250)
- AC24: met — article headings compute to 40px above, 16px below and a 1.25 line height
- AC25: met — links in article and About text compute to a 1px underline 3px below the letters, in
  each mode's text colour, with no bottom border. The RSS and footer links keep theirs
- AC26: met — once the title has scrolled away, a "↑" button shows left of the docked title, and
  clicking it scrolls to the top, at 1400px and 375px
- AC27: met — clicking the docked title's text scrolls to the top, at 1400px and 375px
- AC28: met — the accessibility tree has a "Back to top" button, and no copy of the docked title
- AC29: met — all 151 headings with an id, in every post, have one "#" link to their own address.
  Clicking it puts that address in the address bar
- AC30: met — on a 1400px window the "#" hangs left of the column, hidden at rest, and shows on
  hover and keyboard focus, in all three modes
- AC31: met — at 375px the "#" follows the heading text, always visible at 0.4 opacity, not
  underlined, in all three modes
- AC32: met — with JavaScript turned off, every heading still has its "#" link
- AC33: met — confirmed by the author from wide, phone and About screenshots in all three modes
