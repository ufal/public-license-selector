$ = require 'jquery'

###
# Class: Modal
# Summary: Builds and manages the overlay container for the selector.
# Responsibilities:
# - Creates structural DOM (header, content area, close button) and attaches to the append target.
# - Handles responsive scaling by updating injected `<style>` rules on window resize or show.
###
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

module.exports = Modal
