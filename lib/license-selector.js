(function() {
  var EVENT_NS, History, LicenseCompatibility, LicenseDefinitions, LicenseList, LicenseSelector, Modal, N, Question, QuestionDefinitions, Search, Y,
    __slice = [].slice;

  EVENT_NS = 'license-selector';

  LicenseDefinitions = {
    'cc-public-domain': {
      name: 'Public Domain Mark (PD)',
      priority: 1,
      available: true,
      url: 'http://creativecommons.org/publicdomain/mark/1.0/',
      description: "The work identified as being free of known restrictions under copyright law, including all related and neighboring rights.",
      categories: ['data', 'software', 'public-domain']
    },
    'cc-zero': {
      name: 'Public Domain Dedication (CC Zero)',
      priority: 1,
      available: true,
      url: 'http://creativecommons.org/publicdomain/zero/1.0/',
      description: 'CC Zero enables scientists, educators, artists and other creators and owners of copyright- or database-protected content to waive those interests in their works and thereby place them as completely as possible in the public domain, so that others may freely build upon, enhance and reuse the works for any purposes without restriction under copyright or database law.',
      categories: ['data', 'public-domain']
    },
    'pddl': {
      name: 'Open Data Commons Public Domain Dedication and License (PDDL)',
      priority: 1,
      available: false,
      url: 'http://opendatacommons.org/licenses/pddl/summary/',
      description: 'This license is meant to be an international, database-specific equivalent of the public domain. You cannot relicense or sublicense any database under this license because, like the public domain, after dedication you no longer own any rights to the database.',
      categories: ['data', 'public-domain']
    },
    'cc-by': {
      name: 'Creative Commons Attribution (CC-BY)',
      priority: 1,
      available: true,
      url: 'http://creativecommons.org/licenses/by/3.0/',
      description: 'This is the standard creative commons license that gives others maximum freedom to do what they want with your work.',
      categories: ['data', 'by']
    },
    'odc-by': {
      name: 'Open Data Commons Attribution License (ODC-By)',
      priority: 1,
      available: false,
      url: 'http://opendatacommons.org/licenses/by/summary/',
      description: '',
      categories: ['data', 'by']
    },
    'cc-by-sa': {
      name: 'Creative Commons Attribution-ShareAlike (CC-BY-SA)',
      priority: 1,
      available: true,
      url: 'http://creativecommons.org/licenses/by-sa/3.0/',
      description: 'This creative commons license is very similar to the regular Attribution license, but requires you to release all derivative works under this same license.',
      categories: ['data', 'by', 'sa']
    },
    'odbl': {
      name: 'Open Data Commons Open Database License (ODbL)',
      priority: 1,
      available: false,
      url: 'http://opendatacommons.org/licenses/odbl/summary/',
      description: 'A copyleft license used by OpenStreetMap and others with very specific terms designed for databases.',
      categories: ['data', 'by', 'sa']
    },
    'cc-by-nd': {
      name: 'Creative Commons Attribution-NoDerivs (CC-BY-ND)',
      priority: 1,
      available: true,
      url: 'http://creativecommons.org/licenses/by-nd/3.0/',
      description: 'The no derivatives creative commons license is straightforward; you can take a work released under this license and re-distribute it but you cannot change it.',
      categories: ['data', 'by', 'nd']
    },
    'cc-by-nc': {
      name: 'Creative Commons Attribution-NonCommercial (CC-BY-NC)',
      priority: 1,
      available: true,
      url: 'http://creativecommons.org/licenses/by-nc/3.0/',
      description: 'A creative commons license that bans commercial use.',
      categories: ['data', 'by', 'nc']
    },
    'cc-by-nc-sa': {
      name: 'Creative Commons Attribution-NonCommercial-ShareAlike (CC-BY-NC-SA)',
      priority: 1,
      available: true,
      url: 'http://creativecommons.org/licenses/by-nc-sa/3.0/',
      description: 'A creative commons license that bans commercial use and requires you to release any modified works under this license.',
      categories: ['data', 'by', 'nc', 'sa']
    },
    'cc-by-nc-nd': {
      name: 'Creative Commons Attribution-NonCommercial-NoDerivs (CC-BY-NC-ND)',
      priority: 1,
      available: true,
      url: 'http://creativecommons.org/licenses/by-nc-nd/3.0/',
      description: 'The most restrictive creative commons license. This only allows people to download and share your work for no commercial gain and for no other purposes.',
      categories: ['data', 'by', 'nc', 'nd']
    },
    'perl-artistic-1': {
      name: 'Artistic License 1.0',
      priority: 7,
      available: true,
      url: 'http://opensource.org/licenses/Artistic-Perl-1.0',
      description: 'NOTE: This license has been superseded by the Artistic License, Version 2.0. This is a license for software packages with the intent of giving the original copyright holder some measure of control over his software while still remaining open source. It is flexible and allows you to distribute or sell modified versions as long as you fulfill one of various conditions. Look at section 4 in the full text for a better explanation.',
      categories: ['software', 'perl']
    },
    'perl-artistic-2': {
      name: 'Artistic License 2.0',
      priority: 8,
      available: true,
      url: 'http://dev.perl.org/licenses/artistic.html',
      description: 'This is a license for software packages with the intent of giving the original copyright holder some measure of control over his software while still remaining open source. It is flexible and allows you to distribute or sell modified versions as long as you fulfill one of various conditions. Look at section 4 in the full text for a better explanation.',
      categories: ['software', 'perl']
    },
    'gpl-2+': {
      name: 'GNU General Public License 2 or later (GPL-2.0)',
      priority: 10,
      available: true,
      url: 'http://opensource.org/licenses/GPL-2.0',
      description: 'You may copy, distribute and modify the software as long as you track changes/dates of in source files and keep all modifications under GPL. You can distribute your application using a GPL library commercially, but you must also disclose the source code.',
      categories: ['software', 'gpl', 'copyleft', 'strong']
    },
    'gpl-2': {
      name: 'GNU General Public License 2 (GPL-2.0)',
      priority: 10,
      available: false,
      url: 'http://www.gnu.org/licenses/gpl-2.0.html',
      description: 'Standard GNU GPL version 2 but without support for later versions i.e. you cannot relicense under GPL 3.',
      categories: ['software', 'gpl', 'copyleft', 'strong']
    },
    'gpl-3': {
      name: 'GNU General Public License 3 (GPL-3.0)',
      priority: 11,
      available: true,
      url: 'http://opensource.org/licenses/GPL-3.0',
      description: 'You may copy, distribute and modify the software as long as you track changes/dates of in source files and keep modifications under GPL. You can distribute your application using a GPL library commercially, but you must also provide the source code. GPL 3 tries to close some loopholes in GPL 2.',
      categories: ['software', 'gpl', 'copyleft', 'strong']
    },
    'agpl-1': {
      name: 'Affero General Public License 1 (AGPL-1.0)',
      priority: 50,
      available: false,
      url: 'http://www.affero.org/oagpl.html',
      description: '',
      categories: ['software', 'agpl', 'copyleft', 'strong']
    },
    'agpl-3': {
      name: 'Affero General Public License 3 (AGPL-3.0)',
      priority: 51,
      available: true,
      url: 'http://opensource.org/licenses/AGPL-3.0',
      description: 'The AGPL license differs from the other GNU licenses in that it was built for network software. You can distribute modified versions if you keep track of the changes and the date you made them. As per usual with GNU licenses, you must license derivatives under AGPL. It provides the same restrictions and freedoms as the GPLv3 but with an additional clause which makes it so that source code must be distributed along with web publication. Since web sites and services are never distributed in the traditional sense, the AGPL is the GPL of the web.',
      categories: ['software', 'agpl', 'copyleft', 'strong']
    },
    'mpl-2': {
      name: 'Mozilla Public License 2.0',
      priority: 1,
      available: true,
      url: 'http://opensource.org/licenses/MPL-2.0',
      description: 'This is a lenient license used by the Mozilla Corporation that allows you a variety of explicit freedoms with the software so long as you keep modifications under this license and distribute the original source code alongside executables. It is a good midway license; it isn’t very strict and has only straightforward requirements.',
      categories: ['software', 'copyleft', 'weak']
    },
    'lgpl-2.1+': {
      name: 'GNU Library or "Lesser" General Public License 2.1 or later (LGPL-2.1)',
      priority: 2,
      available: true,
      url: 'http://opensource.org/licenses/LGPL-2.1',
      description: 'You may copy, distribute and modify the software provided that modifications are described inside the modified files and licensed for free under LGPL-2.1. Derivatives or non-separate (statically-linked) works of the software must be licensed under LGPL, but separate, parent projects don\'t have to be.',
      categories: ['software', 'copyleft', 'weak']
    },
    'lgpl-2.1': {
      name: 'GNU Library or "Lesser" General Public License 2.1 (LGPL-2.1)',
      priority: 2,
      available: false,
      url: 'http://opensource.org/licenses/LGPL-2.1',
      description: 'Standard GNU LGPL version 2.1 but without support for later versions i.e. you cannot relicense under LGPL 3.',
      categories: ['software', 'copyleft', 'weak']
    },
    'lgpl-3': {
      name: 'GNU Library or "Lesser" General Public License 3.0 (LGPL-3.0)',
      priority: 3,
      available: true,
      url: 'http://opensource.org/licenses/LGPL-3.0',
      description: 'You may copy, distribute and modify the software provided that modifications are described inside the modified files and licensed for free under LGPL-2.1.  Derivatives or non-separate (statically-linked) works of the software must be licensed under LGPL, but separate, parent projects don\'t have to be. LGPL 3 tries to close some loopholes in LGPL 2.1.',
      categories: ['software', 'copyleft', 'weak']
    },
    'epl-1': {
      name: 'Eclipse Public License 1.0 (EPL-1.0)',
      priority: 4,
      available: true,
      url: 'http://opensource.org/licenses/EPL-1.0',
      description: 'This license, made and used by the Eclipse Foundation, isn’t all too stringent and gives both copyright and explicit patent rights. Check the full text of the license to see how liability is accorded.',
      categories: ['software', 'copyleft', 'weak']
    },
    'cddl-1': {
      name: 'Common Development and Distribution License (CDDL-1.0)',
      priority: 5,
      available: true,
      url: 'http://opensource.org/licenses/CDDL-1.0',
      description: 'This is a very permissive and popular license made by Sun Microsystems that also includes explicit patent grants. It is relatively simplistic in its conditions, requiring only a small amount of documentation for redistribution (applying to source as well as modified code).',
      categories: ['software', 'copyleft', 'weak']
    },
    'mit': {
      name: 'The MIT License (MIT)',
      priority: 1,
      available: true,
      url: 'http://opensource.org/licenses/mit-license.php',
      description: 'A short, permissive software license. Basically, you can do whatever you want as long as you include the original copyright and license.',
      categories: ['software', 'permissive']
    },
    'bsd-3c': {
      name: 'The BSD 3-Clause "New" or "Revised" License (BSD)',
      priority: 2,
      available: true,
      url: 'http://opensource.org/licenses/BSD-3-Clause',
      description: 'The BSD 3-clause license allows you almost unlimited freedom with the software so long as you include the BSD copyright notice in it. "Use trademark" in this case means you cannot use the names of the original company or its members to endorse derived products.',
      categories: ['software', 'permissive']
    },
    'bsd-2c': {
      name: 'The BSD 2-Clause "Simplified" or "FreeBSD" License',
      priority: 3,
      available: true,
      url: 'http://opensource.org/licenses/BSD-2-Clause',
      description: 'The BSD 2-clause license allows you almost unlimited freedom with the software so long as you include the BSD copyright notice in it.',
      categories: ['software', 'permissive']
    },
    'apache-2': {
      name: 'Apache License 2',
      priority: 4,
      available: true,
      url: 'http://opensource.org/licenses/Apache-2.0',
      description: 'A license that allows you much freedom with the software, including an explicit right to a patent. "State changes" means that you have to include a notice in each file you modified. ',
      categories: ['software', 'permissive']
    }
  };

  Y = true;

  N = false;

  LicenseCompatibility = {
    columns: ['cc-public-domain', 'mit', 'bsd-2c', 'bsd-3c', 'apache-2', 'lgpl-2.1', 'lgpl-2.1+', 'lgpl-3', 'mpl-2', 'epl-1', 'cddl-1', 'gpl-2', 'gpl-2+', 'gpl-3', 'agpl-1', 'agpl-3'],
    table: {
      'cc-public-domain': [Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y],
      'mit': [N, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y],
      'bsd-2c': [N, N, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y],
      'bsd-3c': [N, N, N, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y, Y],
      'apache-2': [N, N, N, N, Y, N, N, Y, Y, Y, N, N, N, Y, N, Y],
      'lgpl-2.1': [N, N, N, N, N, Y, N, N, Y, N, N, Y, N, N, Y, N],
      'lgpl-2.1+': [N, N, N, N, N, N, Y, Y, Y, N, N, Y, Y, Y, Y, Y],
      'lgpl-3': [N, N, N, N, N, N, N, Y, Y, N, N, N, N, Y, N, Y],
      'mpl-2': [N, N, N, N, N, Y, Y, Y, Y, N, N, Y, Y, Y, Y, Y],
      'epl-1': [N, N, N, N, N, N, N, N, Y, Y, Y, N, N, Y, N, Y],
      'cddl-1': [N, N, N, N, N, N, N, N, N, N, Y, N, N, N, N, N],
      'gpl-2': [N, N, N, N, N, N, N, N, N, N, N, Y, N, N, Y, N],
      'gpl-2+': [N, N, N, N, N, N, N, N, N, N, N, Y, Y, Y, Y, Y],
      'gpl-3': [N, N, N, N, N, N, N, N, N, N, N, N, Y, Y, N, Y],
      'agpl-1': [N, N, N, N, N, N, N, N, N, N, N, N, N, N, Y, N],
      'agpl-3': [N, N, N, N, N, N, N, N, N, N, N, N, N, N, N, Y]
    }
  };

  QuestionDefinitions = {
    KindOfContent: function() {
      this.question('What do you want to deposit?');
      this.answer('Software', function() {
        this.exclude('data');
        return this.goto('YourSoftware');
      });
      return this.answer('Data', function() {
        this.exclude('software');
        return this.goto('DataCopyrightable');
      });
    },
    DataCopyrightable: function() {
      this.question('Is your data copyrightable?');
      this.yes(function() {
        return this.goto('OwnIPR');
      });
      return this.no(function() {
        return this.license('cc-public-domain');
      });
    },
    OwnIPR: function() {
      this.question('Are you sure you own IPR in your dataset and its consitutive parts?');
      this.yes(function() {
        return this.goto('AllowDerivativeWorks');
      });
      return this.no(function() {
        return this.goto('EnsureLicensing');
      });
    },
    AllowDerivativeWorks: function() {
      this.question('Do you allow others to make defivative works?');
      this.yes(function() {
        this.exclude('nd');
        return this.goto('ShareAlike');
      });
      return this.no(function() {
        this.include('nd');
        if (this.only('nc')) {
          return this.license();
        } else {
          return this.goto('CommercialUse');
        }
      });
    },
    ShareAlike: function() {
      this.question('Do you require others to share derivative works based on your data under a compatible license?');
      this.yes(function() {
        this.include('sa');
        if (this.only('nc')) {
          return this.license();
        } else {
          return this.goto('CommercialUse');
        }
      });
      return this.no(function() {
        this.exclude('sa');
        if (this.only('nc')) {
          return this.license();
        } else {
          return this.goto('CommercialUse');
        }
      });
    },
    CommercialUse: function() {
      this.question('Do you allow others to make commercial use of you data');
      this.yes(function() {
        this.exclude('nc');
        if (this.only('by')) {
          return this.license();
        } else {
          return this.goto('DecideAttribute');
        }
      });
      return this.no(function() {
        this.include('nc');
        this.include('by');
        return this.license();
      });
    },
    DecideAttribute: function() {
      this.question('Do you want others to attribute your data to you?');
      this.yes(function() {
        this.include('by');
        return this.license();
      });
      return this.no(function() {
        this.include('public-domain');
        return this.license();
      });
    },
    EnsureLicensing: function() {
      this.question('Are all the elements of your dataset licensed or in the Public Domain?');
      this.yes(function() {
        return this.goto('LicenseInteropData');
      });
      return this.no(function() {
        return this.cantlicense('You need additional permission before you can deposit the data!');
      });
    },
    LicenseInteropData: function() {
      var disabledCheck, nextAction;
      this.question('Choose licenses present in your dataset:');
      this.option(['cc-public-domain', 'cc-zero', 'pddl'], function() {
        return this.goto('AllowDerivativeWorks');
      });
      this.option(['cc-by', 'odc-by'], function() {
        this.exclude('public-domain');
        return this.goto('AllowDerivativeWorks');
      });
      this.option(['cc-by-nc'], function() {
        this.include('nc');
        return this.goto('AllowDerivativeWorks');
      });
      this.option(['cc-by-nc-sa'], function() {
        return this.license('cc-by-nc-sa');
      });
      this.option(['odbl'], function() {
        return this.license('odbl', 'cc-by-sa');
      });
      this.option(['cc-by-sa'], function() {
        return this.license('cc-by-sa');
      });
      this.option(['cc-by-nd', 'cc-by-nc-nd'], function() {
        return this.cantlicense("License doesn't allow derivative works. You need additional permission before you can deposit the data!");
      });
      nextAction = function(state) {
        var option;
        option = _(state.options).filter('selected').last();
        if (option == null) {
          return;
        }
        return option.action();
      };
      disabledCheck = function(state) {
        return !_.any(state.options, function(option) {
          return option.selected;
        });
      };
      return this.answer('Next', nextAction, disabledCheck);
    },
    YourSoftware: function() {
      this.question('Is your code based on existing software or is it your original work?');
      this.answer('Based on existing software', function() {
        return this.goto('LicenseInteropSoftware');
      });
      return this.answer('My own code', function() {
        return this.goto('Copyleft');
      });
    },
    LicenseInteropSoftware: function() {
      var license, nextAction, _i, _len, _ref;
      this.question('Select licenses in your code:');
      _ref = LicenseCompatibility.columns;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        license = _ref[_i];
        this.option([license]);
      }
      nextAction = function(state) {
        var index, index1, index2, l, license1, license2, licenseKey, licenses, list, value, _j, _k, _l, _len1, _len2, _len3;
        licenses = _(state.options).filter('selected').pluck('licenses').flatten().valueOf();
        if (licenses.length === 0) {
          return;
        }
        for (_j = 0, _len1 = licenses.length; _j < _len1; _j++) {
          license1 = licenses[_j];
          index1 = _.indexOf(LicenseCompatibility.columns, license1.key);
          for (_k = 0, _len2 = licenses.length; _k < _len2; _k++) {
            license2 = licenses[_k];
            index2 = _.indexOf(LicenseCompatibility.columns, license2.key);
            if (!(LicenseCompatibility.table[license2.key][index1] || LicenseCompatibility.table[license1.key][index2])) {
              this.cantlicense("The licenses <strong>" + license1.name + "</strong> and <strong>" + license2.name + "</strong> in your software are incompatible. Contact the copyright owner and try to talk him into re-licensing.");
              return;
            }
          }
        }
        list = null;
        for (_l = 0, _len3 = licenses.length; _l < _len3; _l++) {
          license = licenses[_l];
          if (list == null) {
            list = LicenseCompatibility.table[license.key];
            continue;
          }
          l = LicenseCompatibility.table[license.key];
          list = _.map(list, function(val, index) {
            return l[index] && val;
          });
        }
        licenses = [];
        for (index in list) {
          value = list[index];
          if (!value) {
            continue;
          }
          licenseKey = LicenseCompatibility.columns[index];
          if (licenseKey && (this.licenses[licenseKey] != null)) {
            licenses.push(this.licenses[licenseKey]);
          }
        }
        this.licensesList.update(licenses);
        if (this.has('copyleft') && this.has('permissive')) {
          this.goto('Copyleft');
        } else if (this.has('copyleft') && this.has('strong') && this.has('weak')) {
          this.goto('StrongCopyleft');
        } else {
          this.license();
        }
      };
      return this.answer('Next', nextAction, function(state) {
        return !_.any(state.options, function(option) {
          return option.selected;
        });
      });
    },
    Copyleft: function() {
      this.question('Do you want others who modify your code to be forced to also release it under open source license?');
      this.yes(function() {
        this.include('copyleft');
        if (this.has('weak') && this.has('strong')) {
          return this.goto('StrongCopyleft');
        } else {
          return this.license();
        }
      });
      return this.no(function() {
        this.exclude('copyleft');
        this.include('permissive');
        return this.license();
      });
    },
    StrongCopyleft: function() {
      this.question('Is your code used directly as an executable or are you licensing a library (your code will be linked)?');
      this.answer('Executable', function() {
        this.include('strong');
        return this.license();
      });
      return this.answer('Library', function() {
        this.include('weak');
        return this.license();
      });
    }
  };

  History = (function() {
    function History(parent, licenseSelector) {
      var _this = this;
      this.parent = parent;
      this.licenseSelector = licenseSelector;
      this.current = -1;
      this.historyStack = [];
      this.prevButton = $('<button/>').addClass('ls-history-prev').attr('title', 'Previous question').append($('<span/>').addClass('icon-left')).click(function() {
        return _this.go(_this.current - 1);
      });
      this.nextButton = $('<button/>').addClass('ls-history-next').attr('title', 'Next question').append($('<span/>').addClass('icon-right')).click(function() {
        return _this.go(_this.current + 1);
      });
      this.restartButton = $('<button/>').addClass('ls-restart').attr('title', 'Start again').append($('<span/>').addClass('icon-ccw')).append(' Start again').click(function() {
        return _this.licenseSelector.restart();
      });
      this.progress = $('<div/>').addClass('ls-history-progress');
      $('<div/>').addClass('ls-history').append(this.restartButton).append(this.prevButton).append(this.progress).append(this.nextButton).appendTo(this.parent);
      this.update();
    }

    History.prototype.go = function(point) {
      this.current = point;
      this.licenseSelector.setState(_.clone(this.historyStack[this.current]));
      this.update();
    };

    History.prototype.reset = function() {
      this.current = -1;
      this.historyStack = [];
      this.update();
    };

    History.prototype.update = function() {
      var activeBlock, progressBarBlocks;
      progressBarBlocks = this.progress.children();
      if (progressBarBlocks.size() > 0) {
        activeBlock = progressBarBlocks.removeClass('ls-active').get(this.current);
        if (activeBlock != null) {
          $(activeBlock).addClass('ls-active');
        }
      }
      this.nextButton.attr('disabled', this.historyStack.length === 0 || this.historyStack.length === this.current + 1);
      this.prevButton.attr('disabled', this.current === 0);
    };

    History.prototype.pushState = function(state) {
      var index, progressBarBlocks, that;
      state = _.clone(state);
      this.current += 1;
      if (this.historyStack.length > this.current) {
        this.historyStack = this.historyStack.slice(0, this.current);
      }
      this.historyStack.push(state);
      progressBarBlocks = this.progress.children().size();
      index = this.current + 1;
      if (progressBarBlocks > index) {
        this.progress.children().slice(index).remove();
      } else {
        that = this;
        this.progress.append($('<span/>').click(function() {
          return that.go(that.progress.children().index(this));
        }));
      }
      this.update();
    };

    return History;

  })();

  Question = (function() {
    function Question(parent, licenseSelector) {
      this.parent = parent;
      this.licenseSelector = licenseSelector;
      this.element = $('<div/>').addClass('ls-question');
      this.errorContainer = $('<div/>').addClass('ls-question-error').append($('<h4/>').text("Can't choose a license")).appendTo(this.element);
      this.errorContainer.hide();
      this.error = $('<span/>').appendTo(this.errorContainer);
      this.text = $('<p/>').addClass('ls-question-text').appendTo(this.element);
      this.options = $('<ul/>').appendTo($('<div/>').addClass('ls-question-options').appendTo(this.element));
      this.answers = $('<div/>').addClass('ls-question-answers').appendTo(this.element);
      this.element.appendTo(this.parent);
    }

    Question.prototype.show = function() {
      return this.element.show();
    };

    Question.prototype.hide = function() {
      return this.element.hide();
    };

    Question.prototype.reset = function() {
      this.errorContainer.hide();
      this.answers.empty();
      this.options.empty();
      this.options.hide();
      this.licenseSelector.licensesList.show();
      return this.element.off('update-answers');
    };

    Question.prototype.finished = function() {
      this.hide();
      return this.licenseSelector.licensesList.show();
    };

    Question.prototype.setQuestion = function(text) {
      this.reset();
      this.text.html(text);
    };

    Question.prototype.addAnswer = function(answer) {
      var button;
      button = $('<button />').text(answer.text).click(function() {
        return answer.action();
      }).attr('disabled', answer.disabled());
      this.element.on('update-answers', function() {
        return button.attr('disabled', answer.disabled());
      });
      this.answers.append(button);
    };

    Question.prototype.addOption = function(option) {
      var checkbox, element, label, license, span, _i, _len, _ref;
      this.options.show();
      this.licenseSelector.licensesList.hide();
      element = this.element;
      checkbox = $('<input/>').attr('type', 'checkbox').click(function() {
        option.selected = this.checked;
        return element.trigger('update-answers');
      });
      label = $('<label/>').append(checkbox);
      span = $('<span/>');
      _ref = option.licenses;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        license = _ref[_i];
        span.append($('<span/>').addClass('ls-license-name').text(license.name));
      }
      label.append(span).appendTo($('<li/>').appendTo(this.options));
    };

    Question.prototype.setError = function(html) {
      this.errorContainer.show();
      this.error.html(html);
    };

    return Question;

  })();

  Modal = (function() {
    var MODAL_MAX_WIDTH, MODAL_SMALL_BREAKPOINT, scale, stylesheet;

    MODAL_SMALL_BREAKPOINT = 480;

    MODAL_MAX_WIDTH = 800;

    stylesheet = null;

    scale = function() {
      var closeButtonMarginRight, currentMaxWidth, leftMargin, margin, width;
      if (!stylesheet) {
        stylesheet = $('<style></style>').appendTo('head');
      }
      width = $(window).width();
      margin = 10;
      if (width < MODAL_MAX_WIDTH) {
        currentMaxWidth = width - (margin * 2);
        leftMargin = currentMaxWidth / 2;
        closeButtonMarginRight = width > MODAL_SMALL_BREAKPOINT ? '-' + Math.floor(currentMaxWidth / 2) : 10;
        return stylesheet.html(".license-selector .ls-modal { max-width: " + currentMaxWidth + "px; margin-left: -" + leftMargin + "px;}\n.license-selector .ls-modal-close:after { margin-right: -" + closeButtonMarginRight + "px !important; }");
      } else {
        currentMaxWidth = MODAL_MAX_WIDTH - (margin * 2);
        leftMargin = currentMaxWidth / 2;
        return stylesheet.html(".license-selector .ls-modal { max-width: " + currentMaxWidth + "px; margin-left: -" + leftMargin + "px;}\n.license-selector .ls-modal-close:after { margin-right: -" + leftMargin + "px !important; }");
      }
    };

    $(window).on('resize', scale);

    function Modal(parent) {
      var closeButton, inner,
        _this = this;
      this.parent = parent;
      this.element = $('<section/>').addClass('license-selector').attr({
        tabindex: '-1',
        'aria-hidden': 'true',
        role: 'dialog'
      }).on('show.lsmodal', scale);
      inner = $('<div/>').addClass('ls-modal');
      this.header = $('<header/>').append($('<h2/>').text('Choose a license')).append($('<p/>').text('Answer the questions or use the search to find the license you want')).appendTo(inner);
      this.content = $('<div/>').addClass('ls-modal-content').appendTo(inner);
      closeButton = $('<a/>').addClass('ls-modal-close').attr({
        'title': 'Close License Selector',
        'data-dismiss': 'modal',
        'data-close': 'Close'
      }).click(function() {
        return _this.hide();
      });
      this.element.append(inner).append(closeButton).appendTo(this.parent);
    }

    Modal.prototype.hide = function() {
      return this.element.removeClass('is-active').trigger('hide.lsmodal').attr('aria-hidden', 'true');
    };

    Modal.prototype.show = function() {
      return this.element.addClass('is-active').trigger('show.lsmodal').attr('aria-hidden', 'false');
    };

    return Modal;

  })();

  Search = (function() {
    function Search(parent, licenseList) {
      var _this = this;
      this.parent = parent;
      this.licenseList = licenseList;
      this.textbox = $('<input/>').attr({
        type: 'text',
        placeholder: 'Search for a license...'
      }).on('input', function() {
        return _this.licenseList.filter(_this.textbox.val());
      });
      this.container = $('<div/>').addClass('ls-search').append(this.textbox).appendTo(this.parent);
    }

    Search.prototype.hide = function() {
      return this.container.hide();
    };

    Search.prototype.show = function() {
      return this.container.show();
    };

    return Search;

  })();

  LicenseList = (function() {
    var comperator;

    comperator = function(obj, text) {
      text = ('' + text).toLowerCase();
      return ('' + obj).toLowerCase().indexOf(text) > -1;
    };

    function LicenseList(parent, licenseSelector) {
      this.parent = parent;
      this.licenseSelector = licenseSelector;
      this.availableLicenses = _.where(this.licenseSelector.licenses, {
        available: true
      });
      this.list = $('<ul />');
      this.container = $('<div class="ls-license-list" />').append(this.list).appendTo(this.parent);
      this.update();
    }

    LicenseList.prototype.createElement = function(license) {
      var chooseButton, el,
        _this = this;
      el = $('<li />');
      chooseButton = $('<button/>').append($('<span/>').addClass('ls-select').text('Select')).append($('<span/>').addClass('ls-confirm').text('Confirm')).click(function() {
        _this.selectLicense(license, el);
        return _this.licenseSelector.selectLicense(license);
      });
      el.append($('<h4 />').text(license.name).append(chooseButton));
      if (!_.isEmpty(license.description)) {
        el.append($('<p />').text(license.description));
      }
      el.data('license', license);
      return el;
    };

    LicenseList.prototype.hide = function() {
      this.parent.hide();
      return this.licenseSelector.searchModule.hide();
    };

    LicenseList.prototype.show = function() {
      this.parent.show();
      return this.licenseSelector.searchModule.show();
    };

    LicenseList.prototype.filter = function(newterm) {
      if (newterm !== this.term) {
        this.term = newterm;
        this.update();
      }
    };

    LicenseList.prototype.sortLicenses = function(licenses) {
      return _.sortBy(licenses, ['priority', 'name']);
    };

    LicenseList.prototype.selectLicense = function(license, element) {
      var selectedLicense;
      selectedLicense = this.deselectLicense();
      if ((selectedLicense != null) && selectedLicense === license) {
        return;
      }
      element.addClass('ls-active');
      return this.selectedLicense = {
        license: license,
        element: element
      };
    };

    LicenseList.prototype.deselectLicense = function() {
      var element, license, _ref;
      if (this.selectedLicense == null) {
        this.selectedLicense = {};
      }
      _ref = this.selectedLicense, element = _ref.element, license = _ref.license;
      if (element) {
        element.removeClass('ls-active');
      }
      this.selectedLicense = {};
      return license;
    };

    LicenseList.prototype.matchFilter = function(license) {
      if (!license.available) {
        return false;
      }
      if (!this.term) {
        return true;
      }
      return comperator(license.name, this.term) || comperator(license.description, this.term);
    };

    LicenseList.prototype.update = function(licenses) {
      var el, elements, license, previous, _i, _j, _len, _len1, _ref, _ref1;
      if (licenses == null) {
        licenses = this.availableLicenses;
      } else {
        licenses = this.availableLicenses = _.where(licenses, {
          available: true
        });
      }
      elements = {};
      _ref = this.list.children();
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        el = _ref[_i];
        el = $(el);
        license = el.data('license');
        if ((licenses[license.key] != null) && this.matchFilter(licenses[license.key])) {
          elements[licenses.key] = el;
        } else {
          el.remove();
        }
      }
      previous = null;
      _ref1 = this.sortLicenses(licenses);
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        license = _ref1[_j];
        if (!this.matchFilter(license)) {
          continue;
        }
        if (elements[license.key] != null) {
          previous = elements[license.key];
        } else {
          el = this.createElement(license);
          if (previous != null) {
            previous.after(el);
          } else {
            this.list.prepend(el);
          }
          previous = el;
        }
      }
    };

    LicenseList.prototype.has = function(category) {
      return _.any(this.availableLicenses, function(license) {
        return _.contains(license.categories, category);
      });
    };

    LicenseList.prototype.only = function(category) {
      return _.all(this.availableLicenses, function(license) {
        return _.contains(license.categories, category);
      });
    };

    LicenseList.prototype.hasnt = function(category) {
      return _.all(this.availableLicenses, function(license) {
        return !_.contains(license.categories, category);
      });
    };

    LicenseList.prototype.include = function(category) {
      this.availableLicenses = _.filter(this.availableLicenses, function(license) {
        return _.contains(license.categories, category);
      });
      return this.update();
    };

    LicenseList.prototype.exclude = function(category) {
      this.availableLicenses = _.filter(this.availableLicenses, function(license) {
        return !_.contains(license.categories, category);
      });
      return this.update();
    };

    return LicenseList;

  })();

  LicenseSelector = (function() {
    LicenseSelector.defaultOptions = {
      onLicenseSelected: _.noop,
      appendTo: 'body',
      start: 'KindOfContent'
    };

    function LicenseSelector(licenses, questions, options) {
      var key, license, _ref;
      this.licenses = licenses;
      this.questions = questions;
      this.options = options != null ? options : {};
      _.defaults(this.options, LicenseSelector.defaultOptions);
      _ref = this.licenses;
      for (key in _ref) {
        license = _ref[key];
        license.key = key;
      }
      this.state = {};
      this.modal = new Modal($(this.options.appendTo));
      this.licensesList = new LicenseList(this.modal.content, this);
      this.historyModule = new History(this.modal.header, this);
      this.questionModule = new Question(this.modal.header, this);
      this.searchModule = new Search(this.modal.header, this.licensesList);
      this.goto(this.options.start);
    }

    LicenseSelector.prototype.restart = function() {
      this.licensesList.update(this.licenses);
      this.historyModule.reset();
      this.state = {};
      this.goto(this.options.start);
    };

    LicenseSelector.prototype.setState = function(state) {
      this.state = state;
      this.licensesList.update(state.licenses);
      this.goto(this.state.question, false);
    };

    LicenseSelector.prototype.selectLicense = function(license, force) {
      if (force == null) {
        force = false;
      }
      if (this.selectedLicense === license || force) {
        this.options.onLicenseSelected(license);
        return this.modal.hide();
      } else {
        return this.selectedLicense = license;
      }
    };

    LicenseSelector.prototype.license = function() {
      var choice, choices, license, licenses, _i, _len, _ref;
      choices = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      if ((choices != null) && choices.length > 0) {
        licenses = [];
        _ref = _.flatten(choices);
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          choice = _ref[_i];
          if (_.isString(choice)) {
            license = this.licenses[choice];
          }
          licenses.push(license);
        }
        this.licensesList.update(licenses);
      }
      this.state.finished = true;
      this.questionModule.finished();
    };

    LicenseSelector.prototype.cantlicense = function(reason) {
      this.questionModule.setError(reason);
    };

    LicenseSelector.prototype.goto = function(where, safeState) {
      var func, _base;
      if (safeState == null) {
        safeState = true;
      }
      this.questionModule.show();
      this.state.question = where;
      if ((_base = this.state).licenses == null) {
        _base.licenses = this.licenses;
      }
      this.state.finished = false;
      func = this.questions[where];
      func.call(this);
      if (safeState) {
        this.historyModule.pushState(this.state);
      }
    };

    LicenseSelector.prototype.question = function(text) {
      this.questionModule.setQuestion(text);
      this.state.options = null;
    };

    LicenseSelector.prototype.answer = function(text, action, disabled) {
      if (disabled == null) {
        disabled = _.noop;
      }
      this.questionModule.addAnswer({
        text: text,
        action: _.bind(action, this, this.state),
        disabled: _.bind(disabled, this, this.state)
      });
    };

    LicenseSelector.prototype.option = function(list, action) {
      var license, option, _base;
      if (action == null) {
        action = _.noop;
      }
      option = {
        licenses: (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = list.length; _i < _len; _i++) {
            license = list[_i];
            _results.push(this.licenses[license]);
          }
          return _results;
        }).call(this),
        action: _.bind(action, this, this.state)
      };
      if ((_base = this.state).options == null) {
        _base.options = [];
      }
      this.state.options.push(option);
      this.questionModule.addOption(option);
    };

    LicenseSelector.prototype.yes = function(action) {
      return this.answer('Yes', action);
    };

    LicenseSelector.prototype.no = function(action) {
      return this.answer('No', action);
    };

    LicenseSelector.prototype.has = function(category) {
      return this.licensesList.has(category);
    };

    LicenseSelector.prototype.only = function(category) {
      return this.licensesList.only(category);
    };

    LicenseSelector.prototype.hasnt = function(category) {
      return this.licensesList.hasnt(category);
    };

    LicenseSelector.prototype.include = function(category) {
      this.licensesList.include(category);
      return this.state.licenses = _.clone(this.licensesList.availableLicenses);
    };

    LicenseSelector.prototype.exclude = function(category) {
      this.licensesList.exclude(category);
      return this.state.licenses = _.clone(this.licensesList.availableLicenses);
    };

    return LicenseSelector;

  })();

  $.fn.licenseSelector = function(options) {
    return this.each(function() {
      var ls;
      ls = new LicenseSelector(LicenseDefinitions, QuestionDefinitions, options);
      $(this).data('license-selector', ls);
      return $(this).click(function(e) {
        ls.modal.show();
        return e.preventDefault();
      });
    });
  };

}).call(this);
