$ = require 'jquery'
_ = require 'lodash'
{addExplanations, explanationTooltips} = require '../helpers/explanations.coffee'

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

module.exports = Question
