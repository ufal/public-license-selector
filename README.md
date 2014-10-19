
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
        $('selector').licenseSelector({ ...options... });
      });
    </script>

### Options

#### `onLicenseSelected`

Callback to action that should happen after the license is selected. Receives selected license as a first argument.

    onLicenseSelected : function (license) {
        $('body').append($('<pre></pre>').text(JSON.stringify(license, null, 4)))
        console.log(license)
    }

#### `appendTo`

JQuery selector specifying a html element where license selector should be attached. Default is `'body'`.

#### `start`

Name of the starting question. See to sources for the full list of names. Here are the most useful:

- **'KindOfContent'** (default) is asking about the kind of content (Software or Data)
- **'DataCopyrightable'** jumps straight to data licensing. Use this as a `start` if you want to choose only licenses for data.
- **'YourSoftware'** jumps to software licensing. The same as above but for software.

#### `licenses`

A list of licenses that will get merged to the predefined license. The merge is done by [`_.merge`](https://lodash.com/docs#merge) so you can use it to add new licenses or to change configuration of the predefined licenses.

    .licenseSelector({
        licenses: {
          'abc-license': {
            name: 'NEW license',
            priority: 1,
            available: true,
            url: 'http://www.example.com/new-license',
            description: 'This is new license inserted as a test',
            categories: ['data', 'new']
          },
          'cc-by': {
            description: 'Modified description ...'
          },
          'lgpl-3': {
            available: false // hide the LGPL 3 license
          }
        }
    );

##### License Attributes

- **`string`** `key` - The hash key (will be automatically added)
- **`string`** `name` - Full name of the license
- **`bool`** `available` - Flag whether the license is visible in the license list
- **`unsigned int`** `priority` - Sort priority (lower means higher in the license list)
- **`string`** `url` - Url pointing to the license full text
- **`string`** `description` - A short description of the license
- **`array[string]`** `categories` - A list of arbitrary category names used for filtering in the questions

## Development

Node environment is not required but strongly recommended for the development

1. Install Node
    
        curl https://raw.githubusercontent.com/creationix/nvm/v0.17.2/install.sh | bash
        nvm install stable
        nvm use stable

2. Clone repository
    
        git clone https://github.com/ufal/lindat-license-selector.git
        cd lindat-license-selector
        npm install

3. Start development server
    
        grunt start
    

## Attribution

Descriptions for some licenses taken from (or inspired by) descriptions at [tldrLegal](https://tldrlegal.com).

<!-- LICENSE/ -->

## License

Licensed under the incredibly [permissive](http://en.wikipedia.org/wiki/Permissive_free_software_licence) [MIT license](http://creativecommons.org/licenses/MIT/)

Copyright &copy; 2014 Institute of Formal and Applied Linguistics (http://ufal.mff.cuni.cz)

<!-- /LICENSE -->
