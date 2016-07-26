
<!-- TITLE/ -->

# Public License Selector

[![Build Status](https://travis-ci.org/ufal/public-license-selector.svg?branch=master)](https://travis-ci.org/ufal/public-license-selector)

<!-- /TITLE -->


<!-- DESCRIPTION/ -->

JQuery plugin for easy selection of public licenses. 

[Read our paper](http://www.lrec-conf.org/proceedings/lrec2016/summaries/880.html) for more details.

<!-- /DESCRIPTION -->

## Give It a Try

Use the selector [directly on Github](https://ufal.github.io/public-license-selector). You can link to this to always use our latest version.


## Install

The plugin contains common set of so called public licenses which will make your work publicly available.


### Using Bower

```
bower install public-license-selector --save
```

### Manual

The latest version is in the [releases branch](https://github.com/ufal/public-license-selector/tree/releases).
- [Javascript](https://raw.githubusercontent.com/ufal/public-license-selector/releases/license-selector.js)
- [CSS](https://raw.githubusercontent.com/ufal/public-license-selector/releases/license-selector.css)

The plugin requires [Lo-Dash](http://lodash.com/) or [Underscore](http://underscorejs.org/) utility library.


## Usage
```.html
<link rel="stylesheet" href="license-selector.css">
<script type="text/javascript" src="license-selector.js"></script>
<script type="text/javascript">
  $(function() {
    'use strict';
    $('selector').licenseSelector({ ...options... });
  });
</script>
```


### Options

#### onLicenseSelected

Callback to action that should happen after the license is selected. Receives selected license as a first argument.

```.javascript
onLicenseSelected : function (license) {
    $('body').append($('<pre></pre>').text(JSON.stringify(license, null, 4)))
    console.log(license)
}
```

#### licenseItemTemplate (function|jQuery)

A template function to customize license display in the license list. See the example below. The function takes three arguments:

1. jQuery object of an `<li>` element
2. `license` object with attributes defined bellow
3. select function - the function that actually does the license selection. Can be used as `onClick` handler

#### appendTo

JQuery selector specifying a html element where license selector should be attached. Default is `'body'`.

#### start

Name of the starting question. See to sources for the full list of names. Here are the most useful:

- **'KindOfContent'** (default) is asking about the kind of content (Software or Data)
- **'DataCopyrightable'** jumps straight to data licensing. Use this as a `start` if you want to choose only licenses for data.
- **'YourSoftware'** jumps to software licensing. The same as above but for software.

#### showLabels (bool)

Whether or not to show labels for each license.

#### licenses

A list of licenses that will get merged to the predefined license. The merge is done by [`_.merge`](https://lodash.com/docs#merge) so you can use it to add new licenses or to change configuration of the predefined licenses.

```.javascript
.licenseSelector({
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
);
```

##### License Attributes

- `string` **key** - The hash key (will be automatically added)
- `string` **name** - Full name of the license
- `bool` **available** - Flag whether the license is visible in the license list
- `unsigned int` **priority** - Sort priority (lower means higher in the license list)
- `string` **url** - Url pointing to the license full text
- `string` **description** - A short description of the license
- `string` **cssClass** - Custom CSS class set on `<li>` element
- `function|jQuery` **template** - Template used for custom format
- `array[string]` **categories** - A list of arbitrary category names used for filtering in the questions
- `array[string]` **labels** - A list of labels that will be shown for the license. Each labels has a picture or special css style connected so this is not completely arbitrary.

## Available Licenses

List of licenses that can be chosen in with default settings.

|License name | URL |
|-------------|-----|
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

## Development

Node environment is not required but strongly recommended for the development

1. Install Node
    
        curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
        nvm install stable
        nvm use stable

2. Clone repository
    
        git clone https://github.com/ufal/public-license-selector.git
        cd public-license-selector
        make install

4. Start development server
    
        make run
        
## Making new release

| Task                 | Version                                |
|----------------------|----------------------------------------|
| make release         | v0.0.1 -> v0.0.2 + commit + tag + push |
| make release-minor   | v0.0.1 -> v0.1.0 + commit + tag + push |
| make release-major   | v0.0.1 -> v1.0.1 + commit + tag + push |
    
## Authors

- Pawel Kamocki <kamocki@ids-mannheim.de>
- Pavel Straňák <stranak@ufal.mff.cuni.cz>
- Michal Sedlák <sedlak@ufal.mff.cuni.cz>

## Attribution

Descriptions for some licenses taken from (or inspired by) descriptions at [tldrLegal](https://tldrlegal.com).

## Warning / Disclaimer

You must not rely on the information from License Selector as an alternative to legal advice from your attorney or other professional legal services provider.   

<!-- LICENSE/ -->

## License

Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT license](http://creativecommons.org/licenses/MIT/)

Copyright &copy; 2015 Institute of Formal and Applied Linguistics (http://ufal.mff.cuni.cz)

<!-- /LICENSE -->
