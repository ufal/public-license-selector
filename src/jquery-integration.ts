import { LicenseSelector, type LicenseSelectorOptions } from './LicenseSelector'
import { LicenseDefinitions } from './data/licenses'
import { QuestionDefinitions } from './data/questions'

// Optional jQuery integration: registers $.fn.licenseSelector when jQuery is available
(function () {
  if (typeof window === 'undefined') return

  // Check for jQuery on window
  const jq = (window as unknown as Record<string, unknown>).$ as any
  if (!jq) return

  // Register jQuery plugin method: $(selector).licenseSelector(options)
  jq.fn.licenseSelector = function (this: JQuery, options: LicenseSelectorOptions & { licenses?: Record<string, unknown>; questions?: Record<string, unknown> }, ...args: unknown[]) {
    return this.each(function () {
      if (args.length > 0) {
        throw new Error('Method has to be a string')
      }

      const mergedLicenses = options?.licenses
        ? Object.assign({}, LicenseDefinitions, options.licenses) as Record<string, unknown>
        : LicenseDefinitions

      const mergedQuestions = options?.questions
        ? Object.assign({}, QuestionDefinitions, options.questions)
        : QuestionDefinitions

      const opts: LicenseSelectorOptions = Object.assign({}, options, { appendTo: this })
      delete (opts as any).licenses
      delete (opts as any).questions

      const selector = new LicenseSelector(mergedLicenses as any, mergedQuestions as any, opts)
      jq(this).data('license-selector', selector)

      // On click, show the modal
      jq(this).on('click.license-selector', function (e: Event) {
        selector.modal.show()
        e.preventDefault()
      })
    })
  }

  // Expose classes and data for external access via jQuery namespace
  jq.LicenseSelector = LicenseSelector
  jq.LicenseDefinitions = LicenseDefinitions
  jq.QuestionDefinitions = QuestionDefinitions
})()
