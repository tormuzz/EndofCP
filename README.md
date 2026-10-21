# EndofCP — Competitive Programming Cheatsheet

Three-column, landscape LaTeX cheat sheet. Body text and code are set in
**Source Code Pro**, chapter/section headings in **Lora**; built with
**LuaLaTeX** (`fontspec`).

## Requirements

- **TeX Live** with **LuaLaTeX** and **fontspec / luaotfload**.
- `make` (GNU make) — optional; you can also build with `lualatex` directly.

### Linux (Debian/Ubuntu)

```bash
sudo apt update
sudo apt install -y \
  texlive-latex-base texlive-latex-recommended texlive-latex-extra \
  texlive-fonts-recommended texlive-luatex make
```

### Windows

1. Install **TeX Live** with the Windows installer from
   <https://tug.org/texlive/windows.html>. It bundles `lualatex`, `luaotfload`,
   and every package this document needs.
2. Install **GNU make** (not included with TeX Live): `choco install make`
   (Chocolatey) or `scoop install make` (Scoop).

The Debian/Ubuntu packages above and what each provides (on Windows the TeX
Live installer supplies these automatically):

| Package | Provides |
|---|---|
| `texlive-latex-base` | core LaTeX (`lualatex`, base classes) |
| `texlive-latex-recommended` | `geometry`, `fancyhdr`, `hyperref`, `graphics`, `amsmath`, `listings`, `tools` (`multicol`, `ifthen`) |
| `texlive-latex-extra` | `extsizes` (`extreport`), `enumitem`, `paralist`, `framed`, `ulem`, `tocloft`, `titletoc` |
| `texlive-fonts-recommended` | Computer Modern + URW fonts |
| `texlive-luatex` | **`luaotfload`** — required by `fontspec` to load the TTF fonts |
| `make` | runs the `Makefile` |

Fonts: **Lora** and **Source Code Pro** are bundled in `fonts/` (TTF), so no
system font install is needed.

## Build

```bash
make            # -> build/endofcp.pdf
make clean      # remove build/
```

`make` runs `lualatex` three times (extra passes settle the table of contents
and cross-references).

### Manual build (no make)

Linux / macOS:

```bash
export TEXINPUTS=".:content/tex/:"
lualatex -output-directory build content/endofcp.tex
lualatex -output-directory build content/endofcp.tex   # extra passes: TOC/refs
lualatex -output-directory build content/endofcp.tex
xdg-open build/endofcp.pdf
```

Windows (cmd; use `$env:TEXINPUTS=".;content/tex/;"` in PowerShell):

```bat
set TEXINPUTS=.;content/tex/;
lualatex -output-directory build content/endofcp.tex
lualatex -output-directory build content/endofcp.tex
lualatex -output-directory build content/endofcp.tex
start build\endofcp.pdf
```

## Layout

```
Makefile
fonts/                       Lora + Source Code Pro (TTF) — required to build
content/
  endofcp.tex                main document (EndofCP, all chapters)
  tex/endofcp.sty            the style package (formatting + fonts)
  contest/chapter.tex        \
  misc/chapter.tex            |
  math/chapter.tex            |  chapter files, pulled in by \eocpchapter{...}
  datastructures/chapter.tex  |  (order is set in content/endofcp.tex)
  numbertheory/chapter.tex    |
  strings/chapter.tex         |
  geometry/chapter.tex        |
  checklist/chapter.tex      /
  graph/chapter.tex          present but not included yet
  math/sphericalCoordinates.pdf
build/                       generated PDF + aux files (git-ignored)
```

A `\eocpchapter{name}` pulls in `content/<name>/chapter.tex`. To add a new
topic, create `content/<name>/chapter.tex` and add a matching
`\eocpchapter{<name>}` line to `content/endofcp.tex`.

## Heading levels (defined in `content/tex/endofcp.sty`)

| Command | Level | Look |
|---------|-------|------|
| `\chapterHeading{...}` | H1 | huge, bold, **underlined**, numbered "(1)" |
| `\sectionHeading{...}` | H3 | LARGE, bold, numbered "1.3" |
| `\subHeading{...}` | H5 | bold + full-column rule (tight, `\kern2pt`) |

## Text and code helpers (in `content/tex/endofcp.sty`)

| Command | Purpose |
|---------|---------|
| `\strong{word}` | bold shorthand for `\textbf{word}` |

Inside a `lstlisting`, the `(* ... *)` escape lets you drop back into LaTeX
(e.g. `(*\strong{\detokenize{word}}*)` to bold a code token mid-listing).
