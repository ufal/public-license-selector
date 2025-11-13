# Public License Selector

JQuery-powered wizard for choosing data and software licenses. Ships as modular CoffeeScript source with webpack builds for both browser globals (UMD) and modern bundlers (ESM).

## Live Demo

Use the selector at [https://ufal.github.io/public-license-selector](https://ufal.github.io/public-license-selector) for the most recent build.

## Features

- Guided questionnaire covering data and software licensing paths, with inline explanations and tooltips.
- Searchable license catalogue with badges sourced from `src/data/labels.coffee`.
- History navigation that lets users review and replay previous answers.
- Bundled CSS, icon font, and LESS sources to theme the modal.

## Using as NPM Package

The selector is published to npm as `@ufal/license-selector` and can be installed in your project:

```bash
npm install @ufal/license-selector
```

**Peer dependencies:**
```bash
npm install jquery lodash
```

**Tested command**
```bash
npm install @ufal/license-selector jquery@2.2.4 lodash@3.10.1 --save
```

Continue reading for **development setup**, or skip to [Consuming the Bundles](#consuming-the-bundles) to use the published package.


## Installation

Clone the repo and install dependencies once:

```bash
npm install
```

Build the distributable bundles:

```bash
npm run build     # runs clean + build:umd + build:esm
# or individually
npm run build:umd
npm run build:esm
```

During development, launch the demo with live rebuilds:

```bash
npm start
```

Webpack serves `index.html` and watches the CoffeeScript/LESS sources.

## Consuming the Bundles

### From NPM Package

After installing via `npm install @ufal/license-selector`, the bundles are available in `node_modules/@ufal/license-selector/dist/`:

| File | Description |
| --- | --- |
| `license-selector.umd.js` | Browser-friendly UMD bundle exposing `LicenseSelector`. Expects global `jQuery` and `_` (lodash). |
| `license-selector.esm.js` | Tree-shakeable ESM bundle for modern build pipelines. Expects `jquery` and `lodash` via imports. |
| `license-selector.css` | Stylesheet + icon font references for the modal UI. |

### From Local Build

If you cloned the repo and ran `npm run build`, the same files are in `dist/`.

### UMD Example (Browser)

```html
<link rel="stylesheet" href="node_modules/@ufal/license-selector/dist/license-selector.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<script src="node_modules/@ufal/license-selector/dist/license-selector.umd.js"></script>
<script>
  $(function () {
    $('button#pick-license').licenseSelector({
      showLabels: true,
      onLicenseSelected: function (license) {
        console.log('Selected license:', license);
      }
    });
  });
</script>
```

### ESM Example (Webpack/Vite)

```js
import $ from 'jquery';
import _ from 'lodash';
import '@ufal/license-selector/dist/license-selector.css';
import '@ufal/license-selector/dist/license-selector.esm.js';

$('#pick-license').licenseSelector({
  start: 'YourSoftware',
  onLicenseSelected(license) {
    console.log(license);
  }
});
```

### TypeScript Example

```typescript
import type { LicenseDefinition, LicenseSelectorOptions } from '@ufal/license-selector';

const options: LicenseSelectorOptions = {
  showLabels: true,
  onLicenseSelected: (license: LicenseDefinition) => {
    console.log(license.name, license.url);
  }
};

// jQuery plugin available globally (if loaded via UMD)
const $ = (window as any).jQuery;
$('#pick-license').licenseSelector(options);
```
## From Local Build

`dist/` contains everything you need:

| File | Description |
| --- | --- |
| `license-selector.umd.js` | Browser-friendly UMD bundle exposing `LicenseSelector`. Expects global `jQuery` and `_` (lodash). |
| `license-selector.esm.js` | Tree-shakeable ESM bundle for modern build pipelines. Expects `jquery` and `lodash` via imports. |
| `license-selector.css` | Stylesheet + icon font references for the modal UI. |

### UMD Example

```html
<link rel="stylesheet" href="dist/license-selector.css">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.21/lodash.min.js"></script>
<script src="dist/license-selector.umd.js"></script>
<script>
  $(function () {
    $('button#pick-license').licenseSelector({
      showLabels: true,
      onLicenseSelected: function (license) {
        console.log('Selected license:' license);
      }
    });
  });
</script>
```

### ESM Example

```js
import $ from 'jquery';
import _ from 'lodash';
import 'dist/license-selector.css';
import 'dist/license-selector.esm.js';

$('#pick-license').licenseSelector({
  start: 'YourSoftware',
  onLicenseSelected(license) {
    console.log(license);
  }
});
```

## jQuery Plugin Options

| Option | Type | Default | Notes |
| --- | --- | --- | --- |
| `appendTo` | `string \| HTMLElement \| JQuery` | `'body'` | Parent element for the modal root. |
| `start` | `string` | `'KindOfContent'` | Initial question; see `src/data/questions.coffee`. |
| `showLabels` | `boolean` | `true` | Toggle license badge rendering. |
| `licenseItemTemplate` | `function \| JQuery` | `null` | Custom renderer for `<li>` entries. |
| `licenses` | `Record<string, Partial<LicenseDefinition>>` | `{}` | Deep-merged with `src/data/licenses.coffee`. |
| `questions` | `Record<string, Function>` | `{}` | Deep-merged with `src/data/questions.coffee`. |
| `onLicenseSelected` | `function` | `_.noop` | Fires when the user confirms a license. |

The TypeScript interface definitions live in `index.d.ts` and mirror the table above.

## Customizing Licenses & Decision Flow

- License metadata: `src/data/licenses.coffee`
- Compatibility matrix: `src/data/compatibility.coffee`
- Questionnaire states: `src/data/questions.coffee`
- Tooltip text: `src/helpers/explanations.coffee`

See `docs/extending.md` for step-by-step guidance on adding licenses, extending labels, or branching the wizard logic.

## Architecture Overview

| Module | Responsibility |
| --- | --- |
| `src/index.coffee` | Entry point exporting the selector plus bundled data helpers. |
| `src/core/license-selector.coffee` | Orchestrates modal lifecycle, questions, history, and list state. |
| `src/core/history.coffee` | Manages the navigation stack and tooltips for previous answers. |
| `src/core/question.coffee` | Renders prompts, answers, checkbox options, and validation errors. |
| `src/core/license-list.coffee` | Displays filterable licenses and handles selection state. |
| `src/core/search.coffee` | Header search input wired to the license list filter. |
| `src/core/modal.coffee` | Builds the modal shell and handles responsive sizing. |
| `src/core/tooltip.coffee` | Shared tooltip widget used across the UI. |
| `src/plugins/jquery.coffee` | Registers the `$.fn.licenseSelector` plugin and merges overrides. |
| `src/license-selector.less` & friends | Styles for modal layout, typography, and iconography. |


## Development Workflow

1. Work inside the CoffeeScript/LESS sources under `src/`.
2. Run `npm start` for hot rebuilds and manual testing against `index.html`.
3. Execute `npm run build` before publishing to refresh the assets in `dist/`.
4. Linting is handled via webpack loaders; ensure the dev server logs stay clean.

### Legacy Makefile Commands

The orginal Makefile remains functional if you prefer that workflow:

```bash
make install # installs dependencies via npm
make run     # starts the demo server
make build   # rebuilds distributable assets
```

The release helpers (`make release`, `make release-minor`, `make release-major`) are still available for version tagging automation.

## Used By

- [CLARIN DSpace Repositories](https://github.com/ufal/clarin-dspace) - deployments across Czechia, Italy, Lithuania, Norway, Poland, Slovenia, Spain, Sweden, Brazil.
- [EUDAT B2SHARE](https://b2share.eudat.eu).

Using the selector elsewhere? Open an issue or discussion so we can add your deployment.

## Contributing

- Review `docs/extending.md` before large changes.
- Discuss new features via Github issues/discussions to align on scope.
- Run `npm run build` (and optionally `npm start`) to verify changes locally.
- Submit pull request with clear descriptions of the behaviour affected.

## Authors

- Pawel Kamocki
- Pavel Straňák
- Michal Sedlák

## Disclaimer

This tool does not replace professional legal advice. Consult your legal counsel for authoritative guidance.

## License

[MIT](LICENSE.md) © Institute of Formal and Applied Linguistics, Charles University.
