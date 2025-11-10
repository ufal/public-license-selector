$ = require 'jquery'
_ = require 'lodash'

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

module.exports = Tooltip
