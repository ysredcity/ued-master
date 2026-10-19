---
name: ued-master
description: 新产品 demo 原型的生成与视觉优化（UEDMaster）。适用于产品还没有成熟设计系统的阶段：直接根据需求生成可交互的 demo 原型，或对已生成的 demo（HTML / 前端页面）做排版、留白、层级、色彩、动效、微交互和响应式的升级，并截图自检、持续迭代。当用户要「做个 demo / 原型 / 高保真页面」「把这个原型优化得更好看 / 更专业」「UI 效果差，帮我改」时使用。已有成熟设计系统（如指定组件库与主题包）的项目，优先使用对应设计系统的 skill。
metadata:
  version: 0.3.0
  upstream: Leonxlnx/taste-skill · skills/redesign-skill（MIT）
---

# UEDMaster

在产品还没有设计系统时，用最少的规则把 demo 原型做到可评审、可演示的品质。规则只做底线，其余交给判断。

## 两种用法

- **从需求生成 demo**：先想清楚页面要让用户完成什么、最重要的一屏是什么，再动手。生成后把下方「Design Audit」当作自检清单，逐项排查后修正。
- **优化已有 demo**：按下方「How This Works」的 Scan → Diagnose → Fix 进行。内容、数据和已有交互默认保留；结构调整只为服务视觉与可用性。**默认保留原有明暗主题**（浅色仍浅色、深色仍深色），用户明确要求时才切换。

**一版还是多版**：默认只做一版完整方案。用户没给视觉参考或改动幅度时（从需求生成、或「整页优化」），先做 2–3 个**首屏小样**让用户选，选定后再做完整版：
- 小样之间的差别放在改动幅度或视觉气质上（如保守收敛 / 标准优化 / 大胆重排），不是只换颜色；每个都遵守品牌色与明暗主题规则。
- 每个小样附一句取舍说明，并标出你推荐哪一个。
- 范围已明确、用户给了方向、或说「直接做」「你来定」时，不停下来，直接做一版。无法等待用户回复时（如自动运行），按「标准优化」幅度做一版，最后说明还有哪些方向可选。

两种用法都要**截图自检**：在浏览器里打开页面，至少看桌面宽屏、窄屏与移动宽度，以及弹层、抽屉、空状态等主要状态；看图找问题、修正、再截图，直到没有明显可提升之处。不凭代码想象效果，不以「没有报错」代替「看起来对」。自检时同时对照 `references/web-baseline.md` 的交付底线（点击区域、移动端输入、状态不只靠颜色、长内容、深色主题等）。

## 品牌强调色（海信青绿）

只定义一组强调色，其余颜色由你按页面需要判断。

| 角色 | 色值 | 用在哪里 |
|---|---|---|
| 品牌强调色 | `#009689`（Tailwind teal-600） | 选中指示、图标、进度条、大块色面 |
| 文字 / 按钮强调色 | `#00786F`（Tailwind teal-700） | 链接文字、白字主按钮 |

- 克制使用：青绿只标这一屏最该被注意或点击的东西（主操作、当前选中、关键进度）。一屏只有一个主操作使用强调色块；标题、标签、普通按钮、数字默认用中性色。截图自检时数一下首屏出现青绿的位置，通常不超过 5–8 处，多了就把次要的改回中性色。
- 不要用青绿替换页面上所有的颜色：多个类别并列（图表系列、行业、分类标签）时用不同色相区分，青绿只给重点那一项；红、橙、绿等状态色保留各自色相，只用于表达状态，不当作装饰色。
- 冷暖平衡：青绿偏冷，中性色不要再染青调，用纯灰或略暖的灰来平衡（这条优先于下方「Tint all grays」）。
- 悬停态可以从这两个色派生；图表色阶也可以派生，但只用于同一系列的深浅。
- 深色背景：不要直接套用这两个值（`#00786F` 在深底上对比度不足 3.5:1）。文字、链接、图标改用提亮的派生色（如 teal-400 `#00D5BE`），主按钮用亮青绿底配深色字；派生后核对对比度：正文 ≥4.5:1，图标与边框 ≥3:1。
- teal-600 在白底上对比度约 3.7:1，不能用于正文文字或白字小按钮；需要文字时换 teal-700（约 5.4:1）。
- 这两个值替代了下方通用规则里「挑一个强调色」的选择。
- 取值理由与对比度计算见 `references/brand-color.md`。

---

<!-- upstream:begin redesign-existing-projects（逐字复用，修改请走 CONTRIBUTING 的上游同步流程） -->
# Redesign Skill

