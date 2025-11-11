# Extending Public License Selector

This guide walks through the common customisations: adding or modifying license entries and updating the decision tree that powers the wizard. For an overview of the modern build workflow and bundle formats, see the “Modern Build & Usage” section in the root [`README.md`](../README.md).

---

## Prerequisites
- Node.js environment (the repo already uses npm + webpack 5).
- Familiarity with CoffeeScript (all source modules live under `src/`).
- Install dependencies once via:
  ```bash
  npm install
  ```

After making changes, regenerate bundles and test locally:
```bash
npm run build   # produces dist/license-selector.{umd,esm}.js + css
npm start       # serves ci/index.html for interactive testing
```

If you consume the plugin elsewhere, copy the refreshed files from `dist/` into your application (see README for integration tips).

---

## Add or Modify a License
Static license data is defined in `src/data/licenses.coffee`. Each entry looks like:
```coffee
'cc-by':
  name: 'Creative Commons Attribution (CC-BY)'
  priority: 1
  available: true
  url: 'http://creativecommons.org/licenses/by/4.0/'
  description: '...'
  categories: ['public', 'data', 'by']
  labels: ['public', 'cc', 'by', 'opendata']
```

1. **Add the definition**
   - Append a new key under `LicenseDefinitions` with the properties above.
   - Use `available: true` to show it by default, or `false` to hide it until triggered.
   - `priority` controls ordering (lower = earlier in the list).
   - `categories` drive filtering in the question flow.
   - `labels` should map to keys in `src/data/labels.coffee` (see step 3).

2. **Update compatibility (optional)**
   - For software licenses participating in compatibility checks, edit `src/data/compatibility.coffee`:
     - Add the key to `columns`.
     - Add a corresponding row in `table`, following the existing true/false matrix.

3. **Add label metadata (optional)**
   - Need a new badge/icon? Extend `src/data/labels.coffee`:
     ```coffee
     mylabel:
       title: 'My Custom Label'
       itemClass: 'ls-icon-mylabel'
       text: 'Shown text'
     ```
   - Update styles (e.g., in `src/license-selector.less`) if you introduce new classes.

4. **Rebuild and test** (see commands above). Confirm the license appears in the demo with the correct labels and behaviour.

---

## Customise the Question Flow
Decision logic lives in `src/data/questions.coffee`. Each function represents a wizard state and uses a small DSL of helper methods.

### Key helpers
- `@question(text)` — sets the prompt and resets answers/options.
- `@answer(label, handler, disabledFn?)` — adds a button; handler executes within the `LicenseSelector` instance.
- `@option(licenses, handler?)` — presents checkboxes tied to license categories.
- `@license(licenseKeys...)` — marks the flow as finished and populates the list.
- `@goto('StateName')` — transitions to another question.
- `@cantlicense(message)` — displays an error.
- `@include/@exclude/@has` — filtering helpers that operate on categories.

### Adding a new branch
```coffee
MyCustomStep: ->
  @question 'Do you want to expose beta licenses?'
  @answer 'Yes', ->
    @include 'beta'
    @license()
  @answer 'No', ->
    @exclude 'beta'
    @license()
```

After adding a state:
1. Link to it via `@goto 'MyCustomStep'` from another state.
2. Ensure every path ends in `@license()`, `@cantlicense()`, or loops back with `@goto` so the wizard doesn’t stall.
3. Rebuild and walk through the flow in the dev server.

### Tips
- Keep states concise. Extract helper functions if logic repeats.
- Use the history tooltip in the demo to validate summaries.
- Follow existing patterns (e.g., `LicenseInteropData`, `Copyleft`) when in doubt.

---

## Rebuilding & Verifying
After any change:
```bash
npm run build
npm start
```
- Visit the dev server (webpack opens a tab) and interact with every branch.
- Verify new licenses show correctly and branch conditions behave as expected.
- Check the console for runtime errors.

When satisfied, copy the updated artifacts from `dist/` into downstream projects (UMD, ESM, CSS) as described in the README.

---

## Related Resources
- [`README.md`](../README.md) — contains both legacy information and the modern build overview.
- Demo source: [`../ci/index.html`](../ci/index.html) — useful for showcasing or testing specific flows.

Feel free to update this guide as new best practices emerge.
