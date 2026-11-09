# Build and deploy the blog with GitHub Actions

## Context

Since PR #18 the live blog shows no styles. Its Sass now uses `@use` modules. GitHub Pages' built-in
build runs Jekyll 3.10 with an old Sass compiler, which can't compile `@use`. It copies the lines into
`/css/main.css` unchanged and still reports success. The local build uses the Gemfile (Jekyll 4.4,
Dart Sass) and works.

## Intent

The published blog is built the same way as locally, from the Gemfile and the pinned Ruby version, so
PR #18's styles reach readers. A push to `master` publishes the site, as it does today.

## Out of scope

- changing the Sass, the layouts or the look from PR #18
- upgrading Jekyll, Ruby or other gems
- building or previewing pull requests

## Acceptance criteria

- AC1 (manual): When a commit is pushed to `master`, a GitHub Actions workflow builds the site with the Gemfile and publishes it to GitHub Pages.
- AC2 (manual): When the build fails, nothing is published and the workflow run fails.
- AC3 (manual): After the first run, `https://joebew42.github.io/css/main.css` holds compiled CSS, and the blog shows PR #18's styles.

## Plan

1. **deploy the site from GitHub Actions** (AC1, AC2) — inside-out: follows GitHub's Jekyll starter
   workflow for Pages (`actions/starter-workflows`, `pages/jekyll.yml`). Touches infrastructure.
   - add `.github/workflows/pages.yml`, run on a push to `master` and by hand
   - a build job sets up Ruby from `.tool-versions` with cached gems, runs `bundle exec jekyll build`
     with `JEKYLL_ENV=production`, and uploads `_site` as the Pages artifact
   - a deploy job runs only after the build succeeds, and publishes the artifact
   - check locally that `bundle exec jekyll build` compiles `css/main.css` with no `@use` left
2. **switch the Pages source and check the live blog** (AC3) — inside-out: no code. A settings
   change, then a check. Touches infrastructure.
   - you set Settings → Pages → Source to "GitHub Actions"
   - after the first run, check that the live `css/main.css` is compiled and the styles show

The enabling refactoring analysis was skipped.

## Progress

- [x] 1. deploy the site from GitHub Actions
  - `.github/workflows/pages.yml`: a build job (Ruby from `.tool-versions`, cached gems,
    `bundle exec jekyll build` with `JEKYLL_ENV=production`, Pages artifact) and a deploy job that
    needs it
  - checked locally: the production build compiles `css/main.css`, with no `@use` left
  - uses the latest major versions of the actions (`checkout@v7`, `configure-pages@v6`,
    `upload-pages-artifact@v5`, `deploy-pages@v5`) instead of the older ones in the starter workflow
- [ ] 2. switch the Pages source and check the live blog
  - left for later: it needs the workflow merged to `master` and the Pages source set to
    "GitHub Actions"

### Acceptance

- AC1: met — confirmed by the user: `.github/workflows/pages.yml` runs on a push to `master`, builds
  with the Gemfile and deploys to Pages
- AC2: met — confirmed by the user: the deploy job `needs: build`, so a failed build publishes nothing
- AC3: unchecked
