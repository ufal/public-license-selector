import { LabelsDefinitions, type LabelDef } from '../data/labels'
import type LicenseSelectorInstance from '../LicenseSelector'

function comperator(obj: unknown, text: string): boolean {
  return ('' + text).toLowerCase().indexOf(('' + obj).toLowerCase()) > -1
}

export class LicenseList {
  availableLicenses: Array<LicenseSelectorInstance['licenses'][string]>
  private list: HTMLUListElement
  private readonly error: HTMLElement
  private term = ''

  constructor(parent: HTMLElement | string, private licenseSelector: LicenseSelectorInstance) {
    const target = typeof parent === 'string' ? document.querySelector(parent)! : parent

    this.availableLicenses = Object.values(licenseSelector.licenses).filter((l) => l.available)
    this.list = document.createElement('ul')

    this.error = document.createElement('div')
    this.error.className = 'ls-not-found'
    const h4 = document.createElement('h4')
    h4.textContent = 'No license found'
    this.error.appendChild(h4)
    this.error.appendChild(document.createTextNode('Try change the search criteria or start the questionnaire again.'))
    this.error.style.display = 'none'

    const container = document.createElement('div')
    container.className = 'ls-license-list'
    container.appendChild(this.error)
    container.appendChild(this.list)

    target.appendChild(container)
    this.update()
  }

  createElement(license: LicenseSelectorInstance['licenses'][string]): HTMLElement {
    let customTemplate = false
    const el: HTMLElement & { _license?: typeof license } = document.createElement('li')

    const select = (e: Event | undefined) => {
      this.selectLicense(license, el)
      this.licenseSelector.selectLicense(license)
      if (e) {
        e.preventDefault()
        e.stopPropagation()
      }
    }

    if (license.template) {
      if (typeof license.template === 'function') {
        (license.template as (el: HTMLElement, license: typeof license, select: (e?: Event) => void) => void)(el, license, select)
        customTemplate = true
      } else if (license.template instanceof HTMLElement) {
        el.appendChild(license.template as HTMLElement)
      }
    } else {
      el.title = 'Click to select the license'

      const h4 = document.createElement('h4')
      h4.textContent = license.name
      el.appendChild(h4)

      if (license.url) {
        const link = document.createElement('a')
        link.href = license.url
        link.target = '_blank'
        link.className = 'ls-button'
        link.textContent = 'See full text'
        h4.appendChild(link)
      }

      if (license.description && license.description.length > 0) {
        const p = document.createElement('p')
        p.textContent = license.description
        el.appendChild(p)
      }

      const labels: string[] = license.labels ?? []

      if (this.licenseSelector.options.showLabels) {
        const labelDiv = document.createElement('div')
        labelDiv.className = 'ls-labels'

        for (const labelKey of labels) {
          const d = LabelsDefinitions[labelKey] as LabelDef | undefined
          if (!d) continue

          const item = document.createElement('span')
          item.className = 'ls-label'
          if (d.parentClass) labelDiv.classList.add(d.parentClass)
          if (d.itemClass) item.className += ' ' + d.itemClass
          if (d.text) item.textContent = d.text
          if (d.title) item.title = d.title
          labelDiv.appendChild(item)
        }

        el.appendChild(labelDiv)
      }
    }

    if (license.cssClass) {
      el.classList.add(license.cssClass)
    }

    if (!customTemplate) {
      el.addEventListener('click', (e: Event) => {
        const target = e.target as HTMLElement
        if (target.tagName === 'BUTTON' || target.tagName === 'A') return
        select(e)
      })
    }

    ;(el as any)._license = license
    return el
  }

  hide(): void {
    this.list.parentElement!.style.display = 'none'
    this.licenseSelector.searchModule.hide()
  }

  show(): void {
    this.list.parentElement!.style.display = ''
    this.licenseSelector.searchModule.show()
  }

  filter(newTerm: string): void {
    if (newTerm !== this.term) {
      this.term = newTerm
      this.update()
    }
  }

  private sortLicenses(licenses: typeof this.availableLicenses): typeof this.availableLicenses {
    return [...licenses].sort((a, b) => (a.priority - b.priority) || (a.name.localeCompare(b.name)))
  }

  selectLicense(license: typeof this.availableLicenses[number], element: HTMLElement): void {
    const prev = this.deselectLicense()
    if (prev && prev === license) return
    element.classList.add('ls-active')
    this.selectedLicense = { license, element }
  }

  private selectedLicense: { license: typeof this.availableLicenses[number]; element: HTMLElement } = {} as any

  deselectLicense(): typeof this.availableLicenses[number] | undefined {
    const { element, license } = this.selectedLicense
    if (element) element.classList.remove('ls-active')
    this.selectedLicense = {} as any
    return license ?? undefined
  }

  private matchFilter(license: typeof this.availableLicenses[number]): boolean {
    if (!license.available) return false
    if (!this.term) return true
    return comperator(license.name, this.term) || comperator(license.description ?? '', this.term)
  }

  update(licenses?: (typeof this.availableLicenses)[number][]): void {
    let licList: typeof this.availableLicenses
    if (licenses) {
      licList = Object.values(licenses).filter((l) => l.available)
      this.availableLicenses = licList
    } else {
      licList = this.availableLicenses
    }

    const existingElements = new Map<string, HTMLElement>()
    for (const child of Array.from(this.list.children)) {
      const el = child as HTMLElement & { _license?: typeof this.availableLicenses[number] }
      if (el._license) {
        const key = el._license.key ?? el._license.name
        if (licList.some((l) => (l.key ?? l.name) === key) && this.matchFilter(el._license)) {
          existingElements.set(key, el)
        } else {
          el.remove()
        }
      }
    }

    let previous: HTMLElement | undefined
    for (const license of this.sortLicenses(licList)) {
      if (!this.matchFilter(license)) continue
      const key = license.key ?? license.name

      if (existingElements.has(key)) {
        previous = existingElements.get(key)
      } else {
        const el = this.createElement(license)
        if (previous) {
          previous.after(el)
        } else {
          this.list.prepend(el)
        }
        previous = el
      }
    }

    if (this.list.children.length === 0) {
      this.error.style.display = ''
    } else {
      this.error.style.display = 'none'
    }
  }

  has(category: string): boolean {
    return this.availableLicenses.some((l) => l.categories.includes(category))
  }

  only(category: string): boolean {
    return this.availableLicenses.every((l) => l.categories.includes(category))
  }

  hasnt(category: string): boolean {
    return this.availableLicenses.every((l) => !l.categories.includes(category))
  }

  include(category: string): void {
    this.availableLicenses = this.availableLicenses.filter((l) => l.categories.includes(category))
    this.update()
  }

  exclude(category: string): void {
    this.availableLicenses = this.availableLicenses.filter((l) => !l.categories.includes(category))
    this.update()
  }
}
