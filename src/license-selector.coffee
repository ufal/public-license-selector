EVENT_NS = 'license-selector'

# keyword : text
Explanations =
  'the scope of copyright and related rights': """
<p>
Copyright protects original works. Originality is defined as the author’s own
intellectual creation. Therefore, mere statements of historical facts, results
of measurements etc. are not protected by copyright, because they exist
objectively and therefore cannot be <em>created</em>. The same applies to ideas,
mathematical formulas, elements of folklore etc. While quantitative data are
usually not protected by copyright, qualitative data (as their creation
involve some intellectual judgment) or language data are usually
copyrightable.
</p>
<p>
Apart from copyright in the data itself, a compilation of data (a dataset) may
also be protected by copyright as an original work. It is the case when the
selection and arrangement of the dataset involves some degree of intellectual
creation or choice. This is not the case when the guiding principle of the
collection is exhaustivity and/or completeness. For example, while <em>My
favorite works of William Shakespeare</em> will most likely be an original
collection, <em>Complete works of William Shakespeare</em> will not, as it leaves
no room for personal creativity.
</p>
<p>
The investment (of money and/or labor) into the making of the dataset is
irrelevant from the point of view of copyright law; however, a substantial
investment into the creation of a database may attract a specific kind of
protection, the sui generis database right. If your data and your dataset are
not original, but you made a substantial investment into the making of a
database, you can still benefit from legal protection (in such a case, answer
YES to this question).
</p>
<p>Answer <strong>Yes</strong> if ...</p>
<ul>
  <li>selecting a license for language data (in most cases)</li>
  <li>selecting a license for original (creative) selection or arrangement of the dataset</li>
  <li>substantial investment went into the making of the database</li>
  <li>you are not sure that the answer should be <strong>No</strong></li>
</ul>
<p>answer <strong>No</strong> if ...</p>
<ul>
  <li>your dataset contains only quantitative data and/or raw facts</li>
  <li>your dataset is exhaustive and complete (or at least aims to be)</li>
  <li>only if you are sure!</li>
</ul>
"""
  'copyright and similar rights': """
<p>
<strong>copyright</strong> &ndash; protects original works or original compilations of works
</p>
<p>
<strong>sui generis database rights</strong> &ndash; protects substantial investment into the making of a database
</p>
"""
  'licensed under a public license': """
<p>
By <em>licensed</em> data we understand data available under a public license, such
as Creative Commons or ODC licenses. If you have a bespoke license for the
data (i.e. a license drafted for a specific contractual agreement, such as
between a publisher and a research institution), contact our legal help desk.
</p>
"""
  'Public Domain': """
<p>
Public Domain is a category including works that are not protected by
copyright (such as raw facts, ideas) or that are no longer protected by
copyright (copyright expires 70 years after the death of the author). In many
jurisdictions, some official texts such as court decisions or statutes are
also regarded as part of the public domain.
</p>
"""
  'additional permission': """
<p>
In order to be able to deposit your data in our repository, you will have to
contact the copyright holder (usually the publisher or the author) and ask him
for a written permission to do so. Our legal help desk will help you draft the
permission. We will also tell you what to do if you cannot identify the
copyright holder.
</p>
"""
  'derivative works': """
<p>
Derivative works are works that are derived from or based upon an original
work and in which the original work is translated, altered, arranged,
transformed, or otherwise modified. This category does not include parodies.
</p>
<p>
Please note that the use of language resources consists of making derivative
works. If you do not allow others to build on your work, it will be of very
little use for the community.
</p>
"""
  'commercial use': """
<p>
Commercial use is a use that is primarily intended for or directed towards
commercial advantage or monetary compensation.
</p>
<p>
Please note that the meaning of this term is not entirely clear (although it
seems to be generally agreed upon that academic research, even carried out by
professional researchers, is not commercial use) and if you choose this
restriction, it may have a chilling effect on the re-use of your resource by
some projects (public-private partnerships).
</p>
"""
  'attribute': """
<p>
It is your moral right to have your work attributed to you (i.e. your name
mentioned every time someone uses your work). However, be aware of the fact
that the attribution requirement in Creative Commons licenses is more extended
than just mentioning your name.
</p>
<p>
In fact, the attribution clause in Creative Commons licenses obliges the user
to mention a whole set of information (identity of the creator, a copyright
notice, a reference to the chosen CC license and a hyperlink to its text, a
disclaimer of warranties, an indication of any modifications made to the
original work and even a hyperlink to the work itself). This may lead to a
phenomenon known as <em>attribution stacking</em>, which will make your work
difficult to compile with other works.
</p>
"""

ExplanationsTerms = _.keys(Explanations)

addExplanations = (text) ->
  for term in ExplanationsTerms
    index = text.indexOf(term)
    if ( index >= 0 )
      text = text.substring(0,index) +
        '<span class="ls-term">' +
        text.substring(index, index + term.length) +
        '</span>' + text.substring(index + term.length)
  return text

