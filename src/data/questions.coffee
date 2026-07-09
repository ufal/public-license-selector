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

  # ──────────────────────────────────────────────────────────────
  # Data path
  # ──────────────────────────────────────────────────────────────

  DataCopyrightable: ->
    @question 'Is your data within the scope of copyright and/or special right of the database maker?'
    @yes -> @goto 'AllOriginalWork'
    @no -> @license 'cc-public-domain'

  AllOriginalWork: ->
    @question 'Is everything in the dataset your original work?'
    @yes -> @goto 'AllowDerivativeWorks'
    @no -> @goto 'ThirdPartyPublic'

  AllowDerivativeWorks: ->
    @question 'Do you allow others to make derivative works?'
    @yes ->
      @exclude 'nd'
      @goto 'ShareAlike'
    @no ->
      @include 'nd'
      @goto 'CommercialUse'

  ShareAlike: ->
    @question 'Do you require others to share derivative works based on your data under the same license?'
    @yes ->
      @include 'sa'
      @goto 'CommercialUse'
    @no ->
      @exclude 'sa'
      @goto 'CommercialUse'

  CommercialUse: ->
    @question 'Do you allow others to use your data commercially?'
    @yes ->
      @exclude 'nc'
      @license()
    @no ->
      @include 'nc'
      @include 'by'
      @license()

  ThirdPartyPublic: ->
    @question 'Is the third party content of the dataset licensed under a public license or in the public domain?'
    @yes -> @goto 'MadeChanges'
    @no -> @cantlicense 'You need additional permission before you can deposit the data!'

  MadeChanges: ->
    @question 'Have you made any changes to the third party content of the dataset?'
    @yes -> @goto 'ThirdPartyLicense'
    @no -> @goto 'AllowDerivativeWorks'

  ThirdPartyLicense: ->
    @question 'Under which license was the third party content that you changed licensed?'
    @answer 'Public Domain or CC Zero', -> @goto 'AllowDerivativeWorks'
    @answer 'CC BY', -> @goto 'AllowDerivativeWorks'
    @answer 'CC BY-NC', -> @goto 'ThirdPartyNCDerivatives'
    @answer 'CC BY-SA', -> @license 'cc-by-sa'
    @answer 'CC BY-NC-SA', ->
      @cantlicense 'The license of the third party content does not allow redistribution under different terms.'
    @answer 'CC BY-ND', ->
      @cantlicense 'The license of the third party content does not allow derivative works.'
    @answer 'CC BY-NC-ND', ->
      @cantlicense 'The license of the third party content does not allow derivative works.'

  ThirdPartyNCDerivatives: ->
    @question 'Do you allow others to make derivative works?'
    @yes -> @goto 'ThirdPartyNCShareAlike'
    @no -> @license 'cc-by-nc-nd'

  ThirdPartyNCShareAlike: ->
    @question 'Do you require others to share derivative works based on your data under the same license?'
    @yes -> @license 'cc-by-nc-sa'
    @no -> @license 'cc-by-nc'

  # ──────────────────────────────────────────────────────────────
  # Software path
  # ──────────────────────────────────────────────────────────────

  YourSoftware: ->
    @question 'Is your software based on existing code or is it all your original work?'
    @answer 'Based on existing software', -> @goto 'ModifyingExisting'
    @answer 'My own code', -> @goto 'Copyleft'

  ModifyingExisting: ->
    @question 'Are you modifying the existing software or is the existing software only being used as a part of your larger work?'
    @answer 'Modifying the existing software', -> @goto 'LicenseInteropSoftware'
    @answer 'Only being used as a part of your larger work', ->
      @include 'weak'
      @license()

  LicenseInteropSoftware: ->
    @question 'Select licenses in your code:'
    for license in LicenseCompatibility.columns
      @option [license]

    nextAction = (state) ->
      licenses = _(state.options).filter('selected').pluck('licenses').flatten().valueOf()
      return if licenses.length is 0
      selectedLicenses = licenses.slice()
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

      # Enforce version constraints: if a selected license has a fixed version,
      # restrict the result list to that exact license key.
      for sel in selectedLicenses
        if sel.versionConstraint is 'fixed'
          licenses = (l for l in licenses when l.key is sel.key)
          break

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
    @question 'Do you require others who use your code in their software to release it under a compatible open-source license?'
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
    @question 'Do you require others to use a compatible license for the software as a whole or only for the parts that modified your code?'
    @answer 'For the software as a whole', ->
      @include 'strong'
      @license()
    @answer 'Only for the parts that modified my code', ->
      @include 'weak'
      @license()

module.exports = QuestionDefinitions
