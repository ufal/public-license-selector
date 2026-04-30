# Refactored by Claude — codebase modernization log

This document summarizes what was changed in this repository, why it was changed, and how to use/verify the modernized build.

> Goal stated by maintainer: **a simple and easily manageable solution with as few dependencies as possible**.

---

## Executive summary

This repo started as a **jQuery plugin/library** implemented in **CoffeeScript + Less**, built with **Webpack + Babel + loaders**, and using **Lodash** in runtime logic.

The modernization work moved the implementation to **TypeScript + vanilla DOM + plain CSS**, replaced the build pipeline with **esbuild**, removed unused/runtime dependencies (notably `node-forge`), and made **jQuery integration optional** (a separate bundle).

**Dependency outcome**:

- Runtime deps: **1 → 0**
- Peer deps: **2 → 1 (optional)**
- Dev deps: **~18 → 3**

---

## What the project is

`@ufal/license-selector` is a UI component for selecting licenses for software or data. It provides:

- A modal wizard (questionnaire)
- Search/filter of license list
- History/back-forward navigation
- A data-driven decision tree (`questions` + `licenses` + compatibility matrix)

Originally it was distributed as:

- `dist/license-selector.umd.js` (browser/script tag, external jQuery + lodash)
- `dist/license-selector.esm.js` (bundler consumers)

---

## High-level migration strategy

1. **Understand the architecture** (modules, data flow, state machine)
2. **Eliminate dead/obsolete tech** (CoffeeScript, Less pipeline, Webpack loader chain)
3. **Preserve behavior** (same wizard logic / compatibility matrix / DOM structure as much as feasible)
4. **Minimize dependencies** (native JS instead of Lodash; remove unused `node-forge`)
5. **Keep migration options**:
   - Vanilla JS is the default
   - jQuery plugin remains available as an optional integration

---

## Notable findings before refactor

### 1) `node-forge` was unused

`node-forge` was present in `dependencies` but **not imported anywhere** in the source code.

Action: removed from runtime dependencies (by replacing `package.json`).

### 2) Core logic depended on Lodash mostly for basic utilities

The original code used Lodash for:

- deep clone, merge, defaults
- array predicates (`any`, `all`)
- sorting, flattening

Most of this is straightforward in modern JS.

Action: removed Lodash usage entirely.

### 3) CoffeeScript and Less created a heavy build toolchain

CoffeeScript + Less forced:

- Webpack configuration + many loaders
- Babel transpilation

Action: replaced with TypeScript (compiled by esbuild) and plain CSS.

---

## What changed (by area)

### A) Language: CoffeeScript → TypeScript

**Removed:**

- `src/core/*.coffee`
- `src/data/*.coffee`
- `src/helpers/*.coffee`
- `src/plugins/jquery.coffee`
- `src/index.coffee`

**Added/rewritten (TypeScript):**

- `src/LicenseSelector.ts`
- `src/ui/Modal.ts`
- `src/ui/Question.ts`
- `src/ui/LicenseList.ts`
- `src/ui/Search.ts`
- `src/ui/History.ts`
- `src/ui/Tooltip.ts`
- `src/helpers/explanations.ts`
- `src/data/licenses.ts`
- `src/data/questions.ts`
- `src/data/compatibility.ts`
- `src/data/labels.ts`

**Why:**

- CoffeeScript 1.x is effectively unmaintained and unfamiliar to many contributors.
- TypeScript improves maintainability and makes the state + option/answer objects explicit.

---

### B) Runtime dependencies: removed Lodash

The original files imported Lodash in nearly every module. The rewrite uses:

- `Array.prototype.filter / map / some / every / flat`
- `Object.assign / spread`
- `structuredClone` (for state/history snapshots)

**Why:**

- Eliminates a runtime dependency for a small set of utilities.
- Reduces bundle surface area and supply-chain risk.

---

### C) jQuery: optional integration instead of core dependency

**Core (`dist/license-selector.esm.js` / `dist/license-selector.umd.js`):**

- Vanilla DOM code only.

**Optional integration:**

- `src/jquery-integration.ts` → built into `dist/license-selector.jquery.js`

This registers `$.fn.licenseSelector` if `window.$` is present.

**Why:**

- Modern apps often do not use jQuery.
- Existing adopters can still use the jQuery plugin without coupling the core.

---

### D) Styling: Less → plain CSS

**Removed:**