## How This Works

When applied to an existing project, follow this sequence:

1. **Scan** — Read the codebase. Identify the framework, styling method (Tailwind, vanilla CSS, styled-components, etc.), and current design patterns.
2. **Diagnose** — Run through the audit below. List every generic pattern, weak point, and missing state you find.
3. **Fix** — Apply targeted upgrades working with the existing stack. Do not rewrite from scratch. Improve what's there.

## Design Audit

### Typography

Check for these problems and fix them:

- **Browser default fonts or Inter everywhere.** Replace with a font that has character. Good options: `Geist`, `Outfit`, `Cabinet Grotesk`, `Satoshi`. For editorial/creative projects, pair a serif header with a sans-serif body.
- **Headlines lack presence.** Increase size for display text, tighten letter-spacing, reduce line-height. Headlines should feel heavy and intentional.
- **Body text too wide.** Limit paragraph width to roughly 65 characters. Increase line-height for readability.
- **Only Regular (400) and Bold (700) weights used.** Introduce Medium (500) and SemiBold (600) for more subtle hierarchy.
- **Numbers in proportional font.** Use a monospace font or enable tabular figures (`font-variant-numeric: tabular-nums`) for data-heavy interfaces.
- **Missing letter-spacing adjustments.** Use negative tracking for large headers, positive tracking for small caps or labels.
- **All-caps subheaders everywhere.** Try lowercase italics, sentence case, or small-caps instead.
- **Orphaned words.** Single words sitting alone on the last line. Fix with `text-wrap: balance` or `text-wrap: pretty`.

### Color and Surfaces

- **Pure `#000000` background.** Replace with off-black, dark charcoal, or tinted dark (`#0a0a0a`, `#121212`, or a dark navy).
- **Oversaturated accent colors.** Keep saturation below 80%. Desaturate accents so they blend with neutrals instead of screaming.
- **More than one accent color.** Pick one. Remove the rest. Consistency beats variety.
- **Mixing warm and cool grays.** Stick to one gray family. Tint all grays with a consistent hue (warm or cool, not both).
- **Purple/blue "AI gradient" aesthetic.** This is the most common AI design fingerprint. Replace with neutral bases and a single, considered accent.
- **Generic `box-shadow`.** Tint shadows to match the background hue. Use colored shadows (e.g., dark blue shadow on a blue background) instead of pure black at low opacity.
- **Flat design with zero texture.** Add subtle noise, grain, or micro-patterns to backgrounds. Pure flat vectors feel sterile.
- **Perfectly even gradients.** Break the uniformity with radial gradients, noise overlays, or mesh gradients instead of standard linear 45-degree fades.
- **Inconsistent lighting direction.** Audit all shadows to ensure they suggest a single, consistent light source.
- **Random dark sections in a light mode page (or vice versa).** A single dark-background section breaking an otherwise light page looks like a copy-paste accident. Either commit to a full dark mode or keep a consistent background tone throughout. If contrast is needed, use a slightly darker shade of the same palette — not a sudden jump to `#111` in the middle of a cream page.
- **Empty, flat sections with no visual depth.** Sections that are just text on a plain background feel unfinished. Add high-quality background imagery (blurred, overlaid, or masked), subtle patterns, or ambient gradients. Use reliable placeholder sources like `https://picsum.photos/seed/{name}/1920/1080` when real assets are not available. Experiment with background images behind hero sections, feature blocks, or CTAs — even a subtle full-width photo at low opacity adds presence.

### Layout

