# blog.ebadkhan.dev

Jekyll source for the research/blog site. Terminal-styled, permission-bit
taxonomy for post types (see `_data/types.yml`).

## Local preview

```bash
bundle install
bundle exec jekyll serve --livereload
```

Visit `http://localhost:4000`.

## Writing a new post

```bash
./scripts/new-post.sh
```

Prompts for title, type (`research` / `blog` / `note`), and tags, then opens
the new file in `$EDITOR`. Fill in the body under the frontmatter, save, quit.

## Publishing

```bash
git add -A
git commit -m "post: <slug>"
git push
```

GitHub Pages rebuilds automatically. No manual deploy step.

## Structure

- `_posts/` — every post, one Markdown file each
- `_layouts/` — `default.html` (page chrome) and `post.html` (post header + body)
- `_includes/` — `header.html`, `footer.html`, `post-listing.html` (the reusable
  `ls -la`-style table, filterable by `type`)
- `_data/types.yml` — maps `type:` front matter to the permission-string
  signature and color class. Add a new entry here if you introduce a new
  post type.
- `research/`, `blog/`, `notes/` — category pages, each just filters the
  listing by type
- `scripts/new-post.sh` — scaffolds a new post file

## Adding a new post type

1. Add an entry to `_data/types.yml` with a `perm`, `class`, and `label`
2. Add a matching CSS rule for the new class in `assets/css/main.css`
   (`.perm .yourclass{color:...}`)
3. Optionally add a category page under a new folder, following the pattern
   in `research/index.html`
