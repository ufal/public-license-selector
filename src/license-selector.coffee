EVENT_NS = 'license-selector'

LicenseDefinitions =
  'cc-public-domain':
    name: 'Public Domain Mark (PD)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/publicdomain/mark/1.0/'
    description: "The work identified as being free of known restrictions under copyright law, including all related and neighboring rights."
    categories: ['data', 'software', 'public-domain']

  'cc-zero':
    name: 'Public Domain Dedication (CC Zero)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/publicdomain/zero/1.0/'
    description: 'CC Zero enables scientists, educators, artists and other creators and owners of copyright- or database-protected content to waive those interests in their works and thereby place them as completely as possible in the public domain, so that others may freely build upon, enhance and reuse the works for any purposes without restriction under copyright or database law.'
    categories: ['data', 'public-domain']

  'pddl':
    name: 'Open Data Commons Public Domain Dedication and License (PDDL)'
    priority: 1
    available: false
    url: 'http://opendatacommons.org/licenses/pddl/summary/'
    description: 'This license is meant to be an international, database-specific equivalent of the public domain. You cannot relicense or sublicense any database under this license because, like the public domain, after dedication you no longer own any rights to the database.'
    categories: ['data', 'public-domain']

  'cc-by':
    name: 'Creative Commons Attribution (CC-BY)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by/3.0/'
    description: 'This is the standard creative commons license that gives others maximum freedom to do what they want with your work.'
    categories: ['data', 'by']

  'odc-by':
    name: 'Open Data Commons Attribution License (ODC-By)'
    priority: 1
    available: false
    url: 'http://opendatacommons.org/licenses/by/summary/'
    description: ''
    categories: ['data', 'by']

  'cc-by-sa':
    name: 'Creative Commons Attribution-ShareAlike (CC-BY-SA)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-sa/3.0/'
    description: 'This creative commons license is very similar to the regular Attribution license, but requires you to release all derivative works under this same license.'
    categories: ['data', 'by', 'sa']

  'odbl':
    name: 'Open Data Commons Open Database License (ODbL)'
    priority: 1
    available: false
    url: 'http://opendatacommons.org/licenses/odbl/summary/'
    description: 'A copyleft license used by OpenStreetMap and others with very specific terms designed for databases.'
    categories: ['data', 'by', 'sa']

  'cc-by-nd':
    name: 'Creative Commons Attribution-NoDerivs (CC-BY-ND)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-nd/3.0/'
    description: 'The no derivatives creative commons license is straightforward; you can take a work released under this license and re-distribute it but you cannot change it.'
    categories: ['data', 'by', 'nd']

  'cc-by-nc':
    name: 'Creative Commons Attribution-NonCommercial (CC-BY-NC)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-nc/3.0/'
    description: 'A creative commons license that bans commercial use.'
    categories: ['data', 'by', 'nc']

  'cc-by-nc-sa':
    name: 'Creative Commons Attribution-NonCommercial-ShareAlike (CC-BY-NC-SA)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-nc-sa/3.0/'
    description: 'A creative commons license that bans commercial use and requires you to release any modified works under this license.'
    categories: ['data', 'by', 'nc', 'sa']

  'cc-by-nc-nd':
    name: 'Creative Commons Attribution-NonCommercial-NoDerivs (CC-BY-NC-ND)'
    priority: 1
    available: true
    url: 'http://creativecommons.org/licenses/by-nc-nd/3.0/'
    description: 'The most restrictive creative commons license. This only allows people to download and share your work for no commercial gain and for no other purposes.'
    categories: ['data', 'by', 'nc', 'nd']

  'perl-artistic-1':
    name: 'Artistic License 1.0'
    priority: 7
    available: true
    url: 'http://opensource.org/licenses/Artistic-Perl-1.0'
    description: 'NOTE: This license has been superseded by the Artistic License, Version 2.0. This is a license for software packages with the intent of giving the original copyright holder some measure of control over his software while still remaining open source. It is flexible and allows you to distribute or sell modified versions as long as you fulfill one of various conditions. Look at section 4 in the full text for a better explanation.'
    categories: ['software', 'perl']

  'perl-artistic-2':
    name: 'Artistic License 2.0'
    priority: 8
    available: true
    url: 'http://dev.perl.org/licenses/artistic.html'
    description: 'This is a license for software packages with the intent of giving the original copyright holder some measure of control over his software while still remaining open source. It is flexible and allows you to distribute or sell modified versions as long as you fulfill one of various conditions. Look at section 4 in the full text for a better explanation.'
    categories: ['software', 'perl']

  'gpl-2+':
    name: 'GNU General Public License 2 or later (GPL-2.0)'
    priority: 10
    available: true
    url: 'http://opensource.org/licenses/GPL-2.0'
    description: 'You may copy, distribute and modify the software as long as you track changes/dates of in source files and keep all modifications under GPL. You can distribute your application using a GPL library commercially, but you must also disclose the source code.'
    categories: ['software', 'gpl', 'copyleft', 'strong']

  'gpl-2':
    name: 'GNU General Public License 2 (GPL-2.0)'
    priority: 10
    available: false
    url: 'http://www.gnu.org/licenses/gpl-2.0.html'
    description: 'Standard GNU GPL version 2 but without support for later versions i.e. you cannot relicense under GPL 3.'
    categories: ['software', 'gpl', 'copyleft', 'strong']

  'gpl-3':
    name: 'GNU General Public License 3 (GPL-3.0)'
    priority: 11
    available: true
    url: 'http://opensource.org/licenses/GPL-3.0'
    description: 'You may copy, distribute and modify the software as long as you track changes/dates of in source files and keep modifications under GPL. You can distribute your application using a GPL library commercially, but you must also provide the source code. GPL 3 tries to close some loopholes in GPL 2.'
    categories: ['software', 'gpl', 'copyleft', 'strong']

  'agpl-1':
    name: 'Affero General Public License 1 (AGPL-1.0)'
    priority: 50
    available: false
    url: 'http://www.affero.org/oagpl.html'
    description: ''
    categories: ['software', 'agpl', 'copyleft', 'strong']

  'agpl-3':
    name: 'Affero General Public License 3 (AGPL-3.0)'
    priority: 51
    available: true
    url: 'http://opensource.org/licenses/AGPL-3.0'
    description: 'The AGPL license differs from the other GNU licenses in that it was built for network software. You can distribute modified versions if you keep track of the changes and the date you made them. As per usual with GNU licenses, you must license derivatives under AGPL. It provides the same restrictions and freedoms as the GPLv3 but with an additional clause which makes it so that source code must be distributed along with web publication. Since web sites and services are never distributed in the traditional sense, the AGPL is the GPL of the web.'
    categories: ['software', 'agpl', 'copyleft', 'strong']

  'mpl-2':
    name: 'Mozilla Public License 2.0'
    priority: 1
    available: true
    url: 'http://opensource.org/licenses/MPL-2.0'
    description: 'This is a lenient license used by the Mozilla Corporation that allows you a variety of explicit freedoms with the software so long as you keep modifications under this license and distribute the original source code alongside executables. It is a good midway license; it isn’t very strict and has only straightforward requirements.'
    categories: ['software', 'copyleft', 'weak']

  'lgpl-2.1+':
    name: 'GNU Library or "Lesser" General Public License 2.1 or later (LGPL-2.1)'
    priority: 2
    available: true
    url: 'http://opensource.org/licenses/LGPL-2.1'
    description: 'You may copy, distribute and modify the software provided that modifications are described inside the modified files and licensed for free under LGPL-2.1. Derivatives or non-separate (statically-linked) works of the software must be licensed under LGPL, but separate, parent projects don\'t have to be.'
    categories: ['software', 'copyleft', 'weak']

  'lgpl-2.1':
    name: 'GNU Library or "Lesser" General Public License 2.1 (LGPL-2.1)'
    priority: 2
    available: false
    url: 'http://opensource.org/licenses/LGPL-2.1'
    description: 'Standard GNU LGPL version 2.1 but without support for later versions i.e. you cannot relicense under LGPL 3.'
    categories: ['software', 'copyleft', 'weak']

  'lgpl-3':
    name: 'GNU Library or "Lesser" General Public License 3.0 (LGPL-3.0)'
    priority: 3
    available: true
    url: 'http://opensource.org/licenses/LGPL-3.0'
    description: 'You may copy, distribute and modify the software provided that modifications are described inside the modified files and licensed for free under LGPL-2.1.  Derivatives or non-separate (statically-linked) works of the software must be licensed under LGPL, but separate, parent projects don\'t have to be. LGPL 3 tries to close some loopholes in LGPL 2.1.'
    categories: ['software', 'copyleft', 'weak']

  'epl-1':
    name: 'Eclipse Public License 1.0 (EPL-1.0)'
    priority: 4
    available: true
    url: 'http://opensource.org/licenses/EPL-1.0'
    description: 'This license, made and used by the Eclipse Foundation, isn’t all too stringent and gives both copyright and explicit patent rights. Check the full text of the license to see how liability is accorded.'
    categories: ['software', 'copyleft', 'weak']

  'cddl-1':
    name: 'Common Development and Distribution License (CDDL-1.0)'
    priority: 5
    available: true
    url: 'http://opensource.org/licenses/CDDL-1.0'
    description: 'This is a very permissive and popular license made by Sun Microsystems that also includes explicit patent grants. It is relatively simplistic in its conditions, requiring only a small amount of documentation for redistribution (applying to source as well as modified code).'
    categories: ['software', 'copyleft', 'weak']

  'mit':
    name: 'The MIT License (MIT)'
    priority: 1
    available: true
    url: 'http://opensource.org/licenses/mit-license.php'
    description: 'A short, permissive software license. Basically, you can do whatever you want as long as you include the original copyright and license.'
    categories: ['software', 'permissive']

  'bsd-3c':
    name: 'The BSD 3-Clause "New" or "Revised" License (BSD)'
    priority: 2
    available: true
    url: 'http://opensource.org/licenses/BSD-3-Clause'
    description: 'The BSD 3-clause license allows you almost unlimited freedom with the software so long as you include the BSD copyright notice in it. "Use trademark" in this case means you cannot use the names of the original company or its members to endorse derived products.'
    categories: ['software', 'permissive']

  'bsd-2c':
    name: 'The BSD 2-Clause "Simplified" or "FreeBSD" License'
    priority: 3
    available: true
    url: 'http://opensource.org/licenses/BSD-2-Clause'
    description: 'The BSD 2-clause license allows you almost unlimited freedom with the software so long as you include the BSD copyright notice in it.'
    categories: ['software', 'permissive']

  'apache-2':
    name: 'Apache License 2'
    priority: 4
    available: true
    url: 'http://opensource.org/licenses/Apache-2.0'
    description: 'A license that allows you much freedom with the software, including an explicit right to a patent. "State changes" means that you have to include a notice in each file you modified. '
    categories: ['software', 'permissive']

