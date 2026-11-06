# FreeBSD Documentation Project
 
This is the top level of the documentation project source code.
It contains the [project website](https://www.FreeBSD.org/) and
[documentation](https://docs.FreeBSD.org/) artifacts: the Handbook, FAQ,
Porter's Handbook, Developer's Handbook, articles, and translations.
 
The content is written in [AsciiDoc](https://asciidoc.org/) and built
with [Hugo](https://gohugo.io/). Install the `docproj` package to get
started.
 
## Contributing
- The [Doc Project Primer](https://docs.FreeBSD.org/en/books/fdp-primer)
  covers building, toolchain, and style guidelines.
- Submit patches on [Differential](https://reviews.FreeBSD.org/),
  make sure to tag them with `#docs`! We're volunteers,
  comment `ping` after two weeks without a reply!
- Use `git format-patch` against the `main` branch,
  and keep each change focused on one topic.
- Discuss larger changes on the documentation project
  [mailing list](https://lists.FreeBSD.org/subscription/freebsd-doc).

## Repository layout
 
| Path             | Contents                                          |
|------------------|---------------------------------------------------|
| `documentation/` | docs.FreeBSD.org: books, articles, and web portal |
| `website/`       | releases, security advisories, news, and events   |
| `shared/`        | macros, attributes, and shared assets             |
| `tools/`         | helper scripts                                    |
 
Translations live alongside the English originals under per-language
directories (e.g., `documentation/content/ru/`).

