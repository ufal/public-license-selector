export class Modal {
  private static readonly SMALL_BREAKPOINT = 480
  private static readonly MAX_WIDTH = 800
  private static stylesheet: HTMLStyleElement | null = null

  readonly element: HTMLElement
  readonly header: HTMLElement
  readonly content: HTMLElement

  constructor(parent: HTMLElement | string) {
    const target = typeof parent === 'string' ? document.querySelector(parent)! : parent

    this.element = document.createElement('section')
    this.element.className = 'license-selector'
    this.element.tabIndex = -1
    this.element.setAttribute('aria-hidden', 'true')
    this.element.setAttribute('role', 'dialog')

    const inner = document.createElement('div')
    inner.className = 'ls-modal'

    this.header = document.createElement('header')
    const h2 = document.createElement('h2')
    h2.textContent = 'Choose a License'
    const p = document.createElement('p')
    p.textContent = 'Answer the questions or use the search to find the license you want'
    this.header.appendChild(h2)
    this.header.appendChild(p)

    this.content = document.createElement('div')
    this.content.className = 'ls-modal-content'

    const closeBtn = document.createElement('a')
    closeBtn.className = 'ls-modal-close'
    closeBtn.title = 'Close License Selector'
    closeBtn.setAttribute('data-dismiss', 'modal')
    closeBtn.setAttribute('data-close', 'Close')
    closeBtn.href = '#'
    closeBtn.addEventListener('click', (e) => {
      e.preventDefault()
      this.hide()
    })

    inner.appendChild(this.header)
    inner.appendChild(this.content)
    this.element.appendChild(inner)
    this.element.appendChild(closeBtn)

    target.appendChild(this.element)

    window.addEventListener('resize', Modal.onResize)
  }

  private static onResize(): void {
    const width = window.innerWidth
    const margin = 10
    let css: string

    if (width < Modal.MAX_WIDTH) {
      const currentMaxWidth = width - margin * 2
      const leftMargin = currentMaxWidth / 2
      const closeBtnMarginRight = '-' + Math.floor(currentMaxWidth / 2)
      css = `.license-selector .ls-modal { max-width: ${currentMaxWidth}px !important; margin-left: -${leftMargin}px !important; }` +
        `.license-selector .ls-modal-close:after { margin-right: ${closeBtnMarginRight}px !important; }`
    } else {
      const currentMaxWidth = Modal.MAX_WIDTH - margin * 2
      const leftMargin = currentMaxWidth / 2
      css = `.license-selector .ls-modal { max-width: ${currentMaxWidth}px; margin-left: -${leftMargin}px; }` +
        `.license-selector .ls-modal-close:after { margin-right: -${leftMargin}px !important; }`
    }

    if (!Modal.stylesheet) {
      Modal.stylesheet = document.createElement('style')
      document.head.appendChild(Modal.stylesheet)
    }
    Modal.stylesheet.textContent = css
  }

  hide(): this {
    this.element.classList.remove('is-active')
    this.element.setAttribute('aria-hidden', 'true')
    return this
  }

  show(): this {
    this.element.classList.add('is-active')
    this.element.setAttribute('aria-hidden', 'false')
    Modal.onResize()
    return this
  }
}
