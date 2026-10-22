# How to write content — the 5-minute guide

The cheat sheet is just **text files**. You type normal text plus a few
commands that start with `\`, and `make` turns it into `build/endofcp.pdf`.
No LaTeX knowledge needed — everything you need is on this page.

## 1. Where things live

| File | What it is |
|---|---|
| `content/endofcp.tex` | main file: chapter order, team name, contest |
| `content/<topic>/chapter.tex` | one file per chapter (math, graph, strings, …) |
| `content/tex/endofcp.sty` | the style: fonts, heading look, spacing — the only file with "settings" |
| `build/endofcp.pdf` | the output, rebuilt by `make` |

Add a chapter: create `content/<name>/chapter.tex`, then add
`\eocpchapter{<name>}` to `content/endofcp.tex`.

## 2. Headings — only 3 kinds

| Write this | You get |
|---|---|
| `\chapterHeading{Graph}` | big underlined chapter title, numbered `(6)` |
| `\sectionHeading{Dijkstra}` | large bold numbered section `6.2` |
| `\subHeading{DSU}` | small bold line with a rule under it |

A `\subHeading` can split left/right with `\hfill` — handy for a complexity note:

```
\subHeading{Precompute \hfill Time: O(n log log n)}
```

## 3. Making a word bold (and friends)

| Write this | You get |
|---|---|
| `\textbf{word}` or `\strong{word}` | **word** |
| `\emph{word}` | *italic word* |
| `\uline{word}` | underlined word |
| ``text'' | “text” — two backticks open, two apostrophes close |
| `100\%`, `snake\_case`, `A \& B` | `%`, `_`, `&` — these need a `\` |

Inside a code block, `(* ... *)` drops back to LaTeX, so a code token can be
bold too: `(*\strong{word}*)`.

## 4. Code blocks

```
\begin{lstlisting}[language=C++]
int main() { return 0; }
\end{lstlisting}
```

`language=C++` gives the C++ look; leave the `[...]` off for plain text.

## 5. Lines and justification

Text is **justified** (both edges straight) automatically — nothing to do.

| Write this | Effect |
|---|---|
| `\\` | end this line here |
| `\\[6pt]` | line break plus 6pt of space |
| blank line | start a new paragraph |
| `\noindent` | don't indent this paragraph |
| `\hfill` | push the rest to the right edge |
| `\raggedright` | stop justifying (left edge only) from here on |
| `\begin{center} … \end{center}` | centre it |
| `\hrule` | draw a rule across the whole column |

Don't end a paragraph with `\\` — use a blank line instead.

## 6. Adding / removing space

| Write this | Effect |
|---|---|
| `\vspace{6pt}` / `\vspace{-3pt}` | add / remove vertical space |
| `\hspace{6pt}` | horizontal space, e.g. between two words |
| `\smallskip` `\medskip` `\bigskip` | roughly 3pt / 6pt / 12pt |
| `\vfill` | eat the remaining vertical space (pushes the next item down) |

`\vspace` at the very top of a column is ignored — use `\vspace*{6pt}` there.

To change the gap under **every** section heading, edit `content/tex/endofcp.sty`:

| Line | What it controls |
|---|---|
| 171 | space **after** `\sectionHeading` — the `1ex` in `\dimexpr\parskip+1ex\relax` (`2ex` = roomier, `\parskip` alone = tightest) |
| 184 | space **after** a `\subHeading` rule (`\vspace{1pt}`); line 178 is the space before it |
| 271 / 272 | space above / below every code block (`aboveskip` / `belowskip`) |

Keep the `\parskip+…` form. The `parskip` package subtracts `\parskip`
(4.75pt) from these numbers, so `\parskip+1ex` gives exactly `1ex` of space,
while a plain `1ex` would be shrunk to almost nothing.

**If one gap suddenly looks too big**, it is `multicols` padding out the
column: it fills every column to the full page height by stretching whatever
stretchable space (`plus …`) it can find, so when a code block jumps to the
next column the leftover is spread over the few gaps above it.

| Do | Why |
|---|---|
| keep space rigid: `\vspace{3pt}`, never `\vspace{3pt plus 5pt}` | stretchable space is what balloons |
| `\raggedcolumns` (already set in `content/endofcp.tex`) | columns keep their natural height, so leftovers stay at the bottom of a column instead of padding gaps |
| write `\codebf{...}` with **no space before the `}`** | a space inside `\codebf`/`\detokenize` prints an invisible extra line (~9pt) |
| keep one-line descriptions short enough to fit one column line | a wrapped description costs an extra line |
| to fix one spot by hand: `\vspace{-3pt}` above the block you want to pull up | local and safe |

## 7. Maths

| Write this | You get |
|---|---|
| `$a^2 + b^2$` | inline maths |
| `\[ a^2 + b^2 = c^2 \]` | centred display maths |
| `\frac{a}{b}` `\sqrt{x}` `\sum_{i=1}^{n}` `\binom{n}{k}` | fraction, root, sum, binomial |
| `\begin{align*} a &= b \\ c &= d \end{align*}` | aligned equations |

## 8. Lists, images, hiding things

- List: `\begin{itemize}` … `\item first` … `\end{itemize}` (`enumerate` numbers them).
- Image: `\includegraphics[width=25mm]{content/math/sphericalCoordinates}` (path from the project root).
- Comment out a line with `%` at the start; disable a whole block with `\iffalse … \fi`.

## 9. Build

```bash
make            # 3 passes -> build/endofcp.pdf
make clean      # delete build/
```

Content flows down column 1, then 2, 3, then the next page — you never place
things manually. The third pass settles the table of contents and page numbers.

## 10. Gotchas

- `\subsection{...}` and `\subsubsection{...}` are just aliases of `\subHeading{...}` — use `\subHeading` directly.
- A single code block can't be split across columns, so a long one jumps to the next column and can leave a gap.
- Always rebuild after adding content: columns and page numbers shift.