Y = true
N = false

LicenseCompatibility =
  columns:              ['cc-public-domain', 'mit', 'bsd-2c', 'bsd-3c', 'apache-2', 'lgpl-2.1', 'lgpl-2.1+', 'lgpl-3', 'mpl-2', 'epl-1', 'cddl-1', 'gpl-2', 'gpl-2+', 'gpl-3', 'agpl-1', 'agpl-3']
  table:
    'cc-public-domain': [ Y,                  Y,     Y,        Y,        Y,          Y,          Y,           Y,        Y,       Y,       Y,        Y,       Y,        Y,       Y,        Y      ]
    'mit':              [ N,                  Y,     Y,        Y,        Y,          Y,          Y,           Y,        Y,       Y,       Y,        Y,       Y,        Y,       Y,        Y      ]
    'bsd-2c':           [ N,                  N,     Y,        Y,        Y,          Y,          Y,           Y,        Y,       Y,       Y,        Y,       Y,        Y,       Y,        Y      ]
    'bsd-3c':           [ N,                  N,     N,        Y,        Y,          Y,          Y,           Y,        Y,       Y,       Y,        Y,       Y,        Y,       Y,        Y      ]
    'apache-2':         [ N,                  N,     N,        N,        Y,          N,          N,           Y,        Y,       Y,       N,        N,       N,        Y,       N,        Y      ]
    'lgpl-2.1':         [ N,                  N,     N,        N,        N,          Y,          N,           N,        Y,       N,       N,        Y,       N,        N,       Y,        N      ]
    'lgpl-2.1+':        [ N,                  N,     N,        N,        N,          N,          Y,           Y,        Y,       N,       N,        Y,       Y,        Y,       Y,        Y      ]
    'lgpl-3':           [ N,                  N,     N,        N,        N,          N,          N,           Y,        Y,       N,       N,        N,       N,        Y,       N,        Y      ]
    'mpl-2':            [ N,                  N,     N,        N,        N,          Y,          Y,           Y,        Y,       N,       N,        Y,       Y,        Y,       Y,        Y      ]
    'epl-1':            [ N,                  N,     N,        N,        N,          N,          N,           N,        Y,       Y,       Y,        N,       N,        Y,       N,        Y      ]
    'cddl-1':           [ N,                  N,     N,        N,        N,          N,          N,           N,        N,       N,       Y,        N,       N,        N,       N,        N      ]
    'gpl-2':            [ N,                  N,     N,        N,        N,          N,          N,           N,        N,       N,       N,        Y,       N,        N,       Y,        N      ]
    'gpl-2+':           [ N,                  N,     N,        N,        N,          N,          N,           N,        N,       N,       N,        Y,       Y,        Y,       Y,        Y      ]
    'gpl-3':            [ N,                  N,     N,        N,        N,          N,          N,           N,        N,       N,       N,        N,       Y,        Y,       N,        Y      ]
    'agpl-1':           [ N,                  N,     N,        N,        N,          N,          N,           N,        N,       N,       N,        N,       N,        N,       Y,        N      ]
    'agpl-3':           [ N,                  N,     N,        N,        N,          N,          N,           N,        N,       N,       N,        N,       N,        N,       N,        Y      ]


