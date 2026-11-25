# Agent instructions for the Estonian language site

## Repository

- Study materials for the Estonian language, explained in Russian. Published at https://get-the-manual.github.io/eesti-keel/.
- Pages are Markdown files in `docs/`:
  - `docs/Study/`: grammar and vocabulary topics, plus the `Kuldvillak/` quiz.
  - `docs/Exams/`: Estonian level exams (tasemeeksamid): registration, exam rules, A2 sample tasks and exam feedback.
- The site is built with [Zensical](https://zensical.org/), the successor of Material for MkDocs. Its configuration is still `mkdocs.yml` (theme variant `classic`).
- The `build-site.yml` workflow runs `zensical build --strict --clean` on every push to `main` and publishes the result to GitHub Pages with `actions/deploy-pages` (the Pages source is "GitHub Actions", not a branch).
- `scripts/` holds helper scripts (PowerShell 7 and Python). Keep scripts out of `docs/`: Zensical publishes every file there.

## Content rules

### Files and folders

- Use only Latin letters, digits, `_`, `-` and `.` in file and folder names. No spaces, no Cyrillic, no Estonian diacritics (`Kaassonad.md`, not `Kaassõnad.md`).
- One topic per page. Put images for a page in the same folder as the page.

### Navigation

- The `nav:` section of `mkdocs.yml` is maintained by hand. Titles are in Russian or Estonian and differ from file names.
- When you add, move or rename a page, update `nav:` yourself.

### Page format

- Start every page with one H1 (`# Title`). Use H2/H3 for sections; do not skip levels between siblings.
- Put a blank line before every list. Without it, Python-Markdown renders the items as one paragraph with literal `-` or `1.` text.
- Indent nested content (sub-lists, block quotes, paragraphs) by 4 spaces under its list item.
- Inside a paragraph, a line break is two spaces at the end of the line (MD009 is disabled in `.markdownlint.json` for this). `pwsh scripts/FixMarkdownLineBreaks.ps1` adds the missing trailing spaces in `docs/` (or in one file given as an argument). It skips headings, tables, list starts, raw HTML, code blocks and `<script>`/`<style>` blocks, and writes UTF-8 without BOM. Review its diff before you commit.
- Bold and italic markers must touch the text: `**-s**`, not `**-s **` or `****-s****`.
- Every table needs a header separator row and the same number of columns in each row.

### Estonian text

- Write Estonian words with the correct letters `õ ä ö ü š ž`. Check that no Cyrillic look-alike letters (`А`, `С`, `а`, `о`, `и`) end up in Estonian words, level names (`A2`) or answer keys (`8 C`).
- Check word forms, cases and conjugations in [Sõnaveeb](https://sonaveeb.ee/) or [ÕS](https://www.eki.ee/dict/qs/) before you add them. Give the dictionary forms of a verb as `ma`-infinitive, `da`-infinitive and present tense (`nõustuma, nõustuda, nõustun`).
- A grammar rule must match every example under it. If a form is an exception, say so next to it.
- Translations into Russian must match the meaning and the grammatical number and tense of the Estonian source.
- Sample exam texts written by examinees may contain errors. Keep them as they are, but mark them as uncorrected.

### Exam information

- Check facts about exams (dates, fees, rules, durations, point limits) against [harno.ee](https://harno.ee/) and link the source document.
- The same fact may appear on several pages (`Exams/index.md`, `Exams/Teabeleht-…`, `Exams/A2/…`). When you change it, update every page.
- Mark time-bound information (consultation dates, draft laws) with the date or year it applies to.

### Links

- Link to other pages with a relative path to the `.md` file, for example `[текст](../Study/Numbrid.md)`. A strict build fails on a broken link or anchor.
- In raw HTML, write paths relative to the `.md` file. Zensical rewrites them for the page URL. A strict build does not check paths in raw HTML, so open the page and check that the file loads.
- `docs/Exams/A2/Kusimus.md` contains an inline script that builds random question lists (`?generate`) and a QR code. After you edit that page, open it with `?generate` and check that the lists appear.

### Media

- Keep images reasonably small for the web. Save photo-like screenshots as JPG, not PNG.
- Before you commit new or changed images, run `python scripts/optimize_images.py <files or folders>` (needs `pip install pillow numpy pyoxipng imagequant`). Without `--apply` it is a dry run; with `--apply` it rewrites files in place. It keeps names, formats and pixel sizes: PNG is recompressed losslessly or, for files over 300 KB, reduced to a 256-colour palette when that saves at least 40 % at PSNR ≥ 38 dB; JPEG is re-encoded at quality 85 when PSNR stays ≥ 38 dB. A file changes only if it gets at least 10 % smaller. Look at the changed images before you commit.
- Do not add long videos to the repository. Link to YouTube or similar instead.
- `.gitattributes` normalizes line endings and marks media formats as binary. Do not convert line endings by hand.

## Workflow

### Add or change a page

1. Create or edit the `.md` file in the right `docs/` folder.
2. Add or update its entry in `nav:` in `mkdocs.yml`.
3. Build the site in strict mode (see below) and fix every warning: CI uses `--strict` too, so any warning stops the deployment.
4. Commit the page, its images and `mkdocs.yml` together.

### Move or rename files

1. Move or rename the files (`git mv`).
2. Update every relative link that points to them, in all pages, and the paths in `nav:`.
3. Build in strict mode.

Moving a page changes its URL on the site; external links to the old URL break. Do it only when needed.

### Check the build locally

```bash
pip install "zensical~=0.1.3"
zensical build --strict
zensical serve   # local preview
```

- On Windows, Zensical 0.1.3 fails in the git-revision-date plugin with a path error. Build with the plugin turned off: set `EESTI_GIT_DATES=false` (PowerShell: `$env:EESTI_GIT_DATES = 'false'`). Pages then have no dates; CI on Linux builds them with dates.
- Pin the same Zensical version as `build-site.yml`. Zensical is on the 0.x line, so check the build before you raise the version.

## When suggesting changes

- Prefer minimal, focused changes.
- Explain changes that break URLs or the site structure.
