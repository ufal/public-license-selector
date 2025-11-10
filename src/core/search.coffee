$ = require 'jquery'

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

module.exports = Search