QuestionDefinitions =
  KindOfContent: ->
    @question 'What do you want to deposit?'
    @answer 'Software', ->
      @exclude 'data'
      @goto 'YourSoftware'

    @answer 'Data', ->
      @exclude 'software'
      @goto 'DataCopyrightable'

  # Data
  DataCopyrightable: ->
    @question 'Is your data copyrightable?'
    @yes -> @goto 'OwnIPR'
    @no -> @license 'cc-public-domain'

  OwnIPR: ->
    @question 'Are you sure you own IPR in your dataset and its consitutive parts?'
    @yes -> @goto 'AllowDerivativeWorks'
    @no -> @goto 'EnsureLicensing'

  AllowDerivativeWorks: ->
    @question 'Do you allow others to make derivative works?'
    @yes ->
      @exclude 'nd'
      @goto 'ShareAlike'
    @no ->
      @include 'nd'
      if @only 'nc'
        @license()
      else
        @goto 'CommercialUse'

  ShareAlike: ->
    @question 'Do you require others to share derivative works based on your data under a compatible license?'
    @yes ->
      @include 'sa'
      if @only 'nc'
        @license()
      else
        @goto 'CommercialUse'
    @no ->
      @exclude 'sa'
      if @only 'nc'
        @license()
      else
        @goto 'CommercialUse'

  CommercialUse: ->
    @question 'Do you allow others to make commercial use of you data?'
    @yes ->
      @exclude 'nc'
      if @only 'by'
        @license()
      else
        @goto 'DecideAttribute'
    @no ->
      @include 'nc'
      @include 'by'
      @license()

  DecideAttribute: ->
    @question 'Do you want others to attribute your data to you?'
    @yes ->
      @include 'by'
      @license()
    @no ->
      @include 'public-domain'
      @license()

  EnsureLicensing: ->
    @question 'Are all the elements of your dataset licensed or in the Public Domain?'
    @yes -> @goto 'LicenseInteropData'
    @no -> @cantlicense 'You need additional permission before you can deposit the data!'

  LicenseInteropData: ->
    @question 'Choose licenses present in your dataset:'
    @option ['cc-public-domain', 'cc-zero', 'pddl'], -> @goto 'AllowDerivativeWorks'
    @option ['cc-by', 'odc-by'], ->
      @exclude 'public-domain'
      @goto 'AllowDerivativeWorks'
    @option ['cc-by-nc'], ->
      @include 'nc'
      @goto 'AllowDerivativeWorks'
    @option ['cc-by-nc-sa'], ->
      @license 'cc-by-nc-sa'
    @option ['odbl'], -> @license 'odbl', 'cc-by-sa'
    @option ['cc-by-sa'], -> @license 'cc-by-sa'
    @option ['cc-by-nd', 'cc-by-nc-nd'], ->
      @cantlicense "License doesn't allow derivative works. You need additional permission before you can deposit the data!"
    nextAction = (state) ->
      option = _(state.options).filter('selected').last()
      return unless option?
      option.action()
    disabledCheck = (state) ->
      !_.any state.options, (option) -> option.selected
    @answer 'Next', nextAction, disabledCheck

  # Software
  YourSoftware: ->
    @question 'Is your code based on existing software or is it your original work?'
    @answer 'Based on existing software', -> @goto 'LicenseInteropSoftware'
    @answer 'My own code', -> @goto 'Copyleft'

  LicenseInteropSoftware: ->
    @question 'Select licenses in your code:'
    for license in LicenseCompatibility.columns
      @option [license]

    nextAction = (state) ->
      licenses = _(state.options).filter('selected').pluck('licenses').flatten().valueOf()
      return if licenses.length is 0
      for license1 in licenses
        index1 = _.indexOf(LicenseCompatibility.columns, license1.key)
        for license2 in licenses
          index2 = _.indexOf(LicenseCompatibility.columns, license2.key)
          unless LicenseCompatibility.table[license2.key][index1] or LicenseCompatibility.table[license1.key][index2]
            @cantlicense "The licenses <strong>#{license1.name}</strong> and <strong>#{license2.name}</strong> in your software are incompatible. Contact the copyright owner and try to talk him into re-licensing."
            return
      list = null
      for license in licenses
        unless list?
          list = LicenseCompatibility.table[license.key]
          continue
        l = LicenseCompatibility.table[license.key]
        list = _.map list, (val, index) -> l[index] && val
      licenses = []
      for index, value of list
        continue unless value
        licenseKey = LicenseCompatibility.columns[index]
        licenses.push @licenses[licenseKey] if licenseKey && @licenses[licenseKey]?

      @licensesList.update(licenses)

      if @has('copyleft') and @has('permissive')
        @goto 'Copyleft'
      else if @has('copyleft') and @has('strong') and @has('weak')
        @goto 'StrongCopyleft'
      else
        @license()
      return
    @answer 'Next', nextAction, (state) -> !_.any state.options, (option) -> option.selected

  Copyleft: ->
    @question 'Do you want others who modify your code to be forced to also release it under open source license?'
    @yes ->
      @include 'copyleft'
      if @has('weak') and @has('strong')
        @goto 'StrongCopyleft'
      else
        @license()
    @no ->
      @exclude 'copyleft'
      @include 'permissive'
      @license()

  StrongCopyleft: ->
    @question 'Is your code used directly as an executable or are you licensing a library (your code will be linked)?'
    @answer 'Executable', ->
      @include 'strong'
      @license()
    @answer 'Library', ->
      @include 'weak'
      @license()

