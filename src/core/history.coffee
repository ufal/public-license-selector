$ = require 'jquery'
_ = require 'lodash'
Tooltip = require './tooltip'

###
# Class: History
# Summary: Maintains a stack of answered states and powers back/forward navigation.
# Responsibilities:
# - Deep-clones selector state in `pushState` and trims future history when rewinding.
# - Renders progress buttons with tooltips summarising past asnwers/options.
# - Exposes `setAnswer` and `setOptionSelected` so the Question module updates snapshots after input.
###
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

module.exports = History
