# HCMUT Formatting & Style Reference

Aggregated from: HCMUT official pages (hcmut.edu.vn), Khoa Điện – Điện tử faculty document
(circulated on Studocu), community LaTeX templates on GitHub
([wonrax](https://github.com/wonrax/hcmut-latex-report-template),
[thanhhungqb](https://github.com/thanhhungqb/thesis-template),
[meterglost](https://github.com/meterglost/HCMUT-latex-template)), and the existing Typst template.

> [!IMPORTANT]
>
> HCMUT sets formatting per-faculty. The most authoritative source for **Khoa Điện – Điện tử
> (FEEE)** is a faculty document scanned from an official handout. Where values differ between
> FEEE and general HCMUT, the FEEE value is listed first and treated as ground truth for this
> template.

> [!NOTE]
>
> There is **no binding TCVN national standard** for thesis/report formatting. Each institution
> (and within HCMUT, each faculty) sets its own rules.

---

## 1. Paper & Page Layout

| Parameter | FEEE Spec | General HCMUT | Current Template |
|---|---|---|---|
| Paper size | **A4** (210 × 297 mm) | A4 | Typst default (A4) ✓ |
| Printing | **Single-sided** | Single-sided | — |
| Left margin (Lề trái) | **40 mm** | 30–35 mm | `auto` ≈ 25 mm ❌ |
| Right margin (Lề phải) | **25 mm** | 20 mm | `auto` ≈ 25 mm |
| Top margin (Lề trên) | **40 mm** | 20–35 mm | `auto` ≈ 25 mm ❌ |
| Bottom margin (Lề dưới) | **25 mm** | 20–30 mm | `auto` ≈ 25 mm |

The wide **left margin (40 mm)** is the binding allowance (gáy sách). No separate gutter field.

```typst
// Correct margin for state.typ default:
margin: (left: 40mm, right: 25mm, top: 40mm, bottom: 25mm)
```

---

## 2. Typography

### Body Text

| Parameter | FEEE Spec | Current Template |
|---|---|---|
| Font family | **Times New Roman** (Unicode / UTF-8) | STIX Two Text → Times New Roman ✓ |
| Font size | **13 pt** | 13 pt ✓ |
| Encoding | Unicode UTF-8 mandatory; VNI/.VnTime **forbidden** | UTF-8 ✓ |

> [!NOTE]
> STIX Two Text is a Times-compatible Unicode font with full Vietnamese diacritic support via
> HarfBuzz. It is an acceptable substitute and is already the primary font in this template.
> LaTeX equivalents use `mathptmx` at 12pt, which renders similarly to Word's 13pt due to
> differing baseline metrics.

### Headings

All headings stay at **13 pt** — no size escalation by level. Style/alignment varies:

| Level | Example | Style | Alignment |
|---|---|---|---|
| H1 — Chapter title | `CHƯƠNG 1: TÊN CHƯƠNG` | **ALL CAPS, Bold** | Centered |
| H2 — Section | `1.1 TÊN MỤC` | **ALL CAPS, Bold** | Left |
| H3 — Subsection | `1.1.1 Tên tiểu mục` | **Bold** (mixed case) | Left |
| H4 — Sub-subsection | `1.1.1.1 Tên mục nhỏ` | *Italic* (mixed case) | Left |

- Maximum nesting: **4 levels** (`1.1.1.1`). Level 5+ is prohibited.
- Each subsection level must have **at least 2 items** (no lone `1.1.1` without `1.1.2`).
- **Numbering format**: Pure Arabic numerals — `1`, `1.1`, `1.1.1`, `1.1.1.1`. No Roman
  numerals in body section numbers.
- **Each chapter must start on a new page.**
- Current template uses `set heading(numbering: "1.1.1.1.1")` — matches ✓ (but the 5th level
  should never be used).

```typst
// Suggested show rules for styles.typ:
show heading.where(level: 1): it => { pagebreak(weak: true); align(center, upper(it)) }
show heading.where(level: 2): it => upper(strong(it))
show heading.where(level: 3): strong
show heading.where(level: 4): emph
```

### Captions

| Element | Font | Style | Position |
|---|---|---|---|
| Figure caption | 12 pt | Italic (bold supplement) | **Below** figure |
| Table caption | 12 pt | Bold (or bold italic) | **Above** table |
| Source note (below figure/table) | 10–11 pt | Italic | Below |

Current template renders captions correctly (bold supplement + italic body). Position for tables
needs explicit `position: top` in Typst figure syntax.

---

## 3. Paragraph & Line Spacing

| Parameter | FEEE Spec | General HCMUT | Current Template |
|---|---|---|---|
| Justification | **Justified** (canh đều hai bên) | Justified | Justified ✓ |
| First-line indent | **1.25 cm** (= 1 tab stop) | 1.25 cm | 1.25 cm ✓ |
| Line spacing — Vietnamese | **1.3×** | 1.5× | 1.3× ✓ |
| Line spacing — English | **1.1×** | — | 1.1× ✓ |
| Paragraph spacing before | 3–6 pt | 3–6 pt | Typst default |
| Paragraph spacing after | 3–6 pt | 3–6 pt | Typst default |
| Character spacing | Normal (no condensing) | Normal | ✓ |

> [!NOTE]
> The 1.3/1.1 split (Vietnamese vs English) is a distinctive FEEE specification not found in
> other faculties' guidelines. For a Vietnamese-language report, target **1.3×**.

```typst
// Suggested addition to apply-styles in styles.typ:
set par(
  justify: true,
  first-line-indent: 1.25cm,
  leading: 0.65em * 1.3,  // 1.3× for Vietnamese; use 0.65em * 1.1 for English sections
)
```

---

## 4. Page Numbers & Running Headers

### Page Numbering

| Zone | Format | Printed? | Position |
|---|---|---|---|
| Outer cover, task sheet | (counted) | **Not printed** | — |
| Front matter (acknowledgments, abstract, ToC, LoF, LoT) | **i, ii, iii, iv, ...** (lowercase Roman) | Printed | Centered, bottom |
| Main body (Chapter 1 → References → Appendices) | **1, 2, 3, ...** (Arabic) | Printed | Centered, bottom |
| Backmatter (grading sheet etc.) | Resets | As needed | Centered, bottom |

Current template uses `"I"` (uppercase Typst Roman) for front matter and `"1"` for body — Typst
renders `"I"` as uppercase Roman, which is acceptable. The spec says lowercase; consider `"i"`.

```typst
// In lib.typ / set page():
number-align: center + bottom
```

### Running Headers

FEEE does **not** mandate specific running header content for lab reports. For thesis/LVTN,
some departments use the chapter title or thesis title (10 pt, centered or right-aligned), but
many templates leave headers blank. This template's current blank header is acceptable.

---

## 5. Tables

- **Caption**: Placed **above** the table.
- **Caption format**: `Bảng [chapter].[number]: [description]` (per-chapter numbering).
- **Source note**: 10–11 pt, italic, placed below the table if data is from an external source.
- **Internal text size**: 10–12 pt acceptable (can be smaller than body for compact data).
- **Border rule**: Guidelines say "phải có đường viền rõ ràng" (must have clear borders) but
  do not prescribe stroke widths. Full-grid borders are what printed Word templates show;
  the booktabs-style in this template is a modern deviation that is not prohibited.
- **Header row**: Bold.
- **Alignment**: Left for text, center for numbers/status columns.
- **Numbering**: Per-chapter (`Bảng 1.1`, `Bảng 2.3`) ✓.

---

## 6. Figures & Images

- **Caption**: Placed **below** the figure.
- **Caption format**: `Hình [chapter].[number]: [description]` (per-chapter numbering).
- **Source citation**: If image is from an external source, cite below the caption.
- **In-text reference**: Every figure must be referenced in the body text before it appears
  (e.g., "như thể hiện ở Hình 1.1").
- **Numbering**: Per-chapter (`Hình 1.1`, `Hình 1.2`, ..., `Hình 2.1`) ✓.

```typst
// Reset figure counter at each chapter heading (styles.typ):
show heading.where(level: 1): it => {
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  it
}
// Then set figure numbering to per-chapter:
set figure(numbering: n => {
  let chapter = counter(heading.where(level: 1)).get().first()
  str(chapter) + "." + str(n)
})
```

---

## 7. Equations

| Parameter | FEEE Spec | Current Template |
|---|---|---|
| Numbering format | **(chapter.number)** e.g. `(3.2)` | Per-chapter `"(1.1)"` ✓ |
| Number placement | Right-aligned, same line | Right-aligned ✓ |
| Equation alignment | Centered | Centered ✓ |
| When to number | Only equations referenced in text | Selective via `eq()` helper ✓ |

After an equation's first appearance, **all variables must be explained** (meaning + units).

```typst
// Update eq() helper in utils.typ to use chapter-scoped numbering:
#let eq(eq, id: none) = {
  set math.equation(
    numbering: if id == none { none } else {
      n => {
        let chapter = counter(heading.where(level: 1)).get().first()
        "(" + str(chapter) + "." + str(n) + ")"
      }
    },
  )
  if id == none { eq } else { [#eq #label(id)] }
}
```

---

## 8. Bibliography / References

| Parameter | FEEE Spec | Current Template |
|---|---|---|
| Citation style | **IEEE** | `style: "ieee"` ✓ |
| In-text format | `[1]`, ordered by first appearance | ✓ |
| Multiple citations | `[2, 5]` or `[1]–[5]` | ✓ |
| Section title | TÀI LIỆU THAM KHẢO (all caps) | Via i18n `references-title` ✓ |
| Foreign-language refs | Keep in original language (do not translate) | — |

IEEE format examples used at HCMUT:
- **Book**: `[1] S. M. Kazemi, *Power System Dynamics*, 2nd ed. London: Academic Press, 2018.`
- **Journal**: `[2] J. K. Author, "Title," *IEEE Trans. Power Syst.*, vol. 15, no. 2, pp. 124–130, Jun. 2020.`
- **Conference**: `[3] M. Smith, "Title," in *Proc. Int. Conf.*, City, Year, pp. 45–50.`
- **Thesis**: `[4] Nguyen Van A, "Title," ĐATN, Khoa Điện-Điện tử, ĐHBK ĐHQG-HCM, 2023.`
- **Website**: `[5] *Title*. [Online]. Available: URL [Accessed: DD-Mon-YYYY].`

---

## 9. Cover Page

Standard layout (top-to-bottom, all centered):

```
[HCMUT logo — centered, ~100 pt wide]

ĐẠI HỌC QUỐC GIA TP. HỒ CHÍ MINH
TRƯỜNG ĐẠI HỌC BÁCH KHOA
[KHOA / BỘ MÔN]
     → 14–16 pt, Bold, ALL CAPS

▼ flex spacer

[REPORT TYPE — e.g. BÁO CÁO THÍ NGHIỆM VI XỬ LÝ]
     → 18 pt, Bold, ALL CAPS

[REPORT TITLE]
     → 22 pt, Bold, ALL CAPS

▼ flex spacer

LỚP [CLASS], NHÓM [GROUP]
GIẢNG VIÊN HƯỚNG DẪN: [Title + Name e.g. TS. Nguyễn Văn Hưởng]
     → 16 pt, Bold

[Group members table: #, Họ và tên, MSSV, Vai trò]
     → 11 pt

▼ flex spacer

[LOCATION], [MONTH/YEAR]
     → 16 pt, Bold
```

Instructor titles in use at HCMUT: **GS.** (Giáo sư), **PGS.** (Phó Giáo sư), **TS.**
(Tiến sĩ), **ThS.** (Thạc sĩ), **KS.** (Kỹ sư). Always prefix the instructor name.

The "fancy" cover style (2 pt border, inset 0.6 cm) is not mandated but not prohibited.
The `hcmut-logo-lockup-vi.png` and `hcmut-logo-lockup-en.png` in `lib/assets/logos/` are
currently unused — they can back a third cover style.

---

## 10. Document Structure (Standard Order)

### For LVTN / Thesis (complete form)
1. Bìa ngoài (outer cover) — no page number printed
2. Phiếu nhiệm vụ luận văn (task sheet) — no page number printed
3. Lời cam đoan (declaration of originality) — Roman i
4. Lời cảm ơn (acknowledgments) — Roman ii
5. Tóm tắt / Abstract — Roman iii
6. Mục lục (table of contents) — Roman iv+
7. Danh mục hình vẽ (list of figures)
8. Danh mục bảng biểu (list of tables)
9. Danh mục ký hiệu và từ viết tắt (nomenclature / abbreviations, if any)
10. **Chương 1...** — Arabic 1, 2, 3, ...
11. Tài liệu tham khảo (references)
12. Phụ lục (appendices)

### For Lab Reports (this template)
Cover → Lời cảm ơn (frontmatter) → ToC / LoF / LoT → main chapters → bibliography
→ Phiếu chấm điểm (backmatter)

---

## 11. Vietnamese-Specific Rules

- **Encoding**: Unicode UTF-8 mandatory. Old VNI or TCVN3 (.VnTime) fonts/encodings are
  explicitly **forbidden**.
- **Standard font**: Times New Roman Unicode. Any Unicode-compliant font is technically
  acceptable, but Times New Roman is by far the safest and most common.
- **Diacritics**: Handled automatically by Unicode fonts; no special rules beyond using Unicode.
- **Line spacing**: FEEE uniquely specifies 1.3× for Vietnamese text, 1.1× for English text
  (most other faculties just say 1.5×).
- **Justification**: Always fully justified. No ragged-right.

---

## 12. What the Existing Template Already Gets Right

| Feature | Status |
|---|---|
| Margins (40/25/40/25 mm) | ✓ |
| Font family (STIX Two Text → Times New Roman) | ✓ |
| Body font size (13 pt) | ✓ |
| Headings style & per-level caps/weight | ✓ |
| Heading numbering (`"1.1.1.1"`, Arabic) | ✓ |
| Paragraph justification & indent (1.25 cm) | ✓ |
| Line spacing (1.3× VI, 1.1× EN) | ✓ |
| Chapter automatic pagebreak | ✓ |
| Citation style (`ieee`) | ✓ |
| Figure caption: bold supplement + italic body, below | ✓ |
| Table caption: above | ✓ |
| Per-chapter figure, table, and equation numbering | ✓ |
| Page numbering zones (Roman front, Arabic body, center + bottom) | ✓ |
| Cover page structure and fields | ✓ |
| Vietnamese + English i18n | ✓ |
| IEEE bibliography | ✓ |
| Draft watermark | ✓ (not mandated, not prohibited) |

---

## 13. Summary of FEEE Style Implementation

All 10 styling gaps identified for FEEE guidelines have been resolved on the `feee` branch:
1. Margins set to 40mm left, 25mm right, 40mm top, 25mm bottom (`lib/state.typ`).
2. Body font size set to 13pt (`lib/state.typ`, `lib/styles.typ`).
3. Justification enabled and first-line indent set to 1.25cm (`lib/styles.typ`, `lib/state.typ`).
4. Line spacing set to 1.3× for Vietnamese and 1.1× for English (`lib/styles.typ`).
5. Heading capitalization and alignment by level (H1 center uppercase bold, H2 uppercase bold, H3 bold, H4 italic) (`lib/styles.typ`).
6. Automatic chapter pagebreak (`show heading.where(level: 1): pagebreak(weak: true)`).
7. Equation numbering chapter-scoped `(1.1)` / `(A.1)` (`lib/utils.typ`, `lib/styles.typ`).
8. Figure and table numbering chapter-scoped (`1.1`) (`lib/styles.typ`).
9. Page number alignment set to `center + bottom` across all zones (`lib/lib.typ`, `lib/styles.typ`).
10. Table caption position set to top (`lib/styles.typ`).

---

## 14. Things FEEE Doesn't Mandate (Template Can Keep)

- Color scheme (not mentioned — purely digital/draft use is fine)
- `codly` syntax highlighting
- `gentle-clues` callout boxes
- Draft watermark
- `minitoc` per-chapter mini table of contents
- Booktabs-style table borders (spec says "clear borders" but doesn't prescribe full grid)
- OKLCH color palette in `state.typ`
