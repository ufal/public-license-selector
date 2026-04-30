import { Tooltip } from './Tooltip'

interface HistoryState {
  question?: string
  questionText?: string
  licenses: unknown[]
  finished?: boolean
  answer?: string
  options?: Array<{ licenses: Array<{ name: string }>; selected: boolean }>
}

export class History {
  private current = -1
  private historyStack: HistoryState[] = []
  private prevButton: HTMLButtonElement
  private nextButton: HTMLButtonElement
  private restartButton: HTMLButtonElement
  private progress: HTMLElement
  private selectorContainer: HTMLElement

  constructor(parent: HTMLElement | string, private selector: {
    container: HTMLElement | string
    restart: () => void
    setState: (state: HistoryState) => void
  }) {
    const target = typeof parent === 'string' ? document.querySelector(parent)! : parent

    this.selectorContainer = typeof selector.container === 'string'
      ? document.querySelector(selector.container)!
      : selector.container

    this.prevButton = this.createNavButton('ls-history-prev', 'Previous question')
    this.prevButton.addEventListener('click', () => this.go(this.current - 1))

    this.nextButton = this.createNavButton('ls-history-next', 'Next question')
    this.nextButton.disabled = true
    this.nextButton.addEventListener('click', () => this.go(this.current + 1))

    this.restartButton = document.createElement('button')
    this.restartButton.className = 'ls-restart'
    this.restartButton.title = 'Start again'
    const restartIcon = document.createElement('span')
    restartIcon.className = 'icon-ccw'
    this.restartButton.appendChild(restartIcon)
    this.restartButton.appendChild(document.createTextNode(' Start again'))
    this.restartButton.addEventListener('click', () => this.selector.restart())

    this.progress = document.createElement('div')
    this.progress.className = 'ls-history-progress'

    const historyContainer = document.createElement('div')
    historyContainer.className = 'ls-history'
    historyContainer.appendChild(this.restartButton)
    historyContainer.appendChild(this.prevButton)
    historyContainer.appendChild(this.progress)
    historyContainer.appendChild(this.nextButton)

    this.setupTooltips(historyContainer)
    target.appendChild(historyContainer)
    this.update()
  }

  go(point: number): void {
    this.current = point
    const state = structuredClone(this.historyStack[this.current]) as HistoryState
    this.selector.setState(state)
    this.update()
  }

  reset(): void {
    this.current = -1
    this.historyStack = []
    this.progress.innerHTML = ''
    this.update()
  }

  setAnswer(text: string): void {
    if (this.current === -1) return
    const state = this.historyStack[this.current]
    state.answer = text
  }

  setOptionSelected(index: number, value: boolean): void {
    if (this.current === -1) return
    const state = this.historyStack[this.current]
    state.options![index].selected = value
  }

  private createNavButton(className: string, title: string): HTMLButtonElement {
    const button = document.createElement('button')
    button.className = className
    button.title = title
    const iconSpan = document.createElement('span')
    iconSpan.className = className.includes('prev') ? 'icon-left' : 'icon-right'
    button.appendChild(iconSpan)
    return button
  }

  private setupTooltips(root: HTMLElement): void {
    const buttons = root.querySelectorAll('[title]')
    buttons.forEach((el) => {
      const title = el.getAttribute('title') ?? ''
      el.removeAttribute('title')
      this.makeTooltip(el, title)
    })
  }

  private makeTooltip(anchor: HTMLElement, initialText: string): void {
    const tooltipEl = document.createElement('div')
    tooltipEl.className = 'ls-tooltip'
    tooltipEl.textContent = initialText

    const tooltip = new Tooltip(tooltipEl, anchor, {
      container: this.selectorContainer,
    })

    anchor.addEventListener('mouseenter', () => tooltip.show())
    anchor.addEventListener('mouseleave', () => tooltip.hide())
    anchor.addEventListener('focusin', () => tooltip.show())
    anchor.addEventListener('focusout', () => tooltip.hide())
  }

  update(): void {
    const progressBarBlocks = Array.from(this.progress.children)

    if (progressBarBlocks.length > 0) {
      progressBarBlocks.forEach((b) => b.classList.remove('ls-active'))
      const activeBlock = this.historyStack[this.current] ? progressBarBlocks[this.current] : undefined
      activeBlock?.classList.add('ls-active')
    }

    this.nextButton.disabled = this.historyStack.length === 0 || this.historyStack.length === this.current + 1
    this.prevButton.disabled = this.current <= 0
  }

  createProgressBlock(): HTMLButtonElement {
    const self = this
    const block = document.createElement('button')
    block.innerHTML = '&nbsp;'

    block.addEventListener('click', () => {
      const index = Array.from(self.progress.children).indexOf(block)
      self.go(index)
    })

    const tooltipEl = document.createElement('div')
    tooltipEl.className = 'ls-tooltip'

    new Tooltip(tooltipEl, block, {
      container: this.selectorContainer,
      beforeShow: (_tooltip, _anchor, el) => {
        const index = Array.from(self.progress.children).indexOf(block)
        const state = self.historyStack[index] as HistoryState | undefined

        el.innerHTML = ''
        if (!state) return true

        if (!state.finished) {
          if (state.questionText) {
            const p = document.createElement('p')
            p.textContent = state.questionText
            el.appendChild(p)
          }
          if (state.options) {
            const selected = state.options.filter((o) => o.selected)
            if (selected.length > 0) {
              const ul = document.createElement('ul')
              for (const option of selected) {
                const li = document.createElement('li')
                const span = document.createElement('span')
                for (const lic of option.licenses) {
                  const nameSpan = document.createElement('span')
                  nameSpan.className = 'ls-license-name'
                  nameSpan.textContent = lic.name
                  span.appendChild(nameSpan)
                }
                li.appendChild(span)
                ul.appendChild(li)
              }
              el.appendChild(ul)
            }
          } else if (state.answer) {
            const p = document.createElement('p')
            p.innerHTML = `Answered: <strong>${state.answer}</strong>`
            el.appendChild(p)
          }
        } else {
          const p1 = document.createElement('p')
          p1.textContent = 'Final Step'
          el.appendChild(p1)
          const p2 = document.createElement('p')
          p2.textContent = 'Choose your license below ...'
          el.appendChild(p2)
        }
        return true
      },
    })

    return block
  }

  pushState(state: HistoryState): void {
    const cloned = structuredClone(state) as HistoryState

    this.current += 1
    if (this.historyStack.length > this.current) {
      this.historyStack = this.historyStack.slice(0, this.current)
    }
    this.historyStack.push(cloned)

    const progressBarBlocks = this.progress.children.length
    const index = this.current + 1

    if (progressBarBlocks !== index) {
      if (progressBarBlocks > index) {
        const toRemove = this.progress.children.length - index
        for (let i = 0; i < toRemove; i++) {
          this.progress.lastChild?.remove()
        }
      } else {
        this.progress.appendChild(this.createProgressBlock())
      }
    }

    this.update()
  }
}
