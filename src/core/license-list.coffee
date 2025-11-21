$ = require 'jquery'
_ = require 'lodash'
LabelsDefinitions = require '../data/labels'

###
# Class: LicenseList
# Summary: Renders available licenses, applies filters, and reports selections back to the selector.
# Responsibilities:
# - Generates default list items, including labels pulled from `data/labels`.
# - Keeps `@availableLicenses` in sync with include/exclude helpers and search terms.
# - Toggles the error banner when no licenses match and coordinates with the search header.
###
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
      if e?
        e.preventDefault()
        e.stopPropagation()

    if license.template
      if _.isFunction(license.template)
        license.template(el, license, select)
        customTemplate = true
      else if license.template instanceof $
        el.append(license.template)
    else
      el.attr('title', 'Click to select the license')
      h = $('<h4 />').text(license.name)
      h.append($('<a/>').attr({
        href: license.url
        target: '_blank'
      }).addClass('ls-button').text('See full text')) if license.url
      el.append(h)
      el.append($('<p />').text(license.description)) unless _.isEmpty(license.description)
      license.labels ||= []

      if @licenseSelector.options.showLabels
        l = $('<div/>').addClass('ls-labels')
        for label in license.labels
          continue unless LabelsDefinitions[label]

          d = LabelsDefinitions[label]
          l.addClass(d.parentClass) if d.parentClass
          item = $('<span/>').addClass('ls-label')
          item.addClass(d.itemClass) if d.itemClass
          item.text(d.text) if d.text
          item.attr('title', d.title) if d.title
          l.append(item)

        el.append(l)

    el.addClass(license.cssClass) if license.cssClass

    unless customTemplate
      el.click (e) ->
        return if e.target && $(e.target).is('button, a')
        select(e)

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

module.exports = LicenseList