explanationTooltips = (scope, container) ->
  $('.ls-term', scope).each ->
    $el = $(this)
    term = $el.html()
    return unless Explanations[term]
    new Tooltip($('<div />').addClass('ls-term-tooltip').html(Explanations[term]), $el, {
      'container': container
      position: 'bottom'
    })
    return
  return


# Inspired by devblog.orgsync.com/hangover/
class Tooltip
  constructor: (el, anchor, options) ->
    # defaults
    @position = 'top' # The position of $el relative to the $anchor.
    @preserve = false # Preserve $el's listeners and data by using detach instead of remove.
    @container = false # Append to specified container
    @beforeShow = false # Before show callback - used often to populate tooltip
    _.extend(@, options) if options
    @container = $(@container) if @container && !(@container instanceof $)
    @hovered = false
    _.bindAll(@, ['onEvenIn', 'onEventOut'])
    @buildContainer().setElement(el).setAnchor(anchor)

  buildContainer: ->
    @$wrapper = $('<div/>')
      .addClass('ls-tooltip-wrapper')
      .addClass("ls-tooltip-#{@position}")
    @

  setElement: (el) ->
    @$wrapper.empty().append(@$el = if el instanceof $ then el else $(el))
    @

  setAnchor: (anchor) ->
    @$anchor.css('position', null) if @$anchor
    @$anchor = if anchor instanceof $ then anchor else $(anchor)
    @$anchor.on(
      focusin: @onEvenIn
      mouseenter: @onEvenIn
      mouseleave: @onEventOut
      focusout: @onEventOut
    ).css('position', 'relative')
    @

  show: ->
    if !@beforeShow || @beforeShow(@, @$anchor, @$el)
      if @container
        @container.append(@$wrapper)
      else
        @$anchor.parent().append(@$wrapper)
      @move()
    @

  hide: ->
    @$wrapper[if @preserve then 'detach' else 'remove' ]()
    @hovered = false
    @

  move: ->
    $wrapper = @$wrapper
    $anchor = @$anchor
    wWidth = $wrapper.outerWidth()
    wHeight = $wrapper.outerHeight()
    aWidth = $anchor.outerWidth()
    aHeight = $anchor.outerHeight()
    aPosition = $anchor.offset()
    position =
      left: aPosition.left + parseInt($anchor.css('marginLeft'), 10)
      top: aPosition.top + parseInt($anchor.css('marginTop'), 10)

    switch @position
      when 'top'
        position.left += (aWidth - wWidth) / 2
        position.top -= wHeight
      when 'right'
        position.left += aWidth
        position.top += (aHeight - wHeight) / 2
      when 'bottom'
        position.left += (aWidth - wWidth) / 2
        position.top += aHeight
      when 'left'
        position.left -= wWidth
        position.top += (aHeight - wHeight) / 2
    $wrapper.css(position)
    @move() if ($wrapper.outerWidth() > wWidth || $wrapper.outerHeight() > wHeight)
    @

  destroy: ->
    @hide()
    @$anchor.off
      focusin: @onEvenIn
      mouseenter: @onEvenIn
      mouseleave: @onEventOut
      focusout: @onEventOut
    @

  onEvenIn  : ->
    return if (@hovered)
    @hovered = true
    @show()

  onEventOut: ->
    return unless (@hovered)
    @hovered = false
    @hide()

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
    history = $('<div/>').addClass('ls-history')
      .append(@restartButton)
      .append(@prevButton)
      .append(@progress)
      .append(@nextButton)
      .appendTo(@parent)
    @setupTooltips(history)
    @update()

  go: (point) ->
    @current = point
    state = _.cloneDeep @historyStack[@current]
    @licenseSelector.setState state
    @update()
    return

  reset: ->
    @current = -1
    @historyStack = []
    @progress.empty()
    @update()
    return

  setupTooltips: (root) ->
    self = @
    $('[title]', root).each ->
      $el = $(@)
      title = $el.attr('title')
      $el.removeAttr('title')
      new Tooltip($('<div />').addClass('ls-tooltip').text(title), $el, { container: self.licenseSelector.container })
      return
    return

  setAnswer: (text) ->
    return if @current == -1
    state = @historyStack[@current]
    state.answer = text
    return

  setOptionSelected: (option, value) ->
    return if @current == -1
    state = @historyStack[@current]
    state.options[option].selected = value
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

  createProgressBlock: ->
    self = @
    block = $('<button/>')
      .html('&nbsp;')
      .click -> self.go(self.progress.children().index(@))
    new Tooltip($('<div/>').addClass('ls-tooltip'), block, {
      container: self.licenseSelector.container
      beforeShow: (tooltip, block, el) ->
        index = self.progress.children().index(block.get(0))
        state = self.historyStack[index]
        el.empty()
        unless state.finished
          el.append($('<p/>').text(state.questionText))
          if state.options
            ul = $('<ul />')
            for option in state.options
              continue unless option.selected
              span = $('<span/>')
              for license in option.licenses
                span.append($('<span/>').addClass('ls-license-name').text(license.name))
              ul.append($('<li />').append(span))
            el.append(ul)
          else
            el.append($('<p/>').html("Answered: <strong>#{state.answer}</strong>")) if (state.answer)
        else
          el.append($('<p/>').text("Final Step"))
          el.append($('<p/>').text("Choose your license below ..."))
        return true
    })
    return block

  pushState: (state) ->
    # shallow clone of the state
    state = _.cloneDeep state

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
        @progress.append(@createProgressBlock())
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
    @text.empty().append(addExplanations(text))
    explanationTooltips(@text, @licenseSelector.container)
    return

  addAnswer: (answer) ->
    button = $('<button />')
      .text(answer.text)
      .click(-> answer.action())
      .prop('disabled', answer.disabled())
    @element.on('update-answers', -> button.prop('disabled', answer.disabled()))
    @answers.append(button)
    return

  addOption: (option) ->
    @options.show()
    @licenseSelector.licensesList.hide()
    element = @element
    self = @

    checkbox = $('<input/>')
      .attr('type', 'checkbox')
      .prop('checked', option.selected)
      .click(->
        option.selected = this.checked
        index = self.licenseSelector.state.options.indexOf(option)
        self.licenseSelector.historyModule.setOptionSelected(index, option.selected)
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
    @error.html(addExplanations(html))
    explanationTooltips(@error, @licenseSelector.container)
    @licenseSelector.licensesList.hide()
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
      .append($('<h2/>').text('Choose a License'))
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
    customTemplate = false
    el = $ '<li />'
    select = (e) =>
      @selectLicense(license, el)
      @licenseSelector.selectLicense license
      e.preventDefault()
      e.stopPropagation()

    if license.template
      if _.isFunction(license.template)
        license.template(el, license, select)
        customTemplate = true
      else if license.template instanceof $
        el.append(license.template)
    else
      chooseButton = $('<button/>')
        .append($('<span/>').addClass('ls-select').text('Select'))
        .append($('<span/>').addClass('ls-confirm').text('Confirm'))
        .click(select)

      h = $('<h4 />').text(license.name)
      h.append($('<a/>').attr({
        href: license.url
        target: '_blank'
      }).addClass('ls-button').text('See full text')) if license.url
      h.append(chooseButton)
      el.append(h)
      el.append($('<p />').text(license.description)) unless _.isEmpty(license.description)
      el.addClass(_.map(license.categories, (cat) -> 'ls-category-' + cat).join(' ')) if license.categories
      el.addClass(license.cssClass) if license.cssClass

    unless customTemplate
      el.click (e) ->
        return if e.target && $(e.target).is('button, a')
        select()

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
        elements[license.key] = el
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
    licenseItemTemplate: null
    appendTo: 'body'
    start: 'KindOfContent'


  constructor: (@licenses, @questions, @options = {}) ->
    _.defaults(@options, LicenseSelector.defaultOptions)

    for key, license of @licenses
      license.key = key
      if @options.licenseItemTemplate and !license.template
        license.template = @options.licenseItemTemplate

    @state = {}
    @container = if @options.appendTo instanceof $ then @options.appendTo else $(@options.appendTo)
    @modal = new Modal(@container)
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
    @questionModule.setQuestion(state.questionText)
    @questionModule.show() unless @state.finished
    @questionModule.hide() if @state.finished

    if state.options
      for option in state.options
        @questionModule.addOption(option)
    for answer in state.answers
      @questionModule.addAnswer(answer)

    @licensesList.update(state.licenses)
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
    delete @state.options
    delete @state.answers
    @state.answer = false
    @state.finished = false
    @state.questionText = text
    return

  answer: (text, action, disabled = _.noop) ->
    answer =
      text: text
      action: =>
        @historyModule.setAnswer(text)
        action.call(@, @state)
      disabled: => disabled.call(@, @state)

    @state.answer = false
    @state.answers ?= []
    @state.answers.push(answer)
    @questionModule.addAnswer(answer)
    return

  option: (list, action = _.noop) ->
    option =
      licenses: (@licenses[license] for license in list)
      action: => action.call(@, @state)
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

    licenses = _.merge(_.cloneDeep(LicenseDefinitions), options.licenses)
    questions = _.merge(_.cloneDeep(QuestionDefinitions), options.questions)
    delete options.questions
    delete options.licenses
    ls = new LicenseSelector(licenses, questions, options)
    $(this).data('license-selector', ls)
    $(this).click (e) ->
      ls.modal.show()
      e.preventDefault()