- `src/license-selector.less`
- `src/modal.less`
- `src/tooltip.less`
- `src/variables.less`
- `src/mixins.less`

**Added:**

- `src/styles.css` → copied to `dist/license-selector.css`

**Icon font:**

- The original icon font is no longer used (the navigation icons are implemented via CSS `content:` arrows).
- The old font assets were removed from `src/fonts/`.

**Why:**

- Less required a build pipeline and loaders.
- Plain CSS is easier to maintain and requires no tooling.

---

### E) Build system: Webpack → esbuild

**Removed:**

- `webpack.config.js`
- `babel.config.json`

**Added:**

- `build.mjs`

**Outputs:**

- `dist/license-selector.esm.js`
- `dist/license-selector.umd.js`
- `dist/license-selector.jquery.js`
- `dist/license-selector.css`
- Copies image assets under `dist/img/licenses/`

**Why:**

- esbuild provides fast bundling with minimal configuration.
- Replaces a multi-loader Webpack pipeline.

---

### F) CI / Cypress

The repo already included Cypress E2E tests.

- `cypress.config.js` was restored (it was removed while cleaning old config files).

**Note:** the Cypress tests currently target the deployed GitHub Pages site by default.

---

### G) Demo page updated

`index.html` was updated to show:

- Vanilla usage via `type="module"` import from `dist/license-selector.esm.js`
- Optional jQuery usage via dynamic import of `dist/license-selector.jquery.js`

---

## Package.json changes

### New dependency posture

- `dependencies`: **empty**
- `peerDependencies`: `jquery >= 3.0.0` marked optional
- `devDependencies`: `esbuild`, `typescript`, `cypress`

### Exports

`package.json` uses an `exports` map:

- `@ufal/license-selector` → ESM/UMD entrypoints
- `@ufal/license-selector/jquery` → optional jQuery integration entry

---

## Files added / removed (quick list)

### Added

- `build.mjs`
- `src/**/*.ts` (the new implementation)
- `src/styles.css`
- `dist/*` outputs produced by build

### Removed

- CoffeeScript sources under `src/core`, `src/data`, `src/helpers`, `src/plugins`
- Less sources (`src/*.less`)
- Webpack/Babel configs
- Font assets under `src/fonts/`

---

## How to build

```bash
npm install
npm run build
```

Build output will be in `dist/`.

---

## How to run the demo locally

1. Build:

```bash
npm run build
```

2. Open `index.html` in a browser.

If you prefer to serve it via a local server:

```bash
npx serve .
```

Then visit the shown URL and open `/index.html`.

---

## Public API (intended)

### Vanilla

```js
import { LicenseSelector, LicenseDefinitions, QuestionDefinitions } from '@ufal/license-selector'

new LicenseSelector(LicenseDefinitions, QuestionDefinitions, {
  appendTo: '#some-container',
  onLicenseSelected: (license) => console.log(license),
})
```

### jQuery (optional)

```js
import '@ufal/license-selector/jquery'

$('#some-element').licenseSelector({
  onLicenseSelected: (license) => console.log(license),
})
```

---

## Verification steps performed

- Installed dependencies (`npm install`)
- Built with esbuild (`npm run build`)
- Verified `dist/` contains:
  - `license-selector.esm.js`
  - `license-selector.umd.js`
  - `license-selector.jquery.js`
  - `license-selector.css`
  - `img/licenses/*`

---

## Notes / follow-ups worth considering

These are intentionally not automatically changed further (to avoid scope creep), but may be worth addressing next:

1. **Cypress tests** currently point at the deployed site by default; consider adding a local test mode that serves `dist/`.
2. **TypeScript type coverage** in `index.d.ts` is kept minimal; if you want stronger typing, generate `.d.ts` from TS source (tsc declaration emit).
3. Consider raising the baseline to `structuredClone` support if older browsers must be supported (or replace with a small deep-clone helper).
4. The `scripts/generate-state-graph.js` parser was designed for CoffeeScript; it now points at `questions.ts`, but may need additional work to parse TS reliably.

---

## Change log (short)

- Migrated core and data modules from CoffeeScript to TypeScript.
- Replaced Lodash and jQuery usage in core with vanilla JS.
- Converted Less to plain CSS and removed the icon font.
- Replaced Webpack+Babel build pipeline with a minimal esbuild script.
- Produced separate optional jQuery integration bundle.
- Updated demo HTML and TypeScript typings.
