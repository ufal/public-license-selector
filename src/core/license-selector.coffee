$ = require 'jquery'
_ = require 'lodash'

Modal = require './modal'
History = require './history'
Question = require './question'
Search = require './search'
LicenseList = require './license-list'

###
# Class: LicenseSelector
# Summary: Coordinates the modal UI, question flow, search, and license list state.
# Responsibilities:
# - Normalises license definitions and bootstraps submodules (modal, history, question, search, list).
# - Provides DSL helpers (`@question`, `@answer`, `@include`, etc.) consumed by question definitions.
# - Tracks selection state, triggers callbacks, and pushes snapshots into the history stack.
###
class LicenseSelector
  @defaultOptions =
    showLabels: true
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

module.exports = LicenseSelector
