$ = require 'jquery'
_ = require 'lodash'
LicenseSelector = require '../core/license-selector'
LicenseDefinitions = require '../data/licenses'
QuestionDefinitions = require '../data/questions'

###
# Module: plugins/jquery.coffee
# Summary: jQuery integration that initiates or dispatches methods on `LicenseSelector` instances.
###
$.fn.licenseSelector = (options, args...) ->
  return @each ->
    if args.length > 0
      throw new Error('Method has to be a string') unless _.isString(options)
      ls = $(this).data('license-selector')
      method = ls[options]
      throw new Error("Method #{options} does't exists") unless method?
      return method.apply(ls, args)

    licenses = _.merge(_.cloneDeep(LicenseDefinitions), options.licenses)
    questions = _.merge(_.cloneDeep(QuestionDefinitions), options.questions)
    delete options.questions
    delete options.licenses
    ls = new LicenseSelector(licenses, questions, options)
    $(this).data('license-selector', ls)
    $(this).click (e) ->
      ls.modal.show()
      e.preventDefault()

module.exports = $.fn.licenseSelector
