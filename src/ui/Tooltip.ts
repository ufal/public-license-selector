interface TooltipOptions {
  position?: 'top' | 'right' | 'bottom' | 'left'
  preserve?: boolean
  container?: HTMLElement
  beforeShow?: (tooltip: Tooltip, anchor: HTMLElement, el: HTMLElement) => boolean
}

let stylesheet: HTMLStyleElement | null = null

function ensureStylesheet(): CSSStyleList {
  if (!stylesheet) {
    stylesheet = document.createElement('style')
    document.head.appendChild(stylesheet)
  }
  return stylesheet.sheet!
}

export class Tooltip {
  private position: 'top' | 'right' | 'bottom' | 'left' = 'top'
  private preserve = false
  private container: HTMLElement | false = false
  private beforeShow: ((tooltip: Tooltip, anchor: HTMLElement, el: HTMLElement) => boolean) | undefined
  private hovered = false
  private wrapper: HTMLDivElement
  private el: HTMLElement
  private anchor: HTMLElement

  constructor(el: HTMLElement | string, anchor: HTMLElement | string, options: TooltipOptions = {}) {
    this.position = options.position ?? this.position
    this.preserve = options.preserve ?? this.preserve
    this.container = (options.container && !(options.container instanceof HTMLElement)) ? document.querySelector(options.container) as HTMLElement : (options.container ?? false)
    this.beforeShow = options.beforeShow

    this.wrapper = document.createElement('div')
    this.wrapper.className = `ls-tooltip-wrapper ls-tooltip-${this.position}`

    if (typeof el === 'string') {
      this.el = document.createElement('div')
      this.el.innerHTML = el
    } else {
      this.el = el
    }
    this.wrapper.appendChild(this.el)

    if (typeof anchor === 'string') {
      this.anchor = document.querySelector(anchor)!
    } else {
      this.anchor = anchor
    }
    this.anchor.style.position = 'relative'

    const onEnter = () => { if (!this.hovered) { this.hovered = true; this.show() } }
    const onLeave = () => { if (this.hovered) { this.hovered = false; this.hide() } }

    this.anchor.addEventListener('mouseenter', onEnter)
    this.anchor.addEventListener('mouseleave', onLeave)
    this.anchor.addEventListener('focusin', onEnter)
    this.anchor.addEventListener('focusout', onLeave)
  }

  show(): this {
    if (!this.beforeShow || this.beforeShow(this, this.anchor, this.el)) {
      const target = this.container ?? this.anchor.parentElement
      target?.appendChild(this.wrapper)
      this.move()
    }
    return this
  }

  hide(): this {
    this.wrapper.remove()
    this.hovered = false
    return this
  }

  move(): this {
    const wrapperRect = this.wrapper.getBoundingClientRect()
    const anchorRect = this.anchor.getBoundingClientRect()
    const anchorOffset = this.anchor.offsetParent
      ? { left: this.anchor.offsetLeft, top: this.anchor.offsetTop }
      : { left: 0, top: 0 }

    const wWidth = wrapperRect.width
    const wHeight = wrapperRect.height
    const aWidth = anchorRect.width
    const aHeight = anchorRect.height

    let left = anchorOffset.left
    let top = anchorOffset.top

    switch (this.position) {
      case 'top':
        left += (aWidth - wWidth) / 2
        top -= wHeight
        break
      case 'right':
        left += aWidth
        top += (aHeight - wHeight) / 2
        break
      case 'bottom':
        left += (aWidth - wWidth) / 2
        top += aHeight
        break
      case 'left':
        left -= wWidth
        top += (aHeight - wHeight) / 2
        break
    }

    this.wrapper.style.left = `${left}px`
    this.wrapper.style.top = `${top}px`

    // Re-measure after positioning
    const newRect = this.wrapper.getBoundingClientRect()
    if (newRect.width > wWidth || newRect.height > wHeight) {
      this.move()
    }
    return this
  }

  destroy(): void {
    this.hide()
    // Remove listeners — since we used inline arrow functions, we can't remove them directly.
    // Instead, we just remove the wrapper to clean up.
  }
}