class History

  constructor: (@parent, @licenseSelector) ->
    @current = -1
    @historyStack = []
    @prevButton = $('<button/>')
      .addClass('ls-history-prev')
      .attr('title', 'Previous question')
      .append($('<span/>').addClass('icon-left'))
      .click => @go(@current - 1)

    @nextButton = $('<button/>')
      .addClass('ls-history-next')
      .attr('title', 'Next question')
      .append($('<span/>').addClass('icon-right'))
      .click => @go(@current + 1)

    @restartButton = $('<button/>')
      .addClass('ls-restart')
      .attr('title', 'Start again')
      .append($('<span/>').addClass('icon-ccw'))
      .append(' Start again')
      .click => @licenseSelector.restart()

    @progress = $('<div/>').addClass('ls-history-progress')
    $('<div/>').addClass('ls-history')
      .append(@restartButton)
      .append(@prevButton)
      .append(@progress)
      .append(@nextButton)
      .appendTo(@parent)
    @update()

  go: (point) ->
    @current = point
    @licenseSelector.setState _.clone @historyStack[@current]

    #console.log @current
    @update()
    return

  reset: ->
    @current = -1
    @historyStack = []
    @progress.empty()
    @update()
    return

  update: ->
    progressBarBlocks = @progress.children()
    # remove class ls-active from all children
    # then get @current and addClass 'ls-active'
    if progressBarBlocks.size() > 0
      activeBlock = progressBarBlocks.removeClass('ls-active').get(@current)
      $(activeBlock).addClass('ls-active') if activeBlock?

    @nextButton.attr('disabled', @historyStack.length == 0 || @historyStack.length == @current + 1)
    @prevButton.attr('disabled', @current <= 0)
    return

  pushState: (state) ->
    # shallow clone of the state
    state = _.clone state

    # Trim stack if needed
    @current += 1
    @historyStack = @historyStack.slice(0, @current) if @historyStack.length > @current
    @historyStack.push(state)

    #console.log @historyStack

    # trim progress bar
    progressBarBlocks = @progress.children().size()
    index = @current + 1
    if progressBarBlocks != index
      if progressBarBlocks > index
        @progress.children().slice(index).remove()
      else
        that = @
        @progress.append($('<button/>').html('&nbsp;').click -> that.go(that.progress.children().index(@)))
    @update()
    return

