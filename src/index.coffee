###
# Module: index.coffee
# Summary: Entry point that re-exports the selector and bundled data helpers.
###
LicenseSelector = require './core/license-selector'
LicenseDefinitions = require './data/licenses'
LicenseCompatibility = require './data/compatibility'
QuestionDefinitions = require './data/questions'
LabelsDefinitions = require './data/labels'

require './plugins/jquery'

module.exports =
  LicenseSelector: LicenseSelector
  LicenseDefinitions: LicenseDefinitions
  LicenseCompatibility: LicenseCompatibility
  QuestionDefinitions: QuestionDefinitions
  LabelsDefinitions: LabelsDefinitions
