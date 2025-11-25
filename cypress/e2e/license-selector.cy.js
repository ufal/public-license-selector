describe('License Selector E2E Tests', () => {

  beforeEach(() => {
    cy.visit('/')
  })

  describe('Page Load and Basic Structure', () => {

    it('should load the page successfully', () => {
      cy.url().should('include', 'ufal.github.io/public-license-selector')
      cy.get('body').should('be.visible')
    })

    it('should have correct page title', () => {
      cy.title().should('include', 'License Selector')
    })

    it('should display the main heading', () => {
      cy.get('h1').should('contain', 'License Selector')
    })

    it('should have the license selector links visible', () => {
      cy.contains('a', 'Click to open selector').should('exist')
    })

    it('should load without console errors', () => {
      cy.visit('/', {
        onBeforeLoad(win) {
          cy.spy(win.console, 'error').as('consoleError')
        }
      })
      cy.get('@consoleError').should('not.have.been.called')
    })
  })

  describe('Assets Loading', () => {

    it('should load jQuery from CDN', () => {
      cy.window().should('have.property', 'jQuery')
      cy.window().should('have.property', '$')
    })

    it('should load lodash from CDN', () => {
      cy.window().should('have.property', '_')
    })

    it('should load the license selector plugin', () => {
      cy.window().then((win) => {
        expect(win.$.fn).to.have.property('licenseSelector')
      })
    })

    it('should have CSS loaded correctly', () => {
      cy.get('.license-selector').should('have.css', 'position')
    })
  })

  describe('License Selector Modal - Auto-Open Behavior', () => {

    it('should automatically open the modal on page load', () => {
      cy.modalShouldBeVisible()
    })

    it('should display modal with is-active class', () => {
      cy.get('.license-selector.is-active').should('exist')
    })

    it('should display modal header with title', () => {
      cy.get('.ls-modal header h2').should('contain', 'Choose a License')
    })

    it('should display modal body with content', () => {
      cy.get('.ls-modal-content').should('be.visible')
      cy.get('.ls-modal-content').children().should('have.length.gt', 0)
    })

    it('should have a close button', () => {
      cy.get('.ls-modal-close').should('be.visible')
    })

    it('should close modal when clicking close button', () => {
      cy.closeModal()
      cy.get('.license-selector').should('not.have.class', 'is-active')
    })

    it('should reopen modal when clicking the selector link', () => {
      cy.closeModal()
      cy.reopenLicenseSelector()
      cy.modalShouldBeVisible()
    })
  })

  describe('Questionnaire Flow - Initial Question', () => {

    it('should display the first question on load', () => {
      cy.get('.ls-question-text').should('contain', 'deposit')
    })

    it('should display answer buttons', () => {
      cy.get('.ls-question-answers button').should('have.length.gt', 0)
    })

    it('should have Software and Data buttons', () => {
      cy.get('.ls-question-answers').should('contain', 'Software')
      cy.get('.ls-question-answers').should('contain', 'Data')
    })

    it('should allow clicking Software button', () => {
      cy.clickAnswer('Software')
      cy.get('.ls-question-text').should('be.visible')
    })

    it('should allow clicking Data button', () => {
      cy.clickAnswer('Data')
      cy.get('.ls-question-text').should('be.visible')
    })
  })

  describe('Questionnaire Flow - Data Path', () => {

    beforeEach(() => {
      cy.clickAnswer('Data')
    })

    it('should show copyright question after selecting Data', () => {
      cy.get('.ls-question-text').should('contain', 'copyright')
    })

    it('should have Yes/No buttons', () => {
      cy.get('.ls-question-answers button').should('contain', 'Yes')
        .and('contain', 'No')
    })

    it('should navigate through the questionnaire', () => {
      cy.get('.ls-question-answers button').contains('Yes').click()

      cy.get('.ls-question').should('be.visible')
    })

    it('should eventually show licenses', () => {
      cy.get('.ls-question-answers button').contains('No').click()

      cy.get('.ls-license-list').should('be.visible')
    })
  })

  describe('License List Display', () => {

    it('should display licenses after completing questionnaire', () => {
      cy.clickAnswer('Data')
      cy.get('.ls-question-answers button').contains('No').click()

      cy.licensesShouldBeVisible()
    })

    it('should display license items with names', () => {
      cy.clickAnswer('Data')
      cy.get('.ls-question-answers button').contains('No').click()

      cy.get('.ls-license-list ul li h4').should('exist')
    })

    it('should have clickable license items', () => {
      cy.clickAnswer('Data')
      cy.get('.ls-question-answers button').contains('No').click()

      cy.get('.ls-license-list ul li').first().should('be.visible')
    })

    it('should display "See full text" links', () => {
      cy.clickAnswer('Data')
      cy.get('.ls-question-answers button').contains('No').click()

      cy.get('.ls-license-list .ls-button').should('exist')
    })
  })

  describe('Responsive Design', () => {

    it('should display correctly on desktop (1920x1080)', () => {
      cy.viewport(1920, 1080)
      cy.visit('/')

      cy.modalShouldBeVisible()

      cy.get('.ls-question').should('be.visible')

      cy.get('.ls-question-answers button').should('be.visible')
    })
  })

  describe('Performance', () => {

    it('should load the DOMContentLoaded event within acceptable time', () => {
      cy.visit('/')
      cy.window().its('performance.timing').then((timing) => {
        const domContentLoaded = timing.domContentLoadedEventEnd - timing.navigationStart
        expect(domContentLoaded).to.be.lessThan(3000)
      })
    })

    it('should open modal quickly (auto-opens)', () => {
      cy.visit('/')
      cy.modalShouldBeVisible()
    })

    it('should respond to clicks quickly', () => {
      cy.clickAnswer('Data')
      cy.get('.ls-question-text').should('be.visible')
    })
  })

  describe('Integration with Page', () => {

    it('should handle multiple selector instances', () => {
      cy.get('p a').filter(':contains("Click to open selector")').should('have.length.gte', 1)
    })

    it('should support modified options selector', () => {
      cy.contains('Click to open selector with modified options').should('exist')
    })
  })

  describe('Accessibility', () => {

    it('should have proper ARIA attributes on modal', () => {
      cy.get('.license-selector').should('have.attr', 'role', 'dialog')
    })

    it('should have aria-hidden attribute', () => {
      cy.get('.license-selector').should('have.attr', 'aria-hidden')
    })

    it('should have tabindex on modal', () => {
      cy.get('.license-selector').should('have.attr', 'tabindex', '-1')
    })

    it('should have focusable buttons', () => {
      cy.get('.ls-question-answers button').first().should('be.visible')
        .and('not.be.disabled')
    })
  })
})