class Question

  constructor: (@parent, @licenseSelector) ->
    @element = $('<div/>').addClass('ls-question')
    @errorContainer = $('<div/>').addClass('ls-question-error').append($('<h4/>').text("Can't choose a license")).appendTo(@element)
    @errorContainer.hide()
    @error = $('<span/>').appendTo(@errorContainer)
    @text = $('<p/>').addClass('ls-question-text').appendTo(@element)
    @options = $('<ul/>').appendTo($('<div/>').addClass('ls-question-options').appendTo(@element))
    @answers = $('<div/>').addClass('ls-question-answers').appendTo(@element)
    @element.appendTo(@parent)

  show: -> @element.show()
  hide: -> @element.hide()

  reset: ->
    @errorContainer.hide()
    @answers.empty()
    @options.empty()
    @options.hide()
    @licenseSelector.licensesList.show()
    @element.off('update-answers')

  finished: ->
    @hide()
    @licenseSelector.licensesList.show()

  setQuestion: (text) ->
    @reset()
    @text.html(text)
    return

  addAnswer: (answer) ->
    button = $('<button />')
      .text(answer.text)
      .click(-> answer.action())
      .attr('disabled', answer.disabled())
    @element.on('update-answers', -> button.attr('disabled', answer.disabled()))
    @answers.append(button)
    return

  addOption: (option) ->
    @options.show()
    @licenseSelector.licensesList.hide()
    element = @element

    checkbox = $('<input/>')
      .attr('type', 'checkbox')
      .click(->
        option.selected = this.checked
        element.trigger('update-answers')
      )
    label = $('<label/>').append(checkbox)
    span = $('<span/>')
    for license in option.licenses
      span.append($('<span/>').addClass('ls-license-name').text(license.name))
    label.append(span).appendTo($('<li/>').appendTo(@options))
    return

  setError: (html) ->
    @errorContainer.show()
    @error.html(html)
    return

