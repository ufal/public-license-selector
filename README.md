# Public License Selector

[Read our paper](http://www.lrec-conf.org/proceedings/lrec2016/summaries/880.html) for more details.

JQuery-powered wizard for choosing data and software licenses. Ships as modular CoffeeScript source with webpack builds for both browser globals (UMD) and modern bundlers (ESM).

## Live Demo

Use the selector at [https://ufal.github.io/public-license-selector](https://ufal.github.io/public-license-selector) for the most recent build.

## Features

- Guided questionnaire covering data and software licensing paths, with inline explanations and tooltips.
- Searchable license catalogue with badges sourced from `src/data/labels.coffee`.
- History navigation that lets users review and replay previous answers.
- Bundled CSS, icon font, and LESS sources to theme the modal.

## Decision Flow Visualization

View the auto-generated state graph of the questionnaire:

- Full diagram: [docs/state-graph.md](docs/state-graph.md) (renders on GitHub with Mermaid code blocks)

To regenerate after editing `src/data/questions.coffee`:

```bash
npm run generate-graph
```

## Requirements

**⚠️ BREAKING CHANGE (v0.1.4+):** This version requires **Node.js 18.20.0 or higher**.

- **Node.js:** >= 18.20.0 (LTS recommended)
- **Peer Dependencies:** jQuery >= 2.1.1, lodash >= 2.4.1

**Why Node 18+?** This update modernizes the build toolchain (Webpack 5, Babel 7.28, Cypress 13) and replaces deprecated packages (coffee-script → coffeescript). The package is optimized for compatibility with modern projects like dspace-angular v7.6.1.

## Install

The plugin contains a common set of so-called public licenses which will make your work publicly available.

### Using npm

```bash
npm install @ufal/license-selector
```

**Peer dependencies:**
```bash
npm install jquery lodash
```

**Tested command:**
```bash
npm install @ufal/license-selector jquery@2.2.4 lodash@3.10.1 --save
```

### Manual

The latest version is in the [releases branch](https://github.com/ufal/public-license-selector/tree/releases).
- [Javascript](https://raw.githubusercontent.com/ufal/public-license-selector/releases/license-selector.js)
- [CSS](https://raw.githubusercontent.com/ufal/public-license-selector/releases/license-selector.css)

The plugin requires [Lo-Dash](http://lodash.com/) or [Underscore](http://underscorejs.org/) utility library.

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

## Testing

Automated end-to-end tests verify the GitHub Pages deployment after each release:

```bash
npm test              # Run tests in headless mode
npm run test:open     # Open Cypress interactive test runner
npm run test:headed   # Run tests with visible browser
```

Tests cover:
- Page load and asset loading (jQuery, lodash, CSS)
- Modal auto-open behavior
- Questionnaire navigation (Data/Software paths)
- License selection and display
- Responsive design and accessibility
- Performance benchmarks

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

## Example: Customizing Licenses with `licenses` Option

A list of licenses that will get merged to the predefined licenses. The merge is done by [`_.merge`](https://lodash.com/docs#merge) so you can use it to add new licenses or to change configuration of the predefined licenses.

```js
$('.selector').licenseSelector({
  licenses: {
    'abc-license': {
      name: 'NEW license',
      priority: 1,
      available: true,
      url: 'http://www.example.com/new-license',
      description: 'This is new license inserted as a test',
      categories: ['data', 'new'],
      template: function($el, license, selectFunction) {
        var h = $('<h4 />').text(license.name);
        h.append($('<a/>').attr({
          href: license.url,
          target: '_blank'
        }));
        $el.append(h);
        $el.append('<p>Custom template function</p>');
        $el.append(
          $('<button/>')
            .append('<span>Click here to select license</span>')
            .click(selectFunction)
        );
      }
    },
    'cc-by': {
      description: 'Modified description ...',
      cssClass: 'featured-license'
    },
    'lgpl-3': {
      available: false // hide the LGPL 3 license
    }
  }
});
```

### License Attributes

When customizing licenses via the `licenses` option, each license object can have the following attributes:

- `string` **key** - The hash key (will be automatically added)
- `string` **name** - Full name of the license
- `bool` **available** - Flag whether the license is visible in the license list
- `unsigned int` **priority** - Sort priority (lower means higher in the license list)
- `string` **url** - Url pointing to the license full text
- `string` **description** - A short description of the license
- `string` **cssClass** - Custom CSS class set on `<li>` element
- `function|jQuery` **template** - Template used for custom format
- `array[string]` **categories** - A list of arbitrary category names used for filtering in the questions
- `array[string]` **labels** - A list of labels that will be shown for the license. Each label has a picture or special css style connected.

## Available Licenses

List of licenses that can be chosen with default settings.

| License name | URL |
| --- | --- |
| Affero General Public License 3 (AGPL-3.0) | http://opensource.org/licenses/AGPL-3.0 |
| Apache License 2 | http://www.apache.org/licenses/LICENSE-2.0 |
| Artistic License 1.0 | http://opensource.org/licenses/Artistic-Perl-1.0 |
| Artistic License 2.0 | http://opensource.org/licenses/Artistic-2.0 |
| Common Development and Distribution License (CDDL-1.0) | http://opensource.org/licenses/CDDL-1.0 |
| Creative Commons Attribution (CC-BY) | http://creativecommons.org/licenses/by/4.0/ |
| Creative Commons Attribution-NoDerivs (CC-BY-ND) | http://creativecommons.org/licenses/by-nd/4.0/ |
| Creative Commons Attribution-NonCommercial (CC-BY-NC) | http://creativecommons.org/licenses/by-nc/4.0/ |
| Creative Commons Attribution-NonCommercial-NoDerivs (CC-BY-NC-ND) | http://creativecommons.org/licenses/by-nc-nd/4.0/ |
| Creative Commons Attribution-NonCommercial-ShareAlike (CC-BY-NC-SA) | http://creativecommons.org/licenses/by-nc-sa/4.0/ |
| Creative Commons Attribution-ShareAlike (CC-BY-SA) | http://creativecommons.org/licenses/by-sa/4.0/ |
| Eclipse Public License 1.0 (EPL-1.0) | http://opensource.org/licenses/EPL-1.0 |
| GNU General Public License 2 or later (GPL-2.0) | http://opensource.org/licenses/GPL-2.0 |
| GNU General Public License 3 (GPL-3.0) | http://opensource.org/licenses/GPL-3.0 |
| GNU Library or "Lesser" General Public License 2.1 or later (LGPL-2.1) | http://opensource.org/licenses/LGPL-2.1 |
| GNU Library or "Lesser" General Public License 3.0 (LGPL-3.0) | http://opensource.org/licenses/LGPL-3.0 |
| Mozilla Public License 2.0 | http://opensource.org/licenses/MPL-2.0 |
| Public Domain Dedication (CC Zero) | http://creativecommons.org/publicdomain/zero/1.0/ |
| Public Domain Mark (PD) | http://creativecommons.org/publicdomain/mark/1.0/ |
| The BSD 2-Clause "Simplified" or "FreeBSD" License | http://opensource.org/licenses/BSD-2-Clause |
| The BSD 3-Clause "New" or "Revised" License (BSD) | http://opensource.org/licenses/BSD-3-Clause |
| The MIT License (MIT) | http://opensource.org/licenses/mit-license.php |

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

- Review [docs/extending.md](docs/extending.md) before large changes.
- Discuss new features via Github issues/discussions to align on scope.
- Run `npm run build` (and optionally `npm start`) to verify changes locally.
- Submit pull request with clear descriptions of the behaviour affected.

## Authors

- Pawel Kamocki
- Pavel Straňák
- Michal Sedlák

## Attribution

Descriptions for some licenses taken from (or inspired by) descriptions at [tldrLegal](https://tldrlegal.com).

## Disclaimer

This tool does not replace professional legal advice. Consult your legal counsel for authoritative guidance.

## License

[MIT](LICENSE.md) © Institute of Formal and Applied Linguistics, Charles University.
