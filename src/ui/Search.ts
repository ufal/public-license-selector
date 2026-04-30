export class Search {
  private textbox: HTMLInputElement
  readonly container: HTMLElement

  constructor(parent: HTMLElement | string, private licenseList: { filter: (term: string) => void }) {
    const target = typeof parent === 'string' ? document.querySelector(parent)! : parent

    this.textbox = document.createElement('input')
    this.textbox.type = 'text'
    this.textbox.placeholder = 'Search for a license...'
    this.textbox.addEventListener('input', () => this.licenseList.filter(this.textbox.value))

    this.container = document.createElement('div')
    this.container.className = 'ls-search'
    this.container.appendChild(this.textbox)
    target.appendChild(this.container)
  }

  hide(): void { this.container.style.display = 'none' }
  show(): void { this.container.style.display = '' }
}