class Modal
  # based on css-modal https://github.com/drublic/css-modal

  MODAL_SMALL_BREAKPOINT = 480
  MODAL_MAX_WIDTH = 800
  stylesheet = null

  scale = ->
    stylesheet = $('<style></style>').appendTo('head') unless stylesheet
    width = $(window).width()
    margin = 10

    if width < MODAL_MAX_WIDTH
      currentMaxWidth = width - (margin * 2)
      leftMargin = currentMaxWidth / 2
      closeButtonMarginRight = '-' + Math.floor(currentMaxWidth / 2)
      stylesheet.html("""
        .license-selector .ls-modal { max-width: #{currentMaxWidth}px !important; margin-left: -#{leftMargin}px !important;}
        .license-selector .ls-modal-close:after { margin-right: #{closeButtonMarginRight}px !important; }
      """)
    else
      currentMaxWidth = MODAL_MAX_WIDTH - (margin * 2)
      leftMargin = currentMaxWidth / 2
      stylesheet.html("""
        .license-selector .ls-modal { max-width: #{currentMaxWidth}px; margin-left: -#{leftMargin}px;}
        .license-selector .ls-modal-close:after { margin-right: -#{leftMargin}px !important; }
      """)

  $(window).on 'resize', scale

  # create jquery && DOM
  constructor: (@parent) ->
    @element = $('<section/>')
      .addClass('license-selector')
      .attr(
        tabindex: '-1'
        'aria-hidden': 'true'
        role: 'dialog'
      ).on 'show.lsmodal', scale
    inner = $('<div/>').addClass('ls-modal')
    @header = $('<header/>')
      .append($('<h2/>').text('Choose a license'))
      .append($('<p/>').text('Answer the questions or use the search to find the license you want'))
      .appendTo(inner)

    @content = $('<div/>').addClass('ls-modal-content').appendTo(inner)

    closeButton = $('<a/>')
      .addClass('ls-modal-close')
      .attr(
        'title': 'Close License Selector'
        'data-dismiss': 'modal'
        'data-close': 'Close'
      )
      .click(=> @hide())

    @element.append(inner)
      .append(closeButton)
      .appendTo(@parent)

  hide: ->
    @element.removeClass('is-active')
      .trigger('hide.lsmodal')
      .attr('aria-hidden', 'true')

  show: ->
    @element.addClass('is-active')
      .trigger('show.lsmodal')
      .attr('aria-hidden', 'false')

