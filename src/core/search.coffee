$ = require 'jquery'

###
# Class: Search
# Summary: Provides the header search input and forwards queries to `LicenseList.filter`.
# Responsibilities:
# - Owns a text box bound to `input` events and forwards values to the list.
# - Toggles visibility alongside the license list as questions demand.
###
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
