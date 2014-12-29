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


LabelsDefinitions =
  public:
    text: 'Publicly Available'
    title: 'Under this license your resource will be publicly available'
    itemClass: 'ls-label-public'
  aca:
    text: 'Academic Use'
    title: 'License restricts the use only for research and educational purposes'
    itemClass: 'ls-label-aca'
  res:
    text: 'Restricted Use'
    title: 'License further restricts the use'
    itemClass: 'ls-label-res'
  pd:
    title: 'Public Domain Mark'
    itemClass: 'ls-icon-pd'
  cc:
    title: 'Creative Commons'
    itemClass: 'ls-icon-cc'
  zero:
    title: 'Creative Commons Zero'
    itemClass: 'ls-icon-zero'
  by:
    title: 'Attribution required'
    itemClass: 'ls-icon-by'
  sa:
    title: 'Share-alike'
    itemClass: 'ls-icon-sa'
  nd:
    title: 'No Derivative Works'
    itemClass: 'ls-icon-nd'
  nc:
    title: 'Noncommercial'
    itemClass: 'ls-icon-nc'
  perl:
    title: 'Recommended for Perl software'
    itemClass: 'ls-icon-perl'
  osi:
    title: 'Approved by Open Source Initiative'
    itemClass: 'ls-icon-osi'
  gpl:
    title: 'General Public License'
    itemClass: 'ls-icon-gpl'
  gpl3:
    title: 'Latest General Public License version 3.0'
    itemClass: 'ls-icon-gpl3'
  agpl3:
    title: 'Latest Affero General Public License version 3.0'
    itemClass: 'ls-icon-agpl3'
  lgpl:
    title: 'Library General Public License'
    itemClass: 'ls-icon-lgpl'
  lgpl3:
    title: 'Latest Library General Public License version 3.0'
    itemClass: 'ls-icon-lgpl3'
  copyleft:
    title: 'Copyleft'
    itemClass: 'ls-icon-copyleft'
  mozilla:
    title: 'License endorsed by Mozilla Foundation'
    itemClass: 'ls-icon-mozilla'
  mit:
    title: 'MIT License'
    itemClass: 'ls-icon-mit'
  bsd:
    title: 'BSD License'
    itemClass: 'ls-icon-bsd'
  apache:
    title: 'License endorsed by Apache Foundation'
    itemClass: 'ls-icon-apache'
  eclipse:
    title: 'License endorsed by Eclipse Foundation'
    itemClass: 'ls-icon-eclipse'

$.fn.clarinLicenseSelector = (options, args...) ->
  if !options or _.isObject(options)
    options.licenses = _.merge(_.cloneDeep(ClarinLicenseDefinitions), options.licenses)
    options.questions = _.merge(_.cloneDeep(ClarinQuestionDefinitions), options.questions)

  args = [] unless _.isArray(args)
  args.unshift(options)
  return $.fn.licenseSelector.apply(@, args)