class Search
  constructor: (@parent, @licenseList) ->
    @textbox = $('<input/>')
      .attr(
        type: 'text',
        placeholder: 'Search for a license...'
      )
      .on 'input', => @licenseList.filter(@textbox.val())

    @container = $('<div/>')
      .addClass('ls-search')
      .append(@textbox)
      .appendTo(@parent)

  hide: -> @container.hide()

  show: -> @container.show()

class LicenseList
  comperator = (obj, text) ->
    text = (''+text).toLowerCase()
    return (''+obj).toLowerCase().indexOf(text) > -1

  constructor: (@parent, @licenseSelector) ->
    @availableLicenses = _.where @licenseSelector.licenses, { available: true }
    @list = $('<ul />')
    @error = $('<div/>').addClass('ls-not-found').append($('<h4/>').text('No license found')).append('Try change the search criteria or start the questionnaire again.')
    @error.hide()
    @container = $('<div class="ls-license-list" />')
      .append(@error)
      .append(@list)
      .appendTo(@parent)
    @update()

  createElement: (license) ->
    el = $ '<li />'
    select = (e) =>
      return if e.target && $(e.target).is('button, a')
      @selectLicense(license, el)
      @licenseSelector.selectLicense license
      e.preventDefault()
      e.stopPropagation()

    chooseButton = $('<button/>')
      .append($('<span/>').addClass('ls-select').text('Select'))
      .append($('<span/>').addClass('ls-confirm').text('Confirm'))
      .click(select)
    el.click(select)
    h = $('<h4 />').text(license.name)
    h.append($('<a/>').attr({
      href: license.url
      target: '_blank'
    }).addClass('ls-button').text('See full text')) if license.url
    h.append(chooseButton)
    el.append(h)
    el.append($('<p />').text(license.description)) unless _.isEmpty(license.description)
    el.data 'license', license
    return el

  hide: ->
    @parent.hide()
    @licenseSelector.searchModule.hide()

  show: ->
    @parent.show()
    @licenseSelector.searchModule.show()

  filter: (newterm) ->
    if (newterm isnt @term)
      @term = newterm
      @update()
    return

  sortLicenses: (licenses) -> _.sortBy(licenses, ['priority','name'])

  selectLicense: (license, element) ->
    selectedLicense = @deselectLicense()
    if selectedLicense? and selectedLicense is license
      return
    element.addClass 'ls-active'
    @selectedLicense =
      license: license
      element: element

  deselectLicense: ->
    @selectedLicense ?= {}
    {element, license} = @selectedLicense
    element.removeClass 'ls-active' if element
    @selectedLicense = {}
    return license

  matchFilter: (license) ->
    return false unless license.available
    return true unless @term
    return comperator(license.name, @term) || comperator(license.description, @term)

  update: (licenses) ->
    unless licenses?
      licenses = @availableLicenses
    else
      licenses = @availableLicenses = _.where licenses, { available: true }

    elements = {}
    for el in @list.children()
      el = $(el)
      license = el.data 'license'
      if licenses[license.key]? and @matchFilter(licenses[license.key])
        elements[licenses.key] = el
      else
        el.remove()

    previous = null
    for license in @sortLicenses(licenses)
      continue unless @matchFilter(license)
      if elements[license.key]?
        previous = elements[license.key]
      else
        el = @createElement license
        if previous?
          previous.after el
        else
          @list.prepend el
        previous = el

    if @list.children().size() == 0
      @error.show()
    else
      @error.hide()
    return

  has: (category) ->
    _.any @availableLicenses, (license) ->
      _.contains(license.categories, category)

  only: (category) ->
    _.all @availableLicenses, (license) ->
      _.contains(license.categories, category)

  hasnt: (category) ->
    _.all @availableLicenses, (license) ->
      !_.contains(license.categories, category)

  include: (category) ->
    @availableLicenses = _.filter @availableLicenses, (license) -> _.contains(license.categories, category)
    @update()

  exclude: (category) ->
    @availableLicenses = _.filter @availableLicenses, (license) -> !_.contains(license.categories, category)
    @update()

