
<!-- TITLE/ -->

# License Selector

<!-- /TITLE -->


<!-- DESCRIPTION/ -->

JQuery plugin for easy selection of various licenses

<!-- /DESCRIPTION -->

## Demo

[See demo](https://ufal.github.io/lindat-license-selector)


## Install

Download the latest version of the plugin from the repository
([Javascript](https://raw.githubusercontent.com/ufal/lindat-license-selector/master/lib/license-selector.js)
and [CSS](https://raw.githubusercontent.com/ufal/lindat-license-selector/master/lib/license-selector.css))

The plugin requires [Lo-Dash](http://lodash.com/) or [Underscore](http://underscorejs.org/) utility library.

## Usage

    <link rel="stylesheet" href="license-selector.css">
    <script type="text/javascript" src="license-selector.js"></script>
    <script type="text/javascript">
      $(function() {
        'use strict';
        $('selector').licenseSelector({onLicenseSelected: callback});
      });
    </script>


## Development

    > git clone https://github.com/ufal/lindat-license-selector.git
    > cd lindat-license-selector
    > npm install
    > grunt start

## Attribution

Descriptions for some licenses taken from (or inspired by) descriptions at [tldrLegal](https://tldrlegal.com).

<!-- LICENSE/ -->

## License

Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT license](http://creativecommons.org/licenses/MIT/)

Copyright &copy; 2014 Institute of Formal and Applied Linguistics (http://ufal.mff.cuni.cz)

<!-- /LICENSE -->
