import { LicenseDefinitions, type LicenseDef } from './data/licenses'
import { QuestionDefinitions, type LicenseSelector as QuestionDSL, type HistoryState } from './data/questions'
import { Modal } from './ui/Modal'
import { Question } from './ui/Question'
import { Search } from './ui/Search'
import { LicenseList } from './ui/LicenseList'
import { History } from './ui/History'

export interface LicenseSelectorOptions {
  showLabels?: boolean
  onLicenseSelected?: (license: LicenseDef) => void
  licenseItemTemplate?: ((el: HTMLElement, license: LicenseDef, select: (e?: Event) => void) => void) | HTMLElement
  appendTo?: string | HTMLElement
  start?: string
}

interface QuestionState {
  question?: string
  questionText?: string
  licenses?: LicenseDef[]
  finished?: boolean
  answer?: string
  options?: Array<{ licenses: LicenseDef[]; selected: boolean }>
}

interface AnswerRecord {
  text: string
  action: () => void
  disabled: () => boolean
}

// Option with action callback (used internally)
interface OptionWithAction {
  licenses: LicenseDef[]
  selected: boolean
  _action?: () => void
}

export class LicenseSelector implements QuestionDSL {
  static defaultOptions: Required<LicenseSelectorOptions> = {
    showLabels: true,
    onLicenseSelected: () => {},
    licenseItemTemplate: null,
    appendTo: 'body',
    start: 'KindOfContent',
  }

  licenses: Record<string, LicenseDef>
  questions = QuestionDefinitions
  container: HTMLElement
  options: Required<LicenseSelectorOptions>

  // Sub-modules (public for access by question functions and other modules)
  modal!: Modal
  licensesList!: LicenseList
  historyModule!: History
  questionModule!: Question
  searchModule!: Search

  private state: QuestionState = {}
  selectedLicense?: LicenseDef

  constructor(licenses: Record<string, LicenseDef>, questions: typeof QuestionDefinitions, options: LicenseSelectorOptions = {}) {
    this.options = { ...LicenseSelector.defaultOptions, ...options }
    this.licenses = licenses
    this.questions = questions

    for (const key in licenses) {
      if (Object.prototype.hasOwnProperty.call(licenses, key)) {
        const lic = licenses[key]
        if (!lic.key) lic.key = key
        if (this.options.licenseItemTemplate && !lic.template) {
          lic.template = this.options.licenseItemTemplate
        }
      }
    }

    this.container = typeof this.options.appendTo === 'string'
      ? document.querySelector(this.options.appendTo)!
      : this.options.appendTo

    this.modal = new Modal(this.container)
    this.licensesList = new LicenseList(this.modal.content, this)
    this.historyModule = new History(this.modal.header, this)
    this.questionModule = new Question(this.modal.header, this)
    this.searchModule = new Search(this.modal.header, this.licensesList)

    this.gotoInternal(this.options.start ?? 'KindOfContent')
  }

  restart(): void {
    for (const key in this.licenses) {
      if (this.options.licenseItemTemplate && !this.licenses[key].template) {
        this.licenses[key].template = this.options.licenseItemTemplate
      }
    }

    this.licensesList.update(Object.values(this.licenses))
    this.historyModule.reset()
    this.state = {}
    this.gotoInternal(this.options.start ?? 'KindOfContent')
  }

  setState(state: HistoryState): void {
    const s = state as QuestionState

    this.questionModule.setQuestion(s.questionText ?? '')
    if (s.finished) {
      this.questionModule.hide()
    } else {
      this.questionModule.show()
    }

    if (s.options) {
      for (const option of s.options as OptionWithAction[]) {
        this.questionModule.addOption(option)
      }
    }

    if (s.answers && Array.isArray(s.answers)) {
      for (const answer of s.answers as AnswerRecord[]) {
        this.questionModule.addAnswer(answer)
      }
    }

    if (s.licenses) {
      this.licensesList.update(s.licenses as LicenseDef[])
    }

    this.state.questionText = s.questionText
    this.state.finished = s.finished
  }

  selectLicense(license: LicenseDef, force = false): void {
    if (this.selectedLicense === license || force) {
      this.options.onLicenseSelected?.(license)
      this.modal.hide()
    } else {
      this.selectedLicense = license
    }
  }

