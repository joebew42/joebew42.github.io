# Refresh the about page and the post share buttons

> Working specification for this branch. Remove it before merging: revert the `docs: feature specification` commit.

## Context

The about page's introduction doesn't mention what Joe explores now: AI-augmented engineering and
agentic workflows. Twitter is now X, but the blog still says "Twitter" on the about page and on the
button under each post. That button only invites a comment on Twitter. Readers can't share a post
on LinkedIn, and the about page doesn't link to Joe's LinkedIn profile.

## Intent

The about page introduces Joe the way Joe wants to be introduced today. Readers can share a post on
X or on LinkedIn from the bottom of each post.

The about page's introduction becomes:

> I am Joe, currently working as a Software Engineer with focus on agile practices, software design
> principles, and processes of software development. Exploring AI-augmented engineering and agentic
> workflows.

The "Comment on Twitter" button becomes "Share on X". It prefills the post title and link, without
the @joebew42 mention. A second button, "Share on LinkedIn", shares the post's link. LinkedIn takes
no prefilled text.

The X button is black and the LinkedIn button is LinkedIn blue. On desktop the two buttons sit on
the same line. On mobile, one sits under the other.

The about page's own links to Joe's Twitter account ("Reach me on…" and "Into the jungle") say X
and point to x.com. The "Into the jungle" social links also gain Joe's LinkedIn profile.

## Out of scope

- the footer's Twitter icon and link
- the company links under "Work experiences", which keep their twitter.com addresses
- the Twitter card tags in the page head, which X still reads
- the rest of the about page's text

## Acceptance criteria

- AC1: The about page's introduction reads as given in Intent.
- AC2: When a reader clicks "Share on X" under a post, X opens with the post title and link prefilled, and no mention.
- AC3: When a reader clicks "Share on LinkedIn" under a post, LinkedIn opens to share the post's link, and its preview shows the post's title, summary and image.
- AC4 (manual): On desktop, the two buttons sit on one line. On mobile, one sits under the other.
- AC5 (manual): The X button is black and the LinkedIn button is LinkedIn blue, and both stand out from the page in the light, dark and sepia themes.
- AC6: The about page's "Reach me on" and "Into the jungle" links say X and point to x.com/joebew42.
- AC7: The about page's "Into the jungle" social links include LinkedIn, pointing to https://www.linkedin.com/in/joebew42/.

## Plan

1. **about page: new introduction, X and LinkedIn links** (AC1, AC6, AC7) — inside-out: edits the
   existing text and links in `about.md`. Touches infrastructure (content)
2. **share buttons: Share on X and Share on LinkedIn** (AC2, AC3) — inside-out: the X link follows
   the existing intent link in `_layouts/post.html`, moved to `x.com/intent/post` with `text` and
   `url`. The LinkedIn link uses LinkedIn's public `sharing/share-offsite/?url=` address. Touches
   infrastructure (layout)
3. **share buttons: layout and brand colours** (AC4, AC5) — inside-out: follows `.share-button` and
   the `media-query($on-palm)` mixin in `_sass/_layout.scss`. Per-theme shades follow the
   `$tag-colors` pattern in `_sass/_variables.scss`, where black becomes a dark grey in the dark
   theme so it still stands out. The `.blue` class goes, since no template uses it any more.
   Touches infrastructure (styles)

The repository has no test suite. The automatable criteria are checked in the HTML that
`bundle exec jekyll build` produces. The manual ones are checked in the browser with
`bundle exec jekyll serve`, at desktop and mobile widths, in each theme.

The enabling refactoring analysis was skipped.

## Progress

- [x] 1. about page: new introduction, X and LinkedIn links
  - `about.md`: the new introduction, X links to x.com/joebew42, and LinkedIn in the social links
  - the footer's Twitter link stays, as Out of scope says
- [x] 2. share buttons: Share on X and Share on LinkedIn
  - `_layouts/post.html`: "Share on X" posts the title and link through `x.com/intent/post`, with no mention.
    "Share on LinkedIn" shares the link through `sharing/share-offsite`
- [x] 3. share buttons: layout and brand colours
  - `$share-colors` gives each button a shade per theme, like `$tag-colors`: X is black, a dark grey in
    the dark theme, and a near-black in sepia. LinkedIn keeps its brand blue `#0a66c2` in every theme
  - `.share` lays the buttons out with flexbox, in a column below the `$on-palm` width
  - the `.blue` class is gone
- LinkedIn's preview was empty: it reads Open Graph tags, and the blog had none. `_includes/head.html` now has
  `og:title`, `og:description`, `og:image` and `og:url`, with the same values and fallbacks as the Twitter card tags

The final design review was skipped.

The automatable criteria were checked with two throwaway scripts against the HTML that
`bundle exec jekyll build` produces. The repository has no test suite to add them to.

### Acceptance

- AC1: met — the built about page holds the new introduction word for word
- AC2: met — the built post's X link is `x.com/intent/post?text=<title>&url=<link>`, with no `@joebew42`
- AC3: changed — the user found the LinkedIn preview empty, and agreed to add that the preview shows the post's title, summary and image.
  Met: the built post's LinkedIn link is `linkedin.com/sharing/share-offsite/?url=<link>`, and its head has the `og:` title,
  summary, title image and URL. LinkedIn shows the preview only once the site is deployed
- AC4: met — confirmed by the user: screenshots at 1000px (one line) and 390px (stacked)
- AC5: met — confirmed by the user: screenshots in the light, dark and sepia themes
- AC6: met — the built about page's "Reach me on" and "Into the jungle" links say X and point to x.com/joebew42. Only the footer, which is out of scope, keeps twitter.com
- AC7: met — the built about page's social links include LinkedIn at https://www.linkedin.com/in/joebew42/