- **Everything centered and symmetrical.** Break symmetry with offset margins, mixed aspect ratios, or left-aligned headers over centered content.
- **Three equal card columns as feature row.** This is the most generic AI layout. Replace with a 2-column zig-zag, asymmetric grid, horizontal scroll, or masonry layout.
- **Using `height: 100vh` for full-screen sections.** Replace with `min-height: 100dvh` to prevent layout jumping on mobile browsers (iOS Safari viewport bug).
- **Complex flexbox percentage math.** Replace with CSS Grid for reliable multi-column structures.
- **No max-width container.** Add a container constraint (around 1200-1440px) with auto margins so content doesn't stretch edge-to-edge on wide screens.
- **Cards of equal height forced by flexbox.** Allow variable heights or use masonry when content varies in length.
- **Uniform border-radius on everything.** Vary the radius: tighter on inner elements, softer on containers.
- **No overlap or depth.** Elements sit flat next to each other. Use negative margins to create layering and visual depth.
- **Symmetrical vertical padding.** Top and bottom padding are always identical. Adjust optically — bottom padding often needs to be slightly larger.
- **Dashboard always has a left sidebar.** Try top navigation, a floating command menu, or a collapsible panel instead.
- **Missing whitespace.** Double the spacing. Let the design breathe. Dense layouts work for data dashboards, not for marketing pages.
- **Buttons not bottom-aligned in card groups.** When cards have different content lengths, CTAs end up at random heights. Pin buttons to the bottom of each card so they form a clean horizontal line regardless of content above.
- **Feature lists starting at different vertical positions.** In pricing tables or comparison cards, the list of features should start at the same Y position across all columns. Use consistent spacing above the list or fixed-height title/price blocks.
- **Inconsistent vertical rhythm in side-by-side elements.** When placing cards, columns, or panels next to each other, align shared elements (titles, descriptions, prices, buttons) across all items. Misaligned baselines make the layout look broken.
- **Mathematical alignment that looks optically wrong.** Centering by the math doesn't always look centered to the eye. Icons next to text, play buttons in circles, or text in buttons often need 1-2px optical adjustments to feel right.

### Interactivity and States

- **No hover states on buttons.** Add background shift, slight scale, or translate on hover.
- **No active/pressed feedback.** Add a subtle `scale(0.98)` or `translateY(1px)` on press to simulate a physical click.
- **Instant transitions with zero duration.** Add smooth transitions (200-300ms) to all interactive elements.
- **Missing focus ring.** Ensure visible focus indicators for keyboard navigation. This is an accessibility requirement, not optional.
- **No loading states.** Replace generic circular spinners with skeleton loaders that match the layout shape.
- **No empty states.** An empty dashboard showing nothing is a missed opportunity. Design a composed "getting started" view.
- **No error states.** Add clear, inline error messages for forms. Do not use `window.alert()`.
- **Dead links.** Buttons that link to `#`. Either link to real destinations or visually disable them.
- **No indication of current page in navigation.** Style the active nav link differently so users know where they are.
- **Scroll jumping.** Anchor clicks jump instantly. Add `scroll-behavior: smooth`.
- **Animations using `top`, `left`, `width`, `height`.** Switch to `transform` and `opacity` for GPU-accelerated, smooth animation.

### Content

- **Generic names like "John Doe" or "Jane Smith".** Use diverse, realistic-sounding names.
- **Fake round numbers like `99.99%`, `50%`, `$100.00`.** Use organic, messy data: `47.2%`, `$99.00`, `+1 (312) 847-1928`.
- **Placeholder company names like "Acme Corp", "Nexus", "SmartFlow".** Invent contextual, believable brand names.
- **AI copywriting cliches.** Never use "Elevate", "Seamless", "Unleash", "Next-Gen", "Game-changer", "Delve", "Tapestry", or "In the world of...". Write plain, specific language.
- **Exclamation marks in success messages.** Remove them. Be confident, not loud.
- **"Oops!" error messages.** Be direct: "Connection failed. Please try again."
- **Passive voice.** Use active voice: "We couldn't save your changes" instead of "Mistakes were made."
- **All blog post dates identical.** Randomize dates to appear real.
- **Same avatar image for multiple users.** Use unique assets for every distinct person.
- **Lorem Ipsum.** Never use placeholder latin text. Write real draft copy.
- **Title Case On Every Header.** Use sentence case instead.

### Component Patterns

- **Generic card look (border + shadow + white background).** Remove the border, or use only background color, or use only spacing. Cards should exist only when elevation communicates hierarchy.
- **Always one filled button + one ghost button.** Add text links or tertiary styles to reduce visual noise.
- **Pill-shaped "New" and "Beta" badges.** Try square badges, flags, or plain text labels.
- **Accordion FAQ sections.** Use a side-by-side list, searchable help, or inline progressive disclosure.
- **3-card carousel testimonials with dots.** Replace with a masonry wall, embedded social posts, or a single rotating quote.
- **Pricing table with 3 towers.** Highlight the recommended tier with color and emphasis, not just extra height.
- **Modals for everything.** Use inline editing, slide-over panels, or expandable sections instead of popups for simple actions.
- **Avatar circles exclusively.** Try squircles or rounded squares for a less generic look.
- **Light/dark toggle always a sun/moon switch.** Use a dropdown, system preference detection, or integrate it into settings.
- **Footer link farm with 4 columns.** Simplify. Focus on main navigational paths and legally required links.

### Iconography