class LicenseSelector
  @defaultOptions =
    onLicenseSelected: _.noop
    appendTo: 'body'
    start: 'KindOfContent'

  constructor: (@licenses, @questions, @options = {}) ->
    _.defaults(@options, LicenseSelector.defaultOptions)

    for key, license of @licenses
      license.key = key

    @state = {}
    @modal = new Modal($(@options.appendTo))
    @licensesList = new LicenseList(@modal.content, this)

    @historyModule = new History(@modal.header, this)
    @questionModule = new Question(@modal.header, this)
    @searchModule = new Search(@modal.header, @licensesList)

    @goto @options.start

  restart: ->
    @licensesList.update(@licenses)
    @historyModule.reset()
    @state = {}
    @goto @options.start
    return

  setState: (state) ->
    @state = state
    @licensesList.update(state.licenses)
    @goto @state.question, false
    return

  selectLicense: (license, force = false) ->
    if @selectedLicense is license or force
      @options.onLicenseSelected(license)
      @modal.hide()
    else
      @selectedLicense = license

  license: (choices...) ->
    if choices? and choices.length > 0
      licenses = []
      for choice in _.flatten(choices)
        license = @licenses[choice] if _.isString(choice)
        licenses.push license
      @licensesList.update(licenses)
      @state.licenses = licenses
    # if (@licensesList.availableLicenses.length == 1)
    #   @licensesList.selectLicense(@licensesList.availableLicenses[0])
    @state.finished = true
    @historyModule.pushState(@state)
    @questionModule.finished()
    return

  cantlicense: (reason) ->
    @questionModule.setError(reason)
    return

  goto: (where, safeState = true) ->
    @questionModule.show() unless @state.finished
    @questionModule.hide() if @state.finished
    if safeState
      @state.question = where
      @state.licenses ?= @licenses
      @state.finished = false
    func = @questions[where]
    func.call(@)

    @historyModule.pushState(@state) if safeState
    return

  question: (text) ->
    # setting question also resets the whole module
    @questionModule.setQuestion(text)
    @state.options = null
    return

  answer: (text, action, disabled = _.noop) ->
    @questionModule.addAnswer
      text: text
      action: _.bind(action, @, @state)
      disabled: _.bind(disabled, @, @state)
    return

  option: (list, action = _.noop) ->
    option =
      licenses: (@licenses[license] for license in list)
      action: _.bind(action, @, @state)
    @state.options ?= []
    @state.options.push(option)
    @questionModule.addOption option
    return

  yes: (action) -> @answer 'Yes', action
  no: (action) -> @answer 'No', action

  has: (category) -> @licensesList.has(category)
  only: (category) -> @licensesList.only(category)
  hasnt: (category) -> @licensesList.hasnt(category)
  include: (category) ->
    @licensesList.include(category)
    @state.licenses = _.clone @licensesList.availableLicenses
  exclude: (category) ->
    @licensesList.exclude(category)
    @state.licenses = _.clone @licensesList.availableLicenses


$.fn.licenseSelector = (options, args...) ->
  return @each ->
    if args.length > 0
      throw new Error('Method has to be a string') unless _.isString(options)
      ls = $(this).data('license-selector')
      method = ls[options]
      throw new Error("Method #{options} does't exists") unless method?
      return method.apply(ls, args)

    licenses = _.merge(LicenseDefinitions, options.licenses)
    questions = _.merge(QuestionDefinitions, options.questions)
    delete options.questions
    delete options.licenses
    ls = new LicenseSelector(licenses, questions, options)
    $(this).data('license-selector', ls)
    $(this).click (e) ->
      ls.modal.show()
      e.preventDefault()
