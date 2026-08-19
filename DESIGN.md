---
name: Executive Onyx
colors:
  surface: '#131313'
  surface-dim: '#131313'
  surface-bright: '#393939'
  surface-container-lowest: '#0e0e0e'
  surface-container-low: '#1c1b1b'
  surface-container: '#201f1f'
  surface-container-high: '#2a2a2a'
  surface-container-highest: '#353534'
  on-surface: '#e5e2e1'
  on-surface-variant: '#d0c5af'
  inverse-surface: '#e5e2e1'
  inverse-on-surface: '#313030'
  outline: '#99907c'
  outline-variant: '#4d4635'
  surface-tint: '#e9c349'
  primary: '#f2ca50'
  on-primary: '#3c2f00'
  primary-container: '#d4af37'
  on-primary-container: '#554300'
  inverse-primary: '#735c00'
  secondary: '#adc7ff'
  on-secondary: '#002e68'
  secondary-container: '#4a8eff'
  on-secondary-container: '#00285b'
  tertiary: '#d0cdcd'
  on-tertiary: '#303030'
  tertiary-container: '#b4b2b2'
  on-tertiary-container: '#454544'
  error: '#ffb4ab'
  on-error: '#690005'
  error-container: '#93000a'
  on-error-container: '#ffdad6'
  primary-fixed: '#ffe088'
  primary-fixed-dim: '#e9c349'
  on-primary-fixed: '#241a00'
  on-primary-fixed-variant: '#574500'
  secondary-fixed: '#d8e2ff'
  secondary-fixed-dim: '#adc7ff'
  on-secondary-fixed: '#001a41'
  on-secondary-fixed-variant: '#004493'
  tertiary-fixed: '#e5e2e1'
  tertiary-fixed-dim: '#c8c6c5'
  on-tertiary-fixed: '#1b1b1c'
  on-tertiary-fixed-variant: '#474746'
  background: '#131313'
  on-background: '#e5e2e1'
  surface-variant: '#353534'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
    letterSpacing: -0.01em
  headline-sm:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
    letterSpacing: 0.05em
  label-sm:
    fontFamily: Inter
    fontSize: 11px
    fontWeight: '500'
    lineHeight: 14px
rounded:
  sm: 0.125rem
  DEFAULT: 0.25rem
  md: 0.375rem
  lg: 0.5rem
  xl: 0.75rem
  full: 9999px
spacing:
  container-margin: 20px
  stack-gap: 16px
  element-padding: 12px
  section-padding: 32px
---

## Brand & Style
The design system embodies an "Executive Dark Mode" aesthetic, tailored for high-level oversight and premium employee management. The brand personality is authoritative, discreet, and high-performance. 

The visual style is **Minimalist** with a **Corporate Modern** foundation. It prioritizes information density through high-contrast typography and generous whitespace rather than decorative elements. The UI should evoke a sense of calm control and technical sophistication, utilizing deep charcoal surfaces and sharp, purposeful accents to guide the executive's focus.

## Colors
The palette is rooted in a "Deep Charcoal" ecosystem to reduce eye strain and establish a premium feel.

- **Primary (#D4AF37):** A muted Metallic Gold used sparingly for high-level status indicators, "Premium" features, or critical executive actions.
- **Secondary (#007BFF):** An Electric Blue used for interactive states, primary calls to action, and active navigation markers.
- **Neutral Backgrounds:** The base layer uses `#121212`, while elevated surfaces (cards, modals) use `#1E1E1E`.
- **Accents:** Use ultra-thin borders in a semi-transparent slate grey (`rgba(255, 255, 255, 0.08)`) to define boundaries without adding visual noise.

## Typography
This design system utilizes **Inter** for its exceptional readability in dark environments and its systematic, neutral tone. 

- **Headlines:** Use tighter letter spacing and heavier weights to create a strong visual anchor on the page.
- **Labels:** Small labels use uppercase with slight letter spacing to differentiate them from body text, ideal for metadata and table headers.
- **Readability:** Ensure a minimum contrast ratio of 7:1 for body text against the `#121212` background. Use `White/90%` for primary text and `White/60%` for secondary/dimmed text.

## Layout & Spacing
The layout follows a **Fluid Grid** model optimized for mobile devices. 

- **Margins:** A consistent 20px horizontal margin ensures content does not feel cramped against the screen edges.
- **Rhythm:** Use a strict 4px/8px baseline grid. Stacked elements (like employee cards) should maintain a 16px vertical gap to allow the "Deep Charcoal" background to act as a natural separator.
- **Safe Areas:** Adhere strictly to mobile safe-area insets, particularly for bottom-fixed action bars.

## Elevation & Depth
Hierarchy is conveyed through **Tonal Layers** supplemented by **Ambient Shadows**.

- **Level 0 (Base):** `#121212` - The main application background.
- **Level 1 (Cards):** `#1E1E1E` - Surface for primary content modules. These feature an ultra-thin 1px border (`rgba(255,255,255,0.05)`).
- **Level 2 (Modals/Popovers):** `#2A2A2A` - Higher elevation with a soft, diffused shadow: `0px 8px 24px rgba(0, 0, 0, 0.5)`.
- **Depth Metaphor:** Instead of heavy drop shadows, use subtle inner glows or top-edge highlights (1px) to give components a "machined" or "engraved" professional look.

## Shapes
The shape language is **Soft (0.25rem)**. This provides a modern, refined edge that feels professional without being overly aggressive (sharp) or too casual (pill-shaped).

- **Standard Elements:** Buttons, input fields, and small cards use a 4px radius.
- **Large Containers:** Bottom sheets or large dashboard cards can scale up to `rounded-lg` (8px) to soften the transition between layout sections.

## Components

- **Sophisticated Action Buttons:** Primary buttons use a solid Electric Blue background with white text. For "Executive" actions, use a Ghost button style with a Gold border and Gold text.
- **Elegant Cards:** Cards are strictly flat with no shadow on Level 1. Use a 1px border to separate them from the background. Content inside should be padded with 16px or 20px.
- **Minimal Input Fields:** Fields should have no background (transparent) or a slightly darker-than-surface background. Use a bottom-border only (1px) that glows Electric Blue upon focus.
- **Chips/Status Badges:** Use low-opacity fills (e.g., `rgba(0, 123, 255, 0.1)`) with high-saturation text of the same color for status indicators (e.g., "Active", "On Leave").
- **Employee List Items:** Feature a circular avatar (32px or 40px) with a subtle outer ring in the status color. Metadata should be right-aligned in `label-sm` typography.
- **Key Performance Indicators (KPIs):** Large, bold typography for the metric value, paired with a small sparkline graphic in the primary or secondary color to show trends.