ClarinLicenseDefinitions =
  'clarin-aca':
    name: 'CLARIN Academic End-User License (ACA)'
    priority: 10
    available: true
    url: 'https://kitwiki.csc.fi/twiki/pub/FinCLARIN/ClarinEULA/CLARIN-EULA-ACA-2014-10.rtf'
    description: 'CLARIN Academic End-User License grants you right to use and/or make copies of the data for educational,‭ ‬teaching or research purposes.'
    categories: ['aca', 'data']
    labels: ['aca', 'by', 'nc']

  'clarin-res':
    name: 'CLARIN Restricted End-User License (ACA)'
    priority: 10
    available: true
    url: 'https://kitwiki.csc.fi/twiki/pub/FinCLARIN/ClarinEULA/CLARIN-EULA-RES-2014-10.rtf'
    description: 'CLARIN Academic End-User License grants you right to use and/or make copies of the data only for personal purposes.'
    categories: ['res', 'data']
    labels: ['res', 'nc', 'nd']

ClarinQuestionDefinitions =
  LimitAccess: ->
    @question 'How do you want to limit access to your data?'
    @answer 'Publicly available', ->
      @include 'public'
      @goto 'AllowDerivativeWorks'
    @answer 'Only academic', ->
      @include 'aca'
      @license()
    @answer 'Further restricted', ->
      @include 'res'
      @license()

  OwnIPR: ->
    @question 'Do you own copyright and similar rights in your dataset and all its constitutive parts?'
    @yes -> @goto 'LimitAccess'
    @no -> @goto 'EnsureLicensing'

$.fn.clarinLicenseSelector = (options, args...) ->
  if !options or _.isObject(options)
    options.showLabels = true
    options.licenses = _.merge(_.cloneDeep(ClarinLicenseDefinitions), options.licenses)
    options.questions = _.merge(_.cloneDeep(ClarinQuestionDefinitions), options.questions)

  args = [] unless _.isArray(args)
  args.unshift(options)
  return $.fn.licenseSelector.apply(@, args)