- **Lucide or Feather icons exclusively.** These are the "default" AI icon choice. Use Phosphor, Heroicons, or a custom set for differentiation.
- **Rocketship for "Launch", shield for "Security".** Replace cliche metaphors with less obvious icons (bolt, fingerprint, spark, vault).
- **Inconsistent stroke widths across icons.** Audit all icons and standardize to one stroke weight.
- **Missing favicon.** Always include a branded favicon.
- **Stock "diverse team" photos.** Use real team photos, candid shots, or a consistent illustration style instead of uncanny stock imagery.

### Code Quality

- **Div soup.** Use semantic HTML: `<nav>`, `<main>`, `<article>`, `<aside>`, `<section>`.
- **Inline styles mixed with CSS classes.** Move all styling to the project's styling system.
- **Hardcoded pixel widths.** Use relative units (`%`, `rem`, `em`, `max-width`) for flexible layouts.
- **Missing alt text on images.** Describe image content for screen readers. Never leave `alt=""` or `alt="image"` on meaningful images.
- **Arbitrary z-index values like `9999`.** Establish a clean z-index scale in the theme/variables.
- **Commented-out dead code.** Remove all debug artifacts before shipping.
- **Import hallucinations.** Check that every import actually exists in `package.json` or the project dependencies.
- **Missing meta tags.** Add proper `<title>`, `description`, `og:image`, and social sharing meta tags.

### Strategic Omissions (What AI Typically Forgets)

- **No legal links.** Add privacy policy and terms of service links in the footer.
- **No "back" navigation.** Dead ends in user flows. Every page needs a way back.
- **No custom 404 page.** Design a helpful, branded "page not found" experience.
- **No form validation.** Add client-side validation for emails, required fields, and format checks.
- **No "skip to content" link.** Essential for keyboard users. Add a hidden skip-link.
- **No cookie consent.** If required by jurisdiction, add a compliant consent banner.

## Upgrade Techniques

When upgrading a project, pull from these high-impact techniques to replace generic patterns:

### Typography Upgrades
- **Variable font animation.** Interpolate weight or width on scroll or hover for text that feels alive.
- **Outlined-to-fill transitions.** Text starts as a stroke outline and fills with color on scroll entry or interaction.
- **Text mask reveals.** Large typography acting as a window to video or animated imagery behind it.

### Layout Upgrades
- **Broken grid / asymmetry.** Elements that deliberately ignore column structure — overlapping, bleeding off-screen, or offset with calculated randomness.
- **Whitespace maximization.** Aggressive use of negative space to force focus on a single element.
- **Parallax card stacks.** Sections that stick and physically stack over each other during scroll.
- **Split-screen scroll.** Two halves of the screen sliding in opposite directions.

### Motion Upgrades
- **Smooth scroll with inertia.** Decouple scrolling from browser defaults for a heavier, cinematic feel.
- **Staggered entry.** Elements cascade in with slight delays, combining Y-axis translation with opacity fade. Never mount everything at once.
- **Spring physics.** Replace linear easing with spring-based motion for a natural, weighty feel on all interactive elements.
- **Scroll-driven reveals.** Content entering through expanding masks, wipes, or draw-on SVG paths tied to scroll progress.

### Surface Upgrades
- **True glassmorphism.** Go beyond `backdrop-filter: blur`. Add a 1px inner border and a subtle inner shadow to simulate edge refraction.
- **Spotlight borders.** Card borders that illuminate dynamically under the cursor.
- **Grain and noise overlays.** A fixed, pointer-events-none overlay with subtle noise to break digital flatness.
- **Colored, tinted shadows.** Shadows that carry the hue of the background rather than using generic black.

## Fix Priority

Apply changes in this order for maximum visual impact with minimum risk:

1. **Font swap** — biggest instant improvement, lowest risk
2. **Color palette cleanup** — remove clashing or oversaturated colors
3. **Hover and active states** — makes the interface feel alive
4. **Layout and spacing** — proper grid, max-width, consistent padding
5. **Replace generic components** — swap cliche patterns for modern alternatives
6. **Add loading, empty, and error states** — makes it feel finished
7. **Polish typography scale and spacing** — the premium final touch

## Rules

- Work with the existing tech stack. Do not migrate frameworks or styling libraries.
- Do not break existing functionality. Test after every change.
- Before importing any new library, check the project's dependency file first.
- If the project uses Tailwind, check the version (v3 vs v4) before modifying config.
- If the project has no framework, use vanilla CSS.
- Keep changes reviewable and focused. Small, targeted improvements over big rewrites.
<!-- upstream:end -->
