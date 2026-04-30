import { addExplanations } from '../helpers/explanations'
import type { Tooltip } from './Tooltip'

interface OptionDef {
  licenses: Array<{ name: string }>
  selected: boolean
}

interface AnswerDef {
  text: string
  action: () => void
  disabled: () => boolean
}

export class Question {
  private readonly element: HTMLElement
  private readonly errorContainer: HTMLDivElement
  private readonly error: HTMLSpanElement
  private readonly text: HTMLParagraphElement
  private readonly options: HTMLUListElement
  private readonly answers: HTMLElement

  constructor(parent: HTMLElement | string, private licenseSelector: {
    licensesList: { show: () => void; hide: () => void }
    container: HTMLElement | string
    state: { options?: OptionDef[] }
    historyModule: { setOptionSelected: (index: number, selected: boolean) => void }
  }) {
    const target = typeof parent === 'string' ? document.querySelector(parent)! : parent

    this.element = document.createElement('div')
    this.element.className = 'ls-question'

    this.errorContainer = document.createElement('div')
    this.errorContainer.className = 'ls-question-error'
    const errorH4 = document.createElement('h4')
    errorH4.textContent = "Can't choose a license"
    this.errorContainer.appendChild(errorH4)
    this.error = document.createElement('span')
    this.errorContainer.appendChild(this.error)
    this.errorContainer.style.display = 'none'

    this.text = document.createElement('p')
    this.text.className = 'ls-question-text'

    const optionsWrapper = document.createElement('div')
    optionsWrapper.className = 'ls-question-options'

    this.options = document.createElement('ul')
    this.answers = document.createElement('div')
    this.answers.className = 'ls-question-answers'

    optionsWrapper.appendChild(this.options)
    this.element.appendChild(this.errorContainer)
    this.element.appendChild(this.text)
    this.element.appendChild(optionsWrapper)
    this.element.appendChild(this.answers)

    target.appendChild(this.element)
  }

  show(): void { this.element.style.display = '' }
  hide(): void { this.element.style.display = 'none' }

  reset(): void {
    this.errorContainer.style.display = 'none'
    this.answers.innerHTML = ''
    this.options.innerHTML = ''
    this.options.style.display = 'none'
    this.licenseSelector.licensesList.show()
  }

  finished(): void {
    this.hide()
    this.licenseSelector.licensesList.show()
  }

  setQuestion(text: string): void {
    this.reset()
    this.text.innerHTML = ''
    this.text.insertAdjacentHTML('beforeend', addExplanations(text))
  }

  addAnswer(answer: AnswerDef): void {
    const button = document.createElement('button')
    button.textContent = answer.text
    button.disabled = answer.disabled()
    button.addEventListener('click', () => answer.action())
    this.answers.appendChild(button)
  }

  addOption(option: OptionDef): void {
    this.options.style.display = ''
    this.licenseSelector.licensesList.hide()

    const li = document.createElement('li')
    const checkbox = document.createElement('input')
    checkbox.type = 'checkbox'
    checkbox.checked = option.selected

    const questionState = this.licenseSelector.state as { options?: Array<{ selected: boolean }> }
    checkbox.addEventListener('click', () => {
      option.selected = checkbox.checked
      const index = questionState.options?.indexOf(option) ?? -1
      if (index >= 0) {
        this.licenseSelector.historyModule.setOptionSelected(index, checkbox.checked)
      }
    })

    const label = document.createElement('label')
    label.appendChild(checkbox)

    const span = document.createElement('span')
    for (const lic of option.licenses) {
      const nameSpan = document.createElement('span')
      nameSpan.className = 'ls-license-name'
      nameSpan.textContent = lic.name
      span.appendChild(nameSpan)
    }
    label.appendChild(span)
    li.appendChild(label)
    this.options.appendChild(li)
  }

  setError(html: string): void {
    this.errorContainer.style.display = ''
    this.error.innerHTML = addExplanations(html)
    this.licenseSelector.licensesList.hide()
  }
}