  license(...choices: (string | string[])[]): void {
    if (choices && choices.length > 0) {
      const licenses: LicenseDef[] = []
      for (const choice of choices.flat()) {
        if (typeof choice === 'string') {
          const lic = this.licenses[choice]
          if (lic) licenses.push(lic)
        }
      }
      this.licensesList.update(licenses)
      this.state.licenses = licenses
    }
    this.state.finished = true
    this.historyModule.pushState(this.state as unknown as HistoryState)
    this.questionModule.finished()
  }

  cantlicense(reason: string): void {
    this.questionModule.setError(reason)
  }

  goto(where: string, safeState = true): void {
    this.gotoInternal(where, safeState)
  }

  private gotoInternal(where: string, safeState = true): void {
    if (this.state.finished) {
      this.questionModule.hide()
    } else {
      this.questionModule.show()
    }

    if (safeState) {
      this.state.question = where
      this.state.licenses = this.state.licenses || Object.values(this.licenses)
      this.state.finished = false
    }

    const func = this.questions[where]
    if (func) {
      func(this)
    }

    if (safeState) {
      this.historyModule.pushState(this.state as unknown as HistoryState)
    }
  }

  question(text: string): void {
    this.questionModule.setQuestion(text)
    delete (this.state as any).options
    delete (this.state as any).answers
    this.state.answer = '' as unknown as string
    this.state.finished = false
    this.state.questionText = text
  }

  answer(text: string, action: () => void, disabled = () => false): void {
    const answerObj: AnswerRecord = {
      text,
      action: () => {
        this.historyModule.setAnswer(text)
        action.call(this)
      },
      disabled,
    }

    this.state.answer = '' as unknown as string
    if (!this.state.answers) {
      ;(this.state as any).answers = []
    }
    ;(this.state as any).answers.push(answerObj)
    this.questionModule.addAnswer(answerObj)
  }

  option(list: string[], action = () => {}): void {
    const licenseRefs = list.map((key) => this.licenses[key]).filter(Boolean) as LicenseDef[]
    const optionObj: OptionWithAction = {
      licenses: licenseRefs,
      selected: false,
    }

    // Store the action callback on the option for later execution (e.g., Next button)
    optionObj._action = () => action.call(this)

    if (!this.state.options) {
      this.state.options = [] as OptionWithAction[]
    }
    // Push to state first, then pass the SAME reference to question module
    ;(this.state.options as OptionWithAction[]).push(optionObj)
    this.questionModule.addOption(optionObj)
  }

  yes(action: () => void): void {
    this.answer('Yes', action)
  }

  no(action: () => void): void {
    this.answer('No', action)
  }

  has(category: string): boolean {
    return this.licensesList.has(category)
  }

  only(category: string): boolean {
    return this.licensesList.only(category)
  }

  hasnt(category: string): boolean {
    return this.licensesList.hasnt(category)
  }

  include(category: string): void {
    this.licensesList.include(category)
    this.state.licenses = [...this.licensesList.availableLicenses]
  }

  exclude(category: string): void {
    this.licensesList.exclude(category)
    this.state.licenses = [...this.licensesList.availableLicenses]
  }

  hasAnyOptionSelected(): boolean {
    return (this.state.options as OptionWithAction[]).some((o) => o.selected)
  }

  // Internal accessor for getting selected license keys (used by LicenseInteropSoftware)
  getSelectedLicenseKeys(): string[] {
    const keys: string[] = []
    for (const opt of this.state.options as OptionWithAction[]) {
      if (opt.selected) {
        for (const lic of opt.licenses) {
          keys.push(lic.key ?? '')
        }
      }
    }
    return keys.filter(Boolean)
  }

  // Internal accessor for question functions that need to run selected option actions
  _getSelectedAction(): (() => void) | undefined {
    if (!this.state.options?.length) return undefined
    const options = this.state.options as OptionWithAction[]
    for (let i = options.length - 1; i >= 0; i--) {
      if (options[i].selected && typeof options[i]._action === 'function') {
        return options[i]._action
      }
    }
    return undefined
  }
}
