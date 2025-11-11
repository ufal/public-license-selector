_ = require 'lodash'
LicenseCompatibility = require './compatibility'

###
# Module: data/questions.coffee
# Summary: Decision tree functions invoked by `LicenseSelector.goto`.
###
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
    @question 'Is your data within the scope of copyright and related rights?'
    @yes -> @goto 'OwnIPR'
    @no -> @license 'cc-public-domain'

  OwnIPR: ->
    @question 'Do you own copyright and similar rights in your dataset and all its constitutive parts?'
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
    @question 'Are all the elements of your dataset licensed under a public license or in the Public Domain?'
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
            @cantlicense "The licenses <strong>#{license1.name}</strong> and <strong>#{license2.name}</strong> in your software are incompatible. Contact the copyright owner and try to talk them into re-licensing."
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
    @question 'Do you require others who modify your code to release it under a compatible licence?'
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

module.exports = QuestionDefinitions
